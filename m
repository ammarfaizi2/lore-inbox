Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262452AbTAFL6e>; Mon, 6 Jan 2003 06:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263837AbTAFL6e>; Mon, 6 Jan 2003 06:58:34 -0500
Received: from pc-62-31-66-84-ed.blueyonder.co.uk ([62.31.66.84]:42624 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S262452AbTAFL6d>; Mon, 6 Jan 2003 06:58:33 -0500
Subject: Re: 2.4.21-pre2 stalls out when running unixbench
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Joe Korty <joe.korty@ccur.com>, Andreas Dilger <adilger@clusterfs.com>,
       rusty@rustcorp.com.au, riel@conectiva.com.br,
       linux-kernel@vger.kernel.org, hch@sgi.com
In-Reply-To: <3E16C171.BFEA45AE@digeo.com>
References: <3E15F2F5.356A933D@digeo.com> from "Andrew Morton" at Jan 03,
	2003 12:30:45 PM <200301040111.BAA00401@rudolph.ccur.com> 
	<3E16C171.BFEA45AE@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Jan 2003 12:10:42 +0000
Message-Id: <1041855042.2690.2.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 2003-01-04 at 11:11, Andrew Morton wrote:

> This is because of differences in how sync() is handled between 2.4.20's
> ext3 and 2.4.21-pre2's.
> 
> 2.4.21-pre2:
> 
>   sync() will start the commit, and will wait on it.  So you know that
>   when it returns, everything which was dirty is now tight on disk.
> 
> So yes, running a looping sync while someone else is writing stuff
> will take much longer in 2.4.21-pre2, because that kernel actually
> waits on the writeout.

Actually, I'm wondering if we should back that particular bit out.  For
a user with a hundred mounted filesystems, syncing each one in order,
sequentially, is going to suck (and we don't currently have a simple way
in 2.4 to detect which syncs are on separate spindles and so can be
parallelised.)

--Stephen

