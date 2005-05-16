Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbVEPCZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVEPCZH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 22:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVEPCZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 22:25:07 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:409 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261242AbVEPCY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 22:24:59 -0400
Date: Mon, 16 May 2005 04:24:58 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Disk write cache (Was: Hyper-Threading Vulnerability)
In-Reply-To: <200505152156.18194.gene.heskett@verizon.net>
Message-ID: <Pine.LNX.4.58.0505160414170.6560@artax.karlin.mff.cuni.cz>
References: <1115963481.1723.3.camel@alderaan.trey.hu>
 <200505151121.36243.gene.heskett@verizon.net> <20050515152956.GA25143@havoc.gtf.org>
 <200505152156.18194.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 15 May 2005, Gene Heskett wrote:

> >There is a large amount of yammering and speculation in this thread.
>
> I agree, and frankly I'm just another  of the yammerers as I don't
> have the clout to be otherwise.
>
> >Most disks do seem to obey SYNC CACHE / FLUSH CACHE.
> >
> > Jeff
>
> I don't think I have any drives here that do obey that, Jeff.  I got
> curious about this, oh, maybe a year back when this discussion first
> took place on another list, and wrote a test gizmo that copied a
> large file, then slept for 1 second and issued a sync command.  No
> drive led activity until the usual 5 second delay of the filesystem
> had expired.  To me, that indicated that the sync command was being
> returned as completed without error and I had my shell prompt back
> long before the drives leds came on.  Admittedly that may not be a
> 100% valid test, but I really did expect to see the leds come on as
> the sync command was executed.
>
> I also have some setup stuff for heyu that runs at various times of
> the day, reconfigureing how heyu and xtend run 3 times a day here,
> which depends on a valid disk file, and I've had to use sleeps for
> guaranteeing the proper sequencing, where if the sync command
> actually worked, I could get the job done quite a bit faster.
>
> Again, probably not a valid test of the sync command, but thats the
> evidence I have.  I do not believe it works here, with any of the 5
> drives currently spinning in these two boxes.

Note, that Linux can't send FLUSH CACHE command at all (until very recent
2.6 kernels). So write cache is always dangerous under Linux, no matter if
disk is broken or not.

Another note: according to posix, sync() is asynchronous --- i.e. it
initiates write, but doesn't have to wait for complete. In linux, sync()
waits for writes to complete, but it doesn't have to in other OSes.

Mikulas

> --
> Cheers, Gene
> "There are four boxes to be used in defense of liberty:
>  soap, ballot, jury, and ammo. Please use in that order."
> -Ed Howdershelt (Author)
> 99.34% setiathome rank, not too shabby for a WV hillbilly
> Yahoo.com and AOL/TW attorneys please note, additions to the above
> message by Gene Heskett are:
> Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
