Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266574AbUITOIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266574AbUITOIb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 10:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266572AbUITOIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 10:08:31 -0400
Received: from f25.mail.ru ([194.67.57.151]:38671 "EHLO f25.mail.ru")
	by vger.kernel.org with ESMTP id S266603AbUITOHl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 10:07:41 -0400
From: 1 1 <anoy@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: via82xx sound drivers patch
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: 192.168.1.1 via proxy [212.46.202.194]
Date: Mon, 20 Sep 2004 18:07:37 +0400
Reply-To: 1 1 <anoy@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1C9OpN-0001VE-00.anoy-mail-ru@f25.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good time of day!
I have tested my MB GA-7VAX and want to say you that you should use
VIA_DXS_ENABLE instead VIA_DXS_NO_VRA. On the maximum volume output level
with VIA_DXS_NO_VRA there is abnormal loud noise, and with VIA_DXS_ENABLE
there are much less noises. And I have detected unused code section.
With respect, Pantenkov Sergey.
Here is the patch.
=======================================================================
--- linux-2.6/sound/pci/via82xx.c	2004-08-30 02:26:35.000000000 +0400
+++ linux-2.6_ramsez/sound/pci/via82xx.c	2004-09-11 23:42:14.000000000 +0400
@@ -623,11 +623,6 @@
 	unsigned int status;
 	unsigned int i;

-#if 0
-	/* FIXME: does it work on via823x? */
-	if (chip->chip_type != TYPE_VIA686)
-		goto _skip_sgd;
-#endif
 	status = inl(VIAREG(chip, SGD_SHADOW));
 	if (! (status & chip->intr_mask)) {
 		if (chip->rmidi)
@@ -635,7 +630,6 @@
 			return snd_mpu401_uart_interrupt(irq, chip->rmidi->private_data, regs);
 		return IRQ_NONE;
 	}
-// _skip_sgd:

 	/* check status for each stream */
 	spin_lock(&chip->reg_lock);
@@ -2098,7 +2092,7 @@
 		{ .vendor = 0x1106, .device = 0xaa01, .action = VIA_DXS_NO_VRA }, /* EPIA MII */
 		{ .vendor = 0x1297, .device = 0xa232, .action = VIA_DXS_ENABLE }, /* Shuttle ?? */
 		{ .vendor = 0x1297, .device = 0xc160, .action = VIA_DXS_ENABLE }, /* Shuttle SK41G */
-		{ .vendor = 0x1458, .device = 0xa002, .action = VIA_DXS_NO_VRA }, /* Gigabyte GA-7VAXP (FIXME: or DXS_ENABLE?) */
+		{ .vendor = 0x1458, .device = 0xa002, .action = VIA_DXS_ENABLE }, /* Gigabyte GA-7VAXP */
 		{ .vendor = 0x147b, .device = 0x1401, .action = VIA_DXS_ENABLE }, /* ABIT KD7(-RAID) */
 		{ .vendor = 0x14ff, .device = 0x0403, .action = VIA_DXS_ENABLE }, /* Twinhead mobo */
 		{ .vendor = 0x1462, .device = 0x3800, .action = VIA_DXS_ENABLE }, /* MSI KT266 */

