Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbWBZXI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbWBZXI2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 18:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbWBZXI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 18:08:28 -0500
Received: from smtpq2.groni1.gr.home.nl ([213.51.130.201]:45451 "EHLO
	smtpq2.groni1.gr.home.nl") by vger.kernel.org with ESMTP
	id S932232AbWBZXI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 18:08:27 -0500
Message-ID: <44023520.8020009@keyaccess.nl>
Date: Mon, 27 Feb 2006 00:09:20 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [TRIVIAL] move PP_MAJOR from ppdev.h to major.h
Content-Type: multipart/mixed;
 boundary="------------090406010501060707080605"
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090406010501060707080605
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew.

Is this okay? Today I wondered about /dev/parport<n> after not seeing 
anything in drivers/parport register char-major-99. Having PP_MAJOR in 
include/linux/major.h would've allowed me to more quickly determine that 
it was the ppdev driver driving these.

Rene


--------------090406010501060707080605
Content-Type: text/plain;
 name="ppdev_cleanup.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppdev_cleanup.diff"

Index: local/drivers/char/ppdev.c
===================================================================
--- local.orig/drivers/char/ppdev.c	2006-01-03 04:21:10.000000000 +0100
+++ local/drivers/char/ppdev.c	2006-02-26 20:41:04.000000000 +0100
@@ -65,10 +65,11 @@
 #include <linux/parport.h>
 #include <linux/ctype.h>
 #include <linux/poll.h>
-#include <asm/uaccess.h>
+#include <linux/major.h>
 #include <linux/ppdev.h>
 #include <linux/smp_lock.h>
 #include <linux/device.h>
+#include <asm/uaccess.h>
 
 #define PP_VERSION "ppdev: user-space parallel port driver"
 #define CHRDEV "ppdev"
Index: local/include/linux/major.h
===================================================================
--- local.orig/include/linux/major.h	2006-01-03 04:21:10.000000000 +0100
+++ local/include/linux/major.h	2006-02-26 20:40:00.000000000 +0100
@@ -113,6 +113,7 @@
 
 #define UBD_MAJOR		98
 
+#define PP_MAJOR		99
 #define JSFD_MAJOR		99
 
 #define PHONE_MAJOR		100
Index: local/include/linux/ppdev.h
===================================================================
--- local.orig/include/linux/ppdev.h	2006-01-03 04:21:10.000000000 +0100
+++ local/include/linux/ppdev.h	2006-02-26 20:39:04.000000000 +0100
@@ -14,8 +14,6 @@
  * Added PPGETMODES/PPGETMODE/PPGETPHASE, Fred Barnes <frmb2@ukc.ac.uk>, 03/01/2001
  */
 
-#define PP_MAJOR	99
-
 #define PP_IOCTL	'p'
 
 /* Set mode for read/write (e.g. IEEE1284_MODE_EPP) */

--------------090406010501060707080605--
