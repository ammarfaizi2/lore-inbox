Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263792AbTKRWWI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 17:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263800AbTKRWWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 17:22:08 -0500
Received: from gprs150-18.eurotel.cz ([160.218.150.18]:1920 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263792AbTKRWWD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 17:22:03 -0500
Date: Tue, 18 Nov 2003 23:22:26 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Pontus Fuchs <pof@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org, hubicka@atrey.karlin.mff.cuni.cz
Subject: Re: Announce: ndiswrapper
Message-ID: <20031118222226.GA282@elf.ucw.cz>
References: <1069153340.2200.28.camel@dhcp-225.mlm.tactel.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1069153340.2200.28.camel@dhcp-225.mlm.tactel.se>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Since some vendors refuses to release specs or even a binary
> Linux-driver for their WLAN cards I desided to try to solve it myself by
> making a kernel module that can load Ndis (windows network driver API)
> drivers. I'm not trying to implement all of the Ndis API but rather
> implement the functions needed to get these unsupported cards working.
> 
> Currently it works fine with my Broadcom 4301 but I would like to get in
> touch with people that have similar cards that are willing to do some
> testing/hacking.

Wow, works for me, Broadcom 94306. [Well, I do not have second wifi to
test right now, but module loads, I can iwconfig it etc.] I'd add this
to the docs:


Index: README
===================================================================
RCS file: /cvsroot/ndiswrapper/ndiswrapper/README,v
retrieving revision 1.1
diff -u -u -r1.1 README
--- README	17 Nov 2003 13:23:36 -0000	1.1
+++ README	18 Nov 2003 22:19:22 -0000
@@ -4,8 +4,11 @@
 1. Compile the driver
 ---------------------
 * You need kernel 2.6.0-test8 or higher!
-* Make sure your kernel complied without framepointer and Sleep-inside-spinlock debugging
-  See the kernel hacking menu
+* Make sure your kernel complied without framepointer
+  (CONFIG_FRAME_POINTER unset) and Sleep-inside-spinlock 
+  debugging (CONFIG_DEBUG_SPINLOCK unset). (See the kernel hacking menu)
+* do make modules_install
+* make sure you are not cross-compiling
 > cd driver
 > make
 

And perhaps this script gets usefull? [Fancy version might download
that package using wget then unzip it ;-).]

								Pavel

#!/bin/bash
if zcat /proc/config.gz | grep CONFIG_FRAME_POINTER=y; then
	echo Turn off CONFIG_FRAME_POINTER
	fi
if zcat /proc/config.gz | grep CONFIG_DEBUG_SPINLOCK=y; then
	echo Turn off CONFIG_DEBUG_SPINLOCK
	fi
(
	cd driver
	make
)
(
	cd utils
	make
)
if lspci | grep "Broadcom Corporation BCM94306"; then
	echo "This one should work, good."
	insmod driver/ndiswrapper.ko
	echo "Get R65194.EXE and unpack it here."
	utils/loaddriver 14e4 4320 R65194/TMSetup/bcmwl5.sys R65194/TMSetup/bcmwl5.inf
	fi


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
