Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265475AbSLCTK7>; Tue, 3 Dec 2002 14:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265480AbSLCTK7>; Tue, 3 Dec 2002 14:10:59 -0500
Received: from gold.MUSKOKA.COM ([216.123.107.5]:14610 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id <S265475AbSLCTK5>;
	Tue, 3 Dec 2002 14:10:57 -0500
Message-ID: <3DED0076.55B970DD@yahoo.com>
Date: Tue, 03 Dec 2002 14:05:26 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 4.51 [en] (X11; I; Linux 2.2.20 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: Bill Davidsen <davidsen@tmr.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] deprecate use of bdflush()
References: <Pine.LNX.3.96.1021203091821.5578A-100000@gatekeeper.tmr.com> <1038935401.994.9.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> On Tue, 2002-12-03 at 09:24, Bill Davidsen wrote:
> 
> > My take on this is that it's premature. This would be fine in the 2.6.0-rc
> > series, but the truth is that the majority of 2.5 users boot 2.5 for
> > testing but run 2.4 for normal use. They aren't going to get rid of
> > bdflush and this just craps up the logs. At least with the occurrence
> > limit it will only happen a few times. I would like to see it once only,
> > myself, as a reminder rather than a nag.
> 
> 2.4 does not need bdflush, either.
> 
> Bdflush the user-space daemon went away a long time ago, ~1995.

Yes, removal is not premature; long overdue if anything.  At the risk
of overlapping Andries' job as official historian, I found this in my
archive of cruft.  So it was almost 1996  :)

Paul.

--

 Date: Fri, 22 Dec 1995 07:59:40 +0200
 From: Linus Torvalds <Linus.Torvalds@cs.Helsinki.FI>
 Message-Id: <199512220559.HAA25383@keos.cs.Helsinki.FI>
 In-Reply-To: Paul Gortmaker's message as of Dec 22,  3:13
 To: Paul Gortmaker <gpg109@rsphy1.anu.edu.au>, linux-kernel@vger.rutgers.edu
 Subject: Re: Ramdisk fixes for 1.3.49
 Status: RO

Paul Gortmaker: "Ramdisk fixes for 1.3.49" (Dec 22,  3:13):
> 
> I don't know if anyone noticed, but I came across this while impementing
> the CONFIG_BLK_DEV_RAM. 
> 
> The new ramdisk code has an ugly hack (IMHO) where it uses the global 
> variable rd_loading for the *sole purpose* of blocking the 
> 
> 	"Warning - bdflush not running." 
> 
> message (buffer.c) while loading the image off of the floppy. Eeecch.
> Rather than have this ramdisk dependant cruft in buffer.c, I fixed this
> in a much better fashion. The solution is simple. We just call
> sync_dev(ramdisk) ourselves every so often while writing the floppy
> contents to the ramdisk. By doing this, wakeup_bdflush() never gets
> tripped, and thus no "Warning - bdflush not running." messages pop out.
> And buffer.c doesn't get touched. Nice and clean.

I'd prefer it even more if you'd just start "bdflush" instead. 

I know that user-level isn't running yet, but it should be reasonably
trivial to do

	kernel_thread(sys_bdflush, NULL);

and off you go..  Could you try this instead? I'd be happer (this is how
bdflush should have been started in the first place, but back when
bdflush was done there were no easy access to kernel threads..)

(oh, btw, in the meantime I applied this set of patches, because they
are better than it used to be.  But I'd be grateful for a new set on top
of this that does the above, hint, hint). 

		Linus



