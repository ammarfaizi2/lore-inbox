Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281469AbRKHFKS>; Thu, 8 Nov 2001 00:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281472AbRKHFKK>; Thu, 8 Nov 2001 00:10:10 -0500
Received: from ilm.mech.unsw.EDU.AU ([129.94.171.100]:35853 "EHLO
	ilm.mech.unsw.edu.au") by vger.kernel.org with ESMTP
	id <S281469AbRKHFJz>; Thu, 8 Nov 2001 00:09:55 -0500
Date: Thu, 8 Nov 2001 16:09:38 +1100
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org, Ian Maclaine-cross <iml@debian.org>
Subject: Re: PROBLEM: Linux updates RTC secretly when clock synchronizes
Message-ID: <20011108160938.A8855@ilm.mech.unsw.edu.au>
In-Reply-To: <20011031113312.A8738@ilm.mech.unsw.edu.au> <20011102121602.A45@toy.ucw.cz> <20011106112052.A10721@ilm.mech.unsw.edu.au> <20011106111846.D26034@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011106111846.D26034@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.3.23i
From: Ian Maclaine-cross <iml@ilm.mech.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
On Tue, Nov 06, 2001 at 11:18:46AM +0100, Pavel Machek wrote:
[snip] 
> > I agree with you, Pavel. Commenting out the 11 minute update
> > code is a better solution. :)
> 
> Are you going to try to push patch trhough linus?

Yes, I will prepare a patch for the 2.5 series. Thanks to all for
their contributions.

Please find following a short, crude and preliminary, 2.4.12 i386
patch which I am now testing on my AMD K6-III machine.  Reasons for
commenting out the 11 minute update code are in my previous
linux-kernel email. My patched compressed kernel is 156 bytes smaller.
It has been running normally with clock synchronized to NTP for two
days and has left the RTC to drift freely.

diff -u --recursive linux.old/arch/i386/kernel/time.c linux/arch/i386/kernel/time.c
--- linux.old/arch/i386/kernel/time.c	Tue Sep 18 16:03:09 2001
+++ linux/arch/i386/kernel/time.c	Tue Nov  6 21:03:46 2001
@@ -313,6 +313,8 @@
 	write_unlock_irq(&xtime_lock);
 }
 
+#ifdef UPDATE_RTC
+
 /*
  * In order to set the CMOS clock precisely, set_rtc_mmss has to be
  * called 500 ms after the second nowtime has started, because when
@@ -384,6 +386,8 @@
 /* last time the cmos clock got updated */
 static long last_rtc_update;
 
+#endif
+
 int timer_ack;
 
 /*
@@ -426,6 +430,8 @@
 		smp_local_timer_interrupt(regs);
 #endif
 
+#ifdef UPDATE_RTC
+
 	/*
 	 * If we have an externally synchronized Linux clock, then update
 	 * CMOS clock accordingly every ~11 minutes. Set_rtc_mmss() has to be
@@ -440,6 +446,7 @@
 		else
 			last_rtc_update = xtime.tv_sec - 600; /* do it again in 60 s */
 	}
+#endif
 	    
 #ifdef CONFIG_MCA
 	if( MCA_bus ) {





-- 
Regards,
Ian Maclaine-cross (iml@debian.org)
