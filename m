Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWBBLEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWBBLEh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 06:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWBBLEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 06:04:36 -0500
Received: from host2092.kph.uni-mainz.de ([134.93.134.92]:20408 "EHLO
	a1i15.kph.uni-mainz.de") by vger.kernel.org with ESMTP
	id S1750709AbWBBLEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 06:04:36 -0500
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: linux-kernel@vger.kernel.org, Mark Lord <lkml@rtr.ca>,
       Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Byron Stanoszek <gandalf@winds.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH ]  VMSPLIT config options (with default config fixed)
References: <20060110132957.GA28666@elte.hu> <20060110133728.GB3389@suse.de>
 <Pine.LNX.4.63.0601100840400.9511@winds.org> <20060110143931.GM3389@suse.de>
 <Pine.LNX.4.64.0601100804380.4939@g5.osdl.org> <43C3E9C2.1000309@rtr.ca>
 <20060110173217.GU3389@suse.de> <43C3F0CA.10205@rtr.ca>
 <43C403BA.1050106@pobox.com> <43C40803.2000106@rtr.ca>
 <20060201222314.GA26081@MAIL.13thfloor.at>
Date: Thu, 2 Feb 2006 12:04:00 +0100
From: ulm@kph.uni-mainz.de (Ulrich Mueller)
Message-ID: <uhd7irpi7@a1i15.kph.uni-mainz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 01 Feb 2006, Herbert Poetzl wrote:

> glad to see that the linux kernel is now ready for the 'idea'
> I submitted a patch[1] for, more than a year ago -- which
> unfortunately went unnoticed back then ...

> [1] http://lkml.org/lkml/2004/10/9/126

Hm, I wonder if we could have a more fine-grained choice of the
boundary? There are also systems around with e.g. 1.25G or 1.5G of
main memory.

The following patch is against 2.6.16-rc1-mm4 and allows for steps of
256M between 1G and 3G.

Cheers
Uli


Signed-off-by: Ulrich Mueller <ulm@kph.uni-mainz.de>

diff -Nur linux-2.6.16-rc1-mm4.orig/arch/i386/Kconfig linux-2.6.16-rc1-mm4/arch/i386/Kconfig
--- linux-2.6.16-rc1-mm4.orig/arch/i386/Kconfig	2006-01-31 16:43:11.000000000 +0100
+++ linux-2.6.16-rc1-mm4/arch/i386/Kconfig	2006-01-31 17:16:44.000000000 +0100
@@ -470,18 +470,33 @@
 
 	config VMSPLIT_3G
 		bool "3G/1G user/kernel split"
-	config VMSPLIT_3G_OPT
-		bool "3G/1G user/kernel split (for full 1G low memory)"
+	config VMSPLIT_2G75
+		bool "2.75G/1.25G user/kernel split (for full 1G low memory)"
+	config VMSPLIT_2G5
+		bool "2.5G/1.5G user/kernel split"
+	config VMSPLIT_2G25
+		bool "2.25G/1.75G user/kernel split"
 	config VMSPLIT_2G
 		bool "2G/2G user/kernel split"
+	config VMSPLIT_1G75
+		bool "1.75G/2.25G user/kernel split (for full 2G low memory)"
+	config VMSPLIT_1G5
+		bool "1.5G/2.5G user/kernel split"
+	config VMSPLIT_1G25
+		bool "1.25G/2/75G user/kernel split"
 	config VMSPLIT_1G
 		bool "1G/3G user/kernel split"
 endchoice
 
 config PAGE_OFFSET
 	hex
-	default 0xB0000000 if VMSPLIT_3G_OPT
-	default 0x78000000 if VMSPLIT_2G
+	default 0xB0000000 if VMSPLIT_2G75
+	default 0xA0000000 if VMSPLIT_2G5
+	default 0x90000000 if VMSPLIT_2G25
+	default 0x80000000 if VMSPLIT_2G
+	default 0x70000000 if VMSPLIT_1G75
+	default 0x60000000 if VMSPLIT_1G5
+	default 0x50000000 if VMSPLIT_1G25
 	default 0x40000000 if VMSPLIT_1G
 	default 0xC0000000
 
