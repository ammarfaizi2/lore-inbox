Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129410AbQLEAAI>; Mon, 4 Dec 2000 19:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129547AbQLDX76>; Mon, 4 Dec 2000 18:59:58 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:54115 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129410AbQLDX7m>; Mon, 4 Dec 2000 18:59:42 -0500
Subject: Re: 2.4.0-test12-pre4 + cs46xx + KDE 2.0 = frozen system
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Mon, 4 Dec 2000 23:29:24 +0000 (GMT)
Cc: scole@lanl.gov, linux-kernel@vger.kernel.org
In-Reply-To: <E1434wZ-0004Tn-00@the-village.bc.nu> from "Alan Cox" at Dec 04, 2000 11:22:46 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14352z-0004UZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Crystal 4280/461x + AC97 Audio, version 0.14, 13:39:25 Dec  4 2000
> > cs461x: Card found at 0xf8ffe000 and 0xf8e00000, IRQ 18
> > cs461x: Unknown card (FFFFFFFF:FFFFFFFF) at 0xf8ffe000/0xf8e00000, IRQ 18
> > ac97_codec: AC97 Audio codec, id: 0x4352:0x5914 (Unknown)
> 
> This is failing to detect the CS46xx. I assume someone has fiddled with the
> driver. Does it work correctly on your machine in 2.2.18pre24 ?

A follow on question. This may be 2.4 PCI changes. That would mean you might
want..

--- drivers/sound/cs46xx.c~	Sat Dec  2 01:44:21 2000
+++ drivers/sound/cs46xx.c	Mon Dec  4 22:58:58 2000
@@ -2534,6 +2534,11 @@
 	struct cs_card *card;
 	struct cs_card_type *cp = &cards[0];
 
+	if (pci_enable_device(pci_dev)<0)
+	{
+		printk(KERN_ERR "cs461x: unable to enable\n");
+		return -EIO;
+	}
 	if ((card = kmalloc(sizeof(struct cs_card), GFP_KERNEL)) == NULL) {
 		printk(KERN_ERR "cs461x: out of memory\n");
 		return -ENOMEM;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
