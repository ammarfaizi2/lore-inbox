Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266116AbTAFNId>; Mon, 6 Jan 2003 08:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266353AbTAFNIc>; Mon, 6 Jan 2003 08:08:32 -0500
Received: from pc-62-31-66-84-ed.blueyonder.co.uk ([62.31.66.84]:12417 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S266116AbTAFNIc>; Mon, 6 Jan 2003 08:08:32 -0500
Subject: Re: 2.4.21-pre2 stalls out when running unixbench
From: "Stephen C. Tweedie" <sct@redhat.com>
To: John Bradford <john@grabjohn.com>
Cc: Andrew Morton <akpm@digeo.com>, joe.korty@ccur.com,
       Andreas Dilger <adilger@clusterfs.com>, rusty@rustcorp.com.au,
       riel@conectiva.com.br, linux-kernel@vger.kernel.org, hch@sgi.com,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <200301061215.h06CFheY001499@darkstar.example.net>
References: <200301061215.h06CFheY001499@darkstar.example.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Jan 2003 13:20:35 +0000
Message-Id: <1041859235.2690.48.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2003-01-06 at 12:15, John Bradford wrote:

> What!?  I'm suprised that no userspace applications were broken by
> sync returning before the data is safely on oxide, even though it
> doesn't violate the POSIX spec.

sync(2) syncs _everything_ --- every M/O or floppy disk, every
filesystem no matter if it's fat or native Unix.  It's way too
heavyweight for most applications which have synchronisation
requirements, when fsync() or O_SYNC are much more precise.

I think I can recall one or two mutterings about people worried about
theoretical risks of doing things like "lilo; sync; reboot", but that's
a different class of risk altogether.  (It's complicated by the problem
that after a sync, ext3 guarantees that the data and metadata is on
disk, but it may still be in the journal, so lilo won't necessarily see
the right stuff with sync() alone --- ext3 plays extra tricks when it
sees bmap to try to solve this.)

--Stephen

