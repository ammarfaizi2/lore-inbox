Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267280AbSLEKrV>; Thu, 5 Dec 2002 05:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267278AbSLEKqS>; Thu, 5 Dec 2002 05:46:18 -0500
Received: from holomorphy.com ([66.224.33.161]:44681 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267268AbSLEKqE>;
	Thu, 5 Dec 2002 05:46:04 -0500
Date: Thu, 05 Dec 2002 02:52:59 -0800
From: wli@holomorphy.com
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, kernel-janitor-discuss@lists.sourceforge.net,
       rmk@arm.linux.org.uk, jgarzik@pobox.com, miura@da-cha.org,
       alan@lxorguk.ukuu.org.uk, viro@math.psu.edu, pavel@ucw.cz
Subject: [warnings] [7/8] fix printk() type warning in drivers/net/tulip/interrupt.c
Message-ID: <0212050252.8aFdwcdaVbOapagccaab9crbMb9dlcUa20143@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <0212050252.jbobndDcEaLdlb5bCcEaYaZb~akaFc3d20143@holomorphy.com>
X-Mailer: patchbomb 0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cast to u64 and always print as %Lx to prevent type clashes.
Jeff, this is yours to ack.

===== drivers/net/tulip/interrupt.c 1.14 vs edited =====
--- 1.14/drivers/net/tulip/interrupt.c	Mon Oct 28 21:14:42 2002
+++ edited/drivers/net/tulip/interrupt.c	Thu Dec  5 01:22:15 2002
@@ -194,10 +194,10 @@
 				if (tp->rx_buffers[entry].mapping !=
 				    le32_to_cpu(tp->rx_ring[entry].buffer1)) {
 					printk(KERN_ERR "%s: Internal fault: The skbuff addresses "
-					       "do not match in tulip_rx: %08x vs. %08x %p / %p.\n",
+					       "do not match in tulip_rx: %08x vs. %08Lx %p / %p.\n",
 					       dev->name,
 					       le32_to_cpu(tp->rx_ring[entry].buffer1),
-					       tp->rx_buffers[entry].mapping,
+					       (u64)tp->rx_buffers[entry].mapping,
 					       skb->head, temp);
 				}
 #endif
