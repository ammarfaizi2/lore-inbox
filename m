Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131449AbRCKSG3>; Sun, 11 Mar 2001 13:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131450AbRCKSGU>; Sun, 11 Mar 2001 13:06:20 -0500
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:8709 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id <S131449AbRCKSGE>; Sun, 11 Mar 2001 13:06:04 -0500
Date: Sun, 11 Mar 2001 18:05:15 +0000
From: Roger Gammans <roger@computer-surgery.co.uk>
To: linux-kernel@vger.kernel.org
Subject: [patch] Simple serial fix for idiots at the lilo prompt.
Message-ID: <20010311180515.A28546@knuth.computer-surgery.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

If you don't pay attention (yeah, I know) Its easy to write
kernel commond lines like 'console=ttyS0, console=.., etc'

The lack of a baud rate after the comma causes the kernel
to panic. The patch below will cause the kernel in treat the
non-existant baud rate specifier as the default without panicing.


--- ../linux-2.2+lvm/drivers/char/serial.c	Sat Jun 10 16:04:13 2000
+++ drivers/char/serial.c	Sun Mar 11 17:51:02 2001
@@ -3490,6 +3490,10 @@
 		case 9600:
 		default:
 			cflag |= B9600;
+			/*
+			 * Set this to a sane value to prevent a divide error
+			 */
+			baud  = 9600;
 			break;
 	}
 	switch(bits) {

TTFN
-- 
Roger
     Think of the mess on the carpet. Sensible people do all their
     demon-summoning in the garage, which you can just hose down afterwards.
        --     damerell@chiark.greenend.org.uk
	
