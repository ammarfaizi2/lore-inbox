Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129415AbRACIPU>; Wed, 3 Jan 2001 03:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129507AbRACIPJ>; Wed, 3 Jan 2001 03:15:09 -0500
Received: from sm10.texas.rr.com ([24.93.35.222]:27666 "EHLO sm10.texas.rr.com")
	by vger.kernel.org with ESMTP id <S129415AbRACIPC>;
	Wed, 3 Jan 2001 03:15:02 -0500
Message-ID: <3A7BB6B1.ABF71834@austin.rr.com>
Date: Sat, 03 Feb 2001 01:43:45 -0600
From: Anwar Payyoorayil <anwar@austin.rr.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-prerelease i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.0-prerelease-ac4: i810_audio.c: Alternate VRA fix
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan -

Based on your suggestion, I looked again, and found that even though the kernel
sets VRA, the bit is lost when the driver unnecessarily resets the CODEC. The
patch below removes the unnecessary resetting of the CODEC. Nothing seems to be
lost by removing the resetting, and the driver in 2.2 series (where VRA works
fine) does not do this reset.

If we find that somebody needs this reset, we can move the VRA enabling code
after the codec reset code.

Anwar.

Patch against 2.4.0-prerelease-ac4

--- linux/drivers/sound/i810_audio.c.ac4        Sat Feb  3 01:26:31 2001
+++ linux/drivers/sound/i810_audio.c    Sat Feb  3 01:26:54 2001
@@ -1898,11 +1898,6 @@
        pci_dev->driver_data = card;
        pci_dev->dma_mask = I810_DMA_MASK;
 
-//     printk("resetting codec?\n");
-       outl(0, card->iobase + GLOB_CNT);
-       udelay(500);
-//     printk("bringing it back?\n");
-       outl(1<<1, card->iobase + GLOB_CNT);
        return 0;
 }
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
