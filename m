Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129283AbQKPBPN>; Wed, 15 Nov 2000 20:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129415AbQKPBPD>; Wed, 15 Nov 2000 20:15:03 -0500
Received: from [209.249.10.20] ([209.249.10.20]:13734 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S129283AbQKPBOy>; Wed, 15 Nov 2000 20:14:54 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 15 Nov 2000 16:44:44 -0800
Message-Id: <200011160044.QAA24961@adam.yggdrasil.com>
To: davem@redhat.com, willy@meta-x.org
Subject: 2.4.0-test11-pre5/drivers/net/sunhme.c compile failure on x86
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	linux-2.4.0-test11-pre5/drivers/net/sunhme.c fails to compile
on x86 because it uses the undefined symbols DMA_BURST{BITS,8,16,32,64},
which are not defined anywhere in include/asm-i386/*.h.  For sparc,
these symbols are defined in include/asm-sparc/dma.h, so I copied them
in sunhme.c and bracketted them if #ifndef DMA_BURSTBITS...#endif, which
made the code compile.  However, that is probably not exactly the cleanest
change (it should give correct behavior, however, since the PCI bus
behavior is just to set the mask in question to all ones, so that the
tests for different DMA types all succeed, if I understand correctly).

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
