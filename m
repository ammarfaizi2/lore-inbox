Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268946AbTCARPW>; Sat, 1 Mar 2003 12:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268949AbTCARPW>; Sat, 1 Mar 2003 12:15:22 -0500
Received: from science.horizon.com ([192.35.100.1]:60211 "HELO
	science.horizon.com") by vger.kernel.org with SMTP
	id <S268946AbTCARPV>; Sat, 1 Mar 2003 12:15:21 -0500
Date: 1 Mar 2003 17:25:39 -0000
Message-ID: <20030301172539.15346.qmail@science.horizon.com>
From: linux@horizon.com
To: mikpe@user.it.uu.se
Subject: Re: Playing with 2.5.63: APM blanking and "bio too big"
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200303011658.h21GwTwu027100@harpo.it.uu.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>* I had real problems with APM screen blanking enabled.  It reliably
>>  and repeatedly locked the machine HARD (no keyboard, no SysRq, no ping)
>>  when the scren blanker kicked in or trying to switch from X.  This is
>>  an Athlon on a KT133 Motherboard.  No problems in 2.4.  APM can corectly
>>  power the machine off, however.

> Do you have CONFIG_X86_UP_APIC=y?

Right in one!

> To verify, hack apic.c and ensure that "dont_enable_local_apic_timer"
> is initialised to 1. Also don't enable the NMI watchdog.

I'll try that.  Thanks!

> Another option, which is what I use now on all my local-APIC capable
> machines, is to disable APM_DISPLAY_BLANK.

What I'm running now, and now that I understand, probably preferable.
Maybe a warning in Configure.help?

--- arch/i386/Kconfig   2003-02-24 14:05:10.000000000 -0500
+++ arch/i386/Kconfig.new       2003-03-01 12:23:59.000000000 -0500
@@ -922,6 +922,10 @@
 	  backlight at all, or it might print a lot of errors to the console,
 	  especially if you are using gpm.
 
+	  This also tends to interact badly with use of the local APIC.
+	  You probably don't want this option unless you are building
+	  for a laptop that you intend to use in text mode.
+
 config APM_RTC_IS_GMT
 	bool "RTC stores time in GMT"
 	depends on APM


Or should Linux mask the APIC timer before making the APM call?

> I really despise BIOS writers.

The BIOS interface is... non-obvious.
