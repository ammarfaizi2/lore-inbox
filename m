Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbTJOAih (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 20:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262018AbTJOAih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 20:38:37 -0400
Received: from CPE-203-51-31-61.nsw.bigpond.net.au ([203.51.31.61]:7930 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP id S261974AbTJOAie
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 20:38:34 -0400
Message-ID: <3F8C9705.26CA0B63@eyal.emu.id.au>
Date: Wed, 15 Oct 2003 10:38:29 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.23-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: list linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test7: saa7134 breaks on gcc 2.95
Content-Type: multipart/mixed;
 boundary="------------0B02E4EEE4FB686F2776129A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------0B02E4EEE4FB686F2776129A
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This compiler does not like dangling comma in funcs, so this patch
is needed. For:

#define dprintk(fmt, arg...)    if (core_debug) \
	printk(KERN_DEBUG "%s/core: " fmt, dev->name, ## arg)

Lines like this:

	dprintk("hwinit1\n");

should be hacked like this:

	dprintk("hwinit1\n", "");

Or maybe someone knows a better solution.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
--------------0B02E4EEE4FB686F2776129A
Content-Type: text/plain; charset=us-ascii;
 name="2.6.0-test7.saa7134-core.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.6.0-test7.saa7134-core.patch"

--- linux/drivers/media/video/saa7134/saa7134-core.c.orig	Wed Oct 15 10:30:44 2003
+++ linux/drivers/media/video/saa7134/saa7134-core.c	Wed Oct 15 10:31:10 2003
@@ -624,7 +624,7 @@
 /* early init (no i2c, no irq) */
 static int saa7134_hwinit1(struct saa7134_dev *dev)
 {
-	dprintk("hwinit1\n");
+	dprintk("hwinit1\n", "");
 
 	saa_writel(SAA7134_IRQ1, 0);
 	saa_writel(SAA7134_IRQ2, 0);
@@ -675,7 +675,7 @@
 /* late init (with i2c + irq) */
 static int saa7134_hwinit2(struct saa7134_dev *dev)
 {
-	dprintk("hwinit2\n");
+	dprintk("hwinit2\n", "");
 
 	saa7134_video_init2(dev);
 	saa7134_tvaudio_init2(dev);
@@ -703,7 +703,7 @@
 /* shutdown */
 static int saa7134_hwfini(struct saa7134_dev *dev)
 {
-	dprintk("hwfini\n");
+	dprintk("hwfini\n", "");
 
 	switch (dev->pci->device) {
 	case PCI_DEVICE_ID_PHILIPS_SAA7134:

--------------0B02E4EEE4FB686F2776129A--

