Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270976AbTHFTPQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 15:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270984AbTHFTPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 15:15:16 -0400
Received: from s4.uklinux.net ([80.84.72.14]:46239 "EHLO mail2.uklinux.net")
	by vger.kernel.org with ESMTP id S270976AbTHFTPG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 15:15:06 -0400
Date: Wed, 6 Aug 2003 20:14:52 +0100 (BST)
From: Peter Denison <lkml@marshadder.uklinux.net>
X-X-Sender: peterd@marshall.localnet
To: linux-usb-devel@lists.sourceforge.net, <linux-kernel@vger.kernel.org>
Subject: 2.4.21 USB printer failure w/ HP PSC750
Message-ID: <Pine.LNX.4.44.0308061955440.1069-100000@marshall.localnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Having just upgraded to 2.4.21, the first time I tried to print, the
following happened. The printer started to print, but gave up after a
while and spat out just about 1" of image. Needless to say, it all worked
fine under 2.4.20.

Intel 82801BA based MB, running stock 2.4.21 (compiled with gcc 3.3.1)
with uhci driver (all on Debian testing)

This debugging code was introduced during 2.4.20->2.4.21, but I'm afraid I
don't know what the significance of it is. (Happens when td->dma_handle !=
(qh->element & ~UHCI_PTR_BITS) )

Can anyone tell me what's going on? I am happy to provide more information
as necessary.


Aug  6 18:45:19 ptal-mlcd: SYSLOG at /home/msp/src/debian/hpoj/hpoj-0.90/mlcd/
bp/ex/ExMgr.h:564, dev=<mlc:usb:PSC_750@/dev/usb/lp0>, pid=287, e=19
         ptal-mlcd successfully activated, mode=1284.4.
Aug  6 18:45:22 kernel: [d7b0b120] link (17b0b092) element (166d9270)
[following lines all the same time]
kernel:  Element != First TD
kernel:   0: [d66d9000] link (166d9030) e3 SPD Length=3f MaxLen=3f DT0 EndPt=1
 Dev=2, PID=e1(OUT) (buf=15f5c000)
kernel:   1: [d66d9030] link (166d9060) e3 SPD Length=3f MaxLen=3f DT1 EndPt=1
 Dev=2, PID=e1(OUT) (buf=15f5c040)
kernel:   2: [d66d9060] link (166d9090) e3 SPD Length=3f MaxLen=3f DT0 EndPt=1
 Dev=2, PID=e1(OUT) (buf=15f5c080)
kernel:   3: [d66d9090] link (166d90c0) e3 SPD Length=3f MaxLen=3f DT1 EndPt=1
 Dev=2, PID=e1(OUT) (buf=15f5c0c0)
kernel:   4: [d66d90c0] link (166d90f0) e3 SPD Length=3f MaxLen=3f DT0 EndPt=1
 Dev=2, PID=e1(OUT) (buf=15f5c100)
kernel:   5: [d66d90f0] link (166d9120) e3 SPD Length=3f MaxLen=3f DT1 EndPt=1
 Dev=2, PID=e1(OUT) (buf=15f5c140)
kernel:   6: [d66d9120] link (166d9150) e3 SPD Length=3f MaxLen=3f DT0 EndPt=1
 Dev=2, PID=e1(OUT) (buf=15f5c180)
kernel:   7: [d66d9150] link (166d9180) e2 SPD Length=3f MaxLen=3f DT1 EndPt=1
 Dev=2, PID=e1(OUT) (buf=15f5c1c0)
kernel:   8: [d66d9180] link (166d91b0) e3 SPD Length=3f MaxLen=3f DT0 EndPt=1
 Dev=2, PID=e1(OUT) (buf=15f5c200)
kernel:   9: [d66d91b0] link (166d91e0) e3 SPD Length=3f MaxLen=3f DT1 EndPt=1
 Dev=2, PID=e1(OUT) (buf=15f5c240)
kernel:   10: [d66d91e0] link (166d9210) e3 SPD Length=3f MaxLen=3f DT0 EndPt=1
 Dev=2, PID=e1(OUT) (buf=15f5c280)
kernel:   11: [d66d9210] link (166d9240) e3 SPD Length=3f MaxLen=3f DT1 EndPt=1
 Dev=2, PID=e1(OUT) (buf=15f5c2c0)
kernel:   12: [d66d9240] link (166d9270) e3 SPD Length=3f MaxLen=3f DT0 EndPt=1
 Dev=2, PID=e1(OUT) (buf=15f5c300)
kernel:   13: [d66d9270] link (166d92a0) e0 SPD Stalled CRC/Timeo Length=3f
 MaxLen=3f DT1 EndPt=1 Dev=2, PID=e1(OUT) (buf=15f5c340)
kernel:   14: [d66d92a0] link (166d92d0) e3 SPD Active Length=0 MaxLen=3f DT0
 EndPt=1 Dev=2, PID=e1(OUT) (buf=15f5c380)
kernel:   15: [d66d92d0] link (00000001) e3 SPD IOC Active Length=0 MaxLen=3d
 DT1 EndPt=1 Dev=2, PID=e1(OUT) (buf=15f5c3c0)
kernel:
kernel: printer.c: usblp0: nonzero read/write bulk status received: -110

Aug  6 18:46:16 kernel: [d7b0b0c0] link (17b0b062) element (166d9030)
kernel:  Element != First TD
kernel:   0: [d66d9000] link (166d9030) e3 Length=7 MaxLen=7 DT0 EndPt=0 Dev=2,
 PID=2d(SETUP) (buf=161364e0)
kernel:   1: [d66d9030] link (166d9060) e0 SPD Stalled CRC/Timeo Length=7ff
 MaxLen=0 DT1 EndPt=0 Dev=2, PID=69(IN) (buf=167dbf67)
kernel:   2: [d66d9060] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1
 EndPt=0 Dev=2, PID=e1(OUT) (buf=00000000)
kernel:

This last stanza is then repeated, every 41-160 seconds, presumably each
time CUPS tries again to print the data.

-- 
Peter Denison <peterd at marshadder dot uklinux dot net>
Please use this address only for personal mail, not copied to lists
gatewayed to news or web pages unless the addresses are removed.

