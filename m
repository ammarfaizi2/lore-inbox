Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129136AbRBCUPD>; Sat, 3 Feb 2001 15:15:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129235AbRBCUOx>; Sat, 3 Feb 2001 15:14:53 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:41810 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S129136AbRBCUOr>; Sat, 3 Feb 2001 15:14:47 -0500
Message-ID: <3A7C64F9.F3192611@sgi.com>
Date: Sat, 03 Feb 2001 12:07:21 -0800
From: LA Walsh <law@sgi.com>
Organization: Trust Technology, SGI
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.4.0 i686)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Delta <birtl00@dmi.usherb.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: System unresponsitive when copying HD/HD
In-Reply-To: <3A7B1129.2ED4CCE4@dmi.usherb.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've noticed less responsive disk response on 2.4.0 vs. 2.2.17.  For example --
I run vmware and suspend it frequently when I'm not using it.  One of them requires
a 158Mb save file.  Before, I could suspend that one, then start another which
reads in a smaller 50M save file.  The smaller one would come up while the other
was still saving.  As of 2.4, the smaller one doesn't come up -- I can't even do
an 'ls' until the big save finishes.  

Now big image program has actually exited and I can close the window -- the disk
writes are going on from the disk cache with 'kupdate' taking some minor fraction (<1%)
of the CPU and the rest of the system being mostly idle.

If I have vmstat running, I notice blocks trickling out to the disk, 5sec averages
495,142,151,155,136,257,15,0.  Note that the maximum read rate (hdparm -t) of this
disk is in the 12-14M/s range.  I'm getting about 1-5% of that on output with the
system's disk subsystem being apparently unable to do anything else.

This is with IDE hard disk with DMA enabled.

a) is this expected performance on a large linear write?  
b) should I expect other disk operations to be denied service as long as
	the write is 'flushing'?

-l
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
