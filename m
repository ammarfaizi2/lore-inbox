Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129814AbQKQBCX>; Thu, 16 Nov 2000 20:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129380AbQKQBCO>; Thu, 16 Nov 2000 20:02:14 -0500
Received: from lsne-cable-1-p21.vtxnet.ch ([212.147.5.21]:51717 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S129130AbQKQBCE>;
	Thu, 16 Nov 2000 20:02:04 -0500
Date: Fri, 17 Nov 2000 01:31:57 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: linux-kernel@vger.kernel.org
Subject: BTTV detection broken in 2.4.0-test11-pre5
Message-ID: <20001117013157.A21329@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The BTTV driver 0.7.48 doesn't detect my old Hauppauge card anymore.
The problem seems to be that my card sets PCI_SUBSYSTEM_ID and
PCI_SUBSYSTEM_VENDOR_ID to zero (lspci output below).

In 2.4.0-test10-pre5, the card was correctly detected as a
"Hauppauge old". If I set btv->type to 2 in 2.4.0-test11-pre5, the
card is properly initialized and works.

Not sure what the correct fix is. Maybe to fall back to vendor/device
ID if there's no subsystem information ?

- Werner

---------------------------------- cut here -----------------------------------

# lspci -v -s 00:0f.0      
00:0f.0 Multimedia video controller: Brooktree Corporation Bt848 TV with DMA push (rev 12)
        Flags: bus master, medium devsel, latency 64, IRQ 9
        Memory at eddfe000 (32-bit, prefetchable) [size=4K]
# lspci -x -s 00:0f.0 -n
00:0f.0 Class 0400: 109e:0350 (rev 12)
00: 9e 10 50 03 06 00 80 02 12 00 00 04 00 40 00 00
10: 08 e0 df ed 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 01 10 28

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
