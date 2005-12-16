Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbVLPK7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbVLPK7M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 05:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbVLPK7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 05:59:12 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:26768 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751249AbVLPK7L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 05:59:11 -0500
Date: Fri, 16 Dec 2005 11:58:52 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: swsusp: documentation fixes
Message-ID: <20051216105852.GJ8476@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation and printk updates. Document "modular SATA" trap.

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit bd607a6d78db651cf6e4b199eae3476f4c935db6
tree 5a781c7cfcfb78a3d3cab2c518ea00bf46ab6e6f
parent 45a5301637600fc7e517c3308e957b3fac7cfd86
author <pavel@amd.(none)> Fri, 16 Dec 2005 11:45:58 +0100
committer <pavel@amd.(none)> Fri, 16 Dec 2005 11:45:58 +0100

 Documentation/power/swsusp.txt |   18 +++++++++++-------
 Documentation/power/video.txt  |    1 +
 kernel/power/swsusp.c          |    2 +-
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/Documentation/power/swsusp.txt b/Documentation/power/swsusp.txt
--- a/Documentation/power/swsusp.txt
+++ b/Documentation/power/swsusp.txt
@@ -27,13 +27,11 @@ echo shutdown > /sys/power/disk; echo di
 
 echo platform > /sys/power/disk; echo disk > /sys/power/state
 
-
-Encrypted suspend image:
-------------------------
-If you want to store your suspend image encrypted with a temporary
-key to prevent data gathering after resume you must compile
-crypto and the aes algorithm into the kernel - modules won't work
-as they cannot be loaded at resume time.
+. If you have SATA disks, you'll need recent kernels with SATA suspend
+support. For suspend and resume to work, make sure your disk drivers
+are built into kernel -- not modules. [There's way to make
+suspend/resume with modular disk drivers, see FAQ, but you should
+better not do that.]
 
 
 Article about goals and implementation of Software Suspend for Linux
@@ -328,4 +326,10 @@ init=/bin/bash, then swapon and starting
 usually does the trick. Then it is good idea to try with latest
 vanilla kernel.
 
+Q: How can RH ship a swsusp-supporting kernel with modular SATA
+drivers?
 
+A: Well, it can be done, load the drivers, then do echo into resume
+file from initrd. Be sure not to mount anything, not even read-only
+mount, or you are going to loose your filesystem same way Dave Jones
+did.
diff --git a/Documentation/power/video.txt b/Documentation/power/video.txt
--- a/Documentation/power/video.txt
+++ b/Documentation/power/video.txt
@@ -132,6 +132,7 @@ Sony Vaio PCG-F403		??? (*)
 Sony Vaio PCG-N505SN		??? (*)
 Sony Vaio PCG-GRT995MP		none (1), works with 'nv' X driver
 Sony Vaio vgn-s260		X or boot-radeon can init it (5)
+Sony Vaio vgn-S580BH		vga=normal, but suspend from X. Console will be blank unless you return to X. 
 Sony Vaio vgn-FS115B		s3_bios (2),s3_mode (4)
 Toshiba Libretto L5		none (1)
 Toshiba Portege 3020CT		s3_mode (3)
diff --git a/kernel/power/swsusp.c b/kernel/power/swsusp.c
--- a/kernel/power/swsusp.c
+++ b/kernel/power/swsusp.c
@@ -988,7 +988,7 @@ int swsusp_check(void)
 	if (!error)
 		pr_debug("swsusp: resume file found\n");
 	else
-		pr_debug("swsusp: Error %d check for resume file\n", error);
+		pr_debug("swsusp: Error %d checking for resume file (are your disk drivers built-in?)\n", error);
 	return error;
 }
 

-- 
Thanks, Sharp!
