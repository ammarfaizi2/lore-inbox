Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262128AbTCRDR0>; Mon, 17 Mar 2003 22:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262130AbTCRDRZ>; Mon, 17 Mar 2003 22:17:25 -0500
Received: from packet.digeo.com ([12.110.80.53]:24709 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262128AbTCRDRZ>;
	Mon, 17 Mar 2003 22:17:25 -0500
Date: Mon, 17 Mar 2003 19:27:38 -0800
From: Andrew Morton <akpm@digeo.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: gilbertd@treblig.org, linux-kernel@vger.kernel.org, ext3-users@redhat.com
Subject: Re: 2.4.20: ext3/raid5 - allocating block in system zone/multiple 1
 requests for sector
Message-Id: <20030317192738.6a420ed0.akpm@digeo.com>
In-Reply-To: <15990.28660.687262.457216@notabene.cse.unsw.edu.au>
References: <20030316150148.GC1148@gallifrey>
	<15990.28660.687262.457216@notabene.cse.unsw.edu.au>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Mar 2003 03:27:31.0934 (UTC) FILETIME=[4F7E97E0:01C2ECFE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown <neilb@cse.unsw.edu.au> wrote:
>
> These two symptoms strongly suggest a buffer aliasing problem.
> i.e. you have two buffers (one for data and one for metadata)
> that refer to the same location on disc.
> One is part of a file that was recently deleted, but the buffer hasn't
> been flushed yet.  The other is part of a new directory.
> The old buffer and the new buffer both get written to disc at much the
> same time (hence the "multiple 1 requests"), but the old buffer hits
> the disc second and so corrupts the filesystem.

This aliasing can happen very easily with direct-io, and it is something
which drivers should be able to cope with.

I hope RAID is not still assuming that all requests are unique in this way?

