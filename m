Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269944AbRHTXxm>; Mon, 20 Aug 2001 19:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269918AbRHTXxc>; Mon, 20 Aug 2001 19:53:32 -0400
Received: from monkey.demon.co.uk ([193.237.112.77]:30666 "EHLO
	nuttserve.nuttnet.lan") by vger.kernel.org with ESMTP
	id <S269909AbRHTXxT>; Mon, 20 Aug 2001 19:53:19 -0400
Date: Tue, 21 Aug 2001 00:53:28 +0100 (BST)
From: David Fennell <dave@nuttserve.nuttnet.lan>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: PATCH - One line AWE32 driver bug fix.
Message-ID: <Pine.LNX.4.21.0108210038470.18880-100000@nuttserve.nuttnet.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


KERNEL:
  Version 2.4.9 (Applies to 2.2.x kernels too)

DESCRIPTION:
  The sound blaster awe32 wave driver has for as long as I can remember
  (back to 2.2.4?) unreliably detected the on-board ram size for awe32
  and awe64 cards.  Having looked at the code this was an obvious mistake
  in the choice of constant.  The author chose a number of 0xFFFF which is 
  written to the card and then read if the value read equals "0xFFFF" then
  the write was assumed to be succeful and the driver increments a bit and
  trys again.  Unfortunately reading from a port which has no hardware by
  default (I think) returns 0xFFFF.  Meaning the scan often ran off the
  end of the memory.  Changing the value to 0xABCD seems to produce 100%
  reliable memory size detection.


Hope to see this in the kernel soon to save me doing it each time I
download it!!

Dave Fennell.
Dave@NetReady.ltd.uk

PATCH FOLLOWS:

--- drivers/sound/awe_wave.c.orig   Tue Aug 21 00:35:33 2001
+++ drivers/sound/awe_wave.c    Tue Aug 21 00:36:26 2001
@@ -4873,7 +4873,7 @@
 /* any three numbers you like */
 #define UNIQUE_ID1 0x1234
 #define UNIQUE_ID2 0x4321
-#define UNIQUE_ID3 0xFFFF
+#define UNIQUE_ID3 0xABCD

 static void __init
 awe_check_dram(void)

