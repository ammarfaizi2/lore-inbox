Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbWBELhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWBELhY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 06:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbWBELhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 06:37:24 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:59334 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750747AbWBELhY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 06:37:24 -0500
Date: Sun, 5 Feb 2006 12:37:08 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [patch] suspend: update documentation
Message-ID: <20060205113708.GA2965@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This updates documentation for swsusp / suspend-to-RAM. Parts by Rafael.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/Documentation/power/swsusp.txt b/Documentation/power/swsusp.txt
index b28b7f0..96bbe61 100644
--- a/Documentation/power/swsusp.txt
+++ b/Documentation/power/swsusp.txt
@@ -27,19 +27,18 @@ echo shutdown > /sys/power/disk; echo di
 
 echo platform > /sys/power/disk; echo disk > /sys/power/state
 
+. If you have SATA disks, you'll need recent kernels with SATA suspend
+support. For suspend and resume to work, make sure your disk drivers
+are built into kernel -- not modules. [There's way to make
+suspend/resume with modular disk drivers, see FAQ, but you probably
+should not do that.]
+
 If you want to limit the suspend image size to N bytes, do
 
 echo N > /sys/power/image_size
 
 before suspend (it is limited to 500 MB by default).
 
-Encrypted suspend image:
-------------------------
-If you want to store your suspend image encrypted with a temporary
-key to prevent data gathering after resume you must compile
-crypto and the aes algorithm into the kernel - modules won't work
-as they cannot be loaded at resume time.
-
 
 Article about goals and implementation of Software Suspend for Linux
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -333,4 +332,19 @@ init=/bin/bash, then swapon and starting
 usually does the trick. Then it is good idea to try with latest
 vanilla kernel.
 
+Q: How can distributions ship a swsusp-supporting kernel with modular
+disk drivers (especially SATA)?
+
+A: Well, it can be done, load the drivers, then do echo into
+/sys/power/disk/resume file from initrd. Be sure not to mount
+anything, not even read-only mount, or you are going to lose your
+data.
+
+Q: How do I make suspend more verbose?
+
+A: If you want to see any non-error kernel messages on the virtual
+terminal the kernel switches to during suspend, you have to set the
+kernel console loglevel to at least 4 (KERN_WARNING), for example by
+doing
 
+	echo 4 > /proc/sys/kernel/printk
diff --git a/Documentation/power/video.txt b/Documentation/power/video.txt
index 912bed8..0cd8822 100644
--- a/Documentation/power/video.txt
+++ b/Documentation/power/video.txt
@@ -104,6 +104,7 @@ HP NX7000			??? (*)
 HP Pavilion ZD7000		vbetool post needed, need open-source nv driver for X
 HP Omnibook XE3	athlon version	none (1)
 HP Omnibook XE3GC		none (1), video is S3 Savage/IX-MV
+HP Omnibook 5150		none (1), (S1 also works OK)
 IBM TP T20, model 2647-44G	none (1), video is S3 Inc. 86C270-294 Savage/IX-MV, vesafb gets "interesting" but X work.
 IBM TP A31 / Type 2652-M5G      s3_mode (3) [works ok with BIOS 1.04 2002-08-23, but not at all with BIOS 1.11 2004-11-05 :-(]
 IBM TP R32 / Type 2658-MMG      none (1)
@@ -120,18 +121,24 @@ IBM ThinkPad T42p (2373-GTG)	s3_bios (2)
 IBM TP X20			??? (*)
 IBM TP X30			s3_bios (2)
 IBM TP X31 / Type 2672-XXH      none (1), use radeontool (http://fdd.com/software/radeon/) to turn off backlight.
-IBM TP X32			none (1), but backlight is on and video is trashed after long suspend
+IBM TP X32			none (1), but backlight is on and video is trashed after long suspend. s3_bios,s3_mode (4) works too. Perhaps that gets better results?
 IBM Thinkpad X40 Type 2371-7JG  s3_bios,s3_mode (4)
+IBM TP 600e			none(1), but a switch to console and back to X is needed
 Medion MD4220			??? (*)
 Samsung P35			vbetool needed (6)
-Sharp PC-AR10 (ATI rage)	none (1)
+Sharp PC-AR10 (ATI rage)	none (1), backlight does not switch off
 Sony Vaio PCG-C1VRX/K		s3_bios (2)
 Sony Vaio PCG-F403		??? (*)
+Sony Vaio PCG-GRT995MP		none (1), works with 'nv' X driver
+Sony Vaio PCG-GR7/K		none (1), but needs radeonfb, use radeontool (http://fdd.com/software/radeon/) to turn off backlight.
 Sony Vaio PCG-N505SN		??? (*)
 Sony Vaio vgn-s260		X or boot-radeon can init it (5)
+Sony Vaio vgn-S580BH		vga=normal, but suspend from X. Console will be blank unless you return to X. 
+Sony Vaio vgn-FS115B		s3_bios (2),s3_mode (4)
 Toshiba Libretto L5		none (1)
-Toshiba Satellite 4030CDT	s3_mode (3)
-Toshiba Satellite 4080XCDT      s3_mode (3)
+Toshiba Portege 3020CT		s3_mode (3)
+Toshiba Satellite 4030CDT	s3_mode (3) (S1 also works OK)
+Toshiba Satellite 4080XCDT      s3_mode (3) (S1 also works OK)
 Toshiba Satellite 4090XCDT      ??? (*)
 Toshiba Satellite P10-554       s3_bios,s3_mode (4)(****)
 Toshiba M30                     (2) xor X with nvidia driver using internal AGP
@@ -156,6 +163,9 @@ VBEtool details
 ~~~~~~~~~~~~~~~
 (with thanks to Carl-Daniel Hailfinger)
 
+This is not a generic solution. For some machines, you'll have better
+luck with setting parameters on kernel command line.
+
 First, boot into X and run the following script ONCE:
 #!/bin/bash
 statedir=/root/s3/state

-- 
Thanks, Sharp!
