Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285118AbRLVM6t>; Sat, 22 Dec 2001 07:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286766AbRLVM6j>; Sat, 22 Dec 2001 07:58:39 -0500
Received: from thick.mail.pipex.net ([158.43.192.95]:16092 "HELO
	thick.mail.pipex.net") by vger.kernel.org with SMTP
	id <S285118AbRLVM6X>; Sat, 22 Dec 2001 07:58:23 -0500
From: Chris Rankin <rankincj@yahoo.com>
Message-Id: <200112221258.fBMCwIVl005421@twopit.underworld>
Subject: Linux IA32 microcode driver
To: tigran@veritas.com
Date: Sat, 22 Dec 2001 12:58:18 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am I missing something rather obvious, or is the /dev/cpu/microcode
device being mis-created under devfs with Linux 2.4.x? I have enclosed
a patch to ensure that the character device really *is* a character
device.

Cheers,
Chris

--- linux-2.4.17/arch/i386/kernel/microcode.c.orig	Sat Dec 22 12:37:07 2001
+++ linux-2.4.17/arch/i386/kernel/microcode.c	Sat Dec 22 12:43:10 2001
@@ -125,7 +125,7 @@
 			MICROCODE_MINOR);
 
 	devfs_handle = devfs_register(NULL, "cpu/microcode",
-			DEVFS_FL_DEFAULT, 0, 0, S_IFREG | S_IRUSR | S_IWUSR, 
+			DEVFS_FL_DEFAULT, 0, 0, S_IFCHR | S_IRUSR | S_IWUSR, 
 			&microcode_fops, NULL);
 	if (devfs_handle == NULL && error) {
 		printk(KERN_ERR "microcode: failed to devfs_register()\n");
