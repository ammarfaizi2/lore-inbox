Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263006AbVCXDKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263006AbVCXDKE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 22:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263003AbVCXDJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 22:09:35 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:48145 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261638AbVCXDJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 22:09:01 -0500
Date: Thu, 24 Mar 2005 04:08:58 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/isicom.c: section fixes
Message-ID: <20050324030858.GN1948@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following bugs:
- __exit unregister_ioregion and unregister_drivers were called by
  __init isicom_init
- __init isicom_init was called by __devinit isicom_setup

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 9 Mar 2005

 drivers/char/isicom.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

--- linux-2.6.11-mm2-full/drivers/char/isicom.c.old	2005-03-09 02:05:14.000000000 +0100
+++ linux-2.6.11-mm2-full/drivers/char/isicom.c	2005-03-09 02:22:05.000000000 +0100
@@ -1756,7 +1756,7 @@
 }
 
 
-static int __init register_ioregion(void)
+static int __devinit register_ioregion(void)
 {
 	int count, done=0;
 	for (count=0; count < BOARD_COUNT; count++ ) {
@@ -1771,7 +1771,7 @@
 	return done;
 }
 
-static void __exit unregister_ioregion(void)
+static void unregister_ioregion(void)
 {
 	int count;
 	for (count=0; count < BOARD_COUNT; count++ ) 
@@ -1803,7 +1803,7 @@
 	.tiocmset	= isicom_tiocmset,
 };
 
-static int __init register_drivers(void)
+static int __devinit register_drivers(void)
 {
 	int error;
 
@@ -1834,7 +1834,7 @@
 	return 0;
 }
 
-static void __exit unregister_drivers(void)
+static void unregister_drivers(void)
 {
 	int error = tty_unregister_driver(isicom_normal);
 	if (error)
@@ -1842,7 +1842,7 @@
 	put_tty_driver(isicom_normal);
 }
 
-static int __init register_isr(void)
+static int __devinit register_isr(void)
 {
 	int count, done=0;
 	unsigned long irqflags;
@@ -1883,7 +1883,7 @@
 	}
 }
 
-static int __init isicom_init(void)
+static int __devinit isicom_init(void)
 {
 	int card, channel, base;
 	struct isi_port * port;

