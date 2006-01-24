Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030485AbWAXRKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030485AbWAXRKJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 12:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030471AbWAXRKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 12:10:09 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:49300 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030485AbWAXRKH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 12:10:07 -0500
Date: Tue, 24 Jan 2006 18:08:45 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch] swsusp: documentation updates
Message-ID: <20060124170845.GA1800@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This updates suspend-to-RAM documentation with new machines, and makes
message when processes can't be stopped little clearer. (In one case,
waiting longer actually did help).

Signed-off-by: Pavel Machek <pavel@suse.cz>

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
diff --git a/kernel/power/process.c b/kernel/power/process.c
index 28de118..02a1b3a 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -83,7 +83,7 @@ int freeze_processes(void)
 		yield();			/* Yield is okay here */
 		if (todo && time_after(jiffies, start_time + TIMEOUT)) {
 			printk( "\n" );
-			printk(KERN_ERR " stopping tasks failed (%d tasks remaining)\n", todo );
+			printk(KERN_ERR " stopping tasks timed out (%d tasks remaining)\n", todo );
 			break;
 		}
 	} while(todo);
 

-- 
Thanks, Sharp!
