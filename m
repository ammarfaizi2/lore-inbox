Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316106AbSFET3e>; Wed, 5 Jun 2002 15:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316158AbSFET3d>; Wed, 5 Jun 2002 15:29:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28420 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316106AbSFET3c>;
	Wed, 5 Jun 2002 15:29:32 -0400
Message-ID: <3CFE6644.E70ADB5A@zip.com.au>
Date: Wed, 05 Jun 2002 12:28:04 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Xavier Bestel <xavier.bestel@free.fr>,
        Andreas Dilger <adilger@clusterfs.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] "laptop mode"
In-Reply-To: <3CFD453A.B6A43522@zip.com.au> <20020604233124.GA18668@turbolinux.com> <3CFD50B9.259366F4@zip.com.au> <1023272806.15438.106.camel@bip> <20020605103351.GA15883@suse.de> <3CFDEE17.FD1306A0@zip.com.au> <20020605105346.GC15883@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> ...
> > Yes, it could be per-queue.  That would add complexity to
> > the already-murky fs/fs-writeback.c.  It that justifiable?
> 
> I dunno, it's up to you. I guess this is mainly IDE specific anyways,
> but you apply the same logic to just one (for instance) of your disks on
> a home desktop system.

Well it's a convenience thing.  Not really worth a lot of code.
I expect most of the proposed functionality could be provided
from userspace anyway via the disk IO number in /proc/stat:

	old_counts=get_counters()
	while 1 {
		sleep 5
		if (old_counts != get_counters()) {
			sync
			sleep 10
			old_counts = get_counters()
		}
	}

This doesn't have the "if we flushed for any reason, reset the
timer" optimisation.  But it will work in 2.4.

So I think I'll just settle for making the ext3 journal timer
expiries tunable.

-
