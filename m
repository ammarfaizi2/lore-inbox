Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267326AbUHTBIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267326AbUHTBIe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 21:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267544AbUHTBId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 21:08:33 -0400
Received: from smtp09.auna.com ([62.81.186.19]:13983 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id S267326AbUHTBI1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 21:08:27 -0400
Message-ID: <41254F06.1080107@latinsud.com>
Date: Fri, 20 Aug 2004 03:08:22 +0200
From: "SuD (Alex)" <sud@latinsud.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Fealnx watchdog timeouts issue
Content-Type: multipart/mixed;
 boundary="------------080007090402060502010305"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080007090402060502010305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I changed my pc (but kept the card) and watchdog timeouts are less 
frequent, but they eventually happen along with packet corruption.
With my earlier pc and kernel i could produce it just by doing a "ping 
-f" in the lan, but now it happens more randomly. The symptoms are that 
2 bytes of data are inserted before the rest of data in the frame (i 
captured it with ethereal) or maybe that the pointer is wrong by 2 bytes.

While doing a flood ping i got normal ping replies:
0000  00 40 d0 21 96 b2 00 02  44 1f 5f 59 08 00 45 00   .@.!.... D._Y..E.
0010  00 54 e3 ef 00 00 40 01  4b d7 d9 d9 09 84 d9 d8   .T....@. K.......
0020  8d ac 00 00 21 12 8e 09  a3 01 40 88 65 ca 00 07   ....!... ..@.e...
0030  1c 86 08 09 0a 0b 0c 0d  0e 0f 10 11 12 13 14 15   ........ ........
0040  16 17 18 19 1a 1b 1c 1d  1e 1f 20 21 22 23 24 25   ........ .. !"#$%
0050  26 27 28 29 2a 2b 2c 2d  2e 2f 30 31 32 33 34 35   &'()*+,- ./012345

and also a wrong one, note there is extra "00 00" at the begining but 
there are 2 bytes missing at the end:
0000  00 00 00 40 d0 21 96 b2  00 02 44 1f 5f 59 08 00   ...@.!.. ..D._Y..
0010  45 00 00 54 e3 f0 00 00  40 01 4b d6 d9 d9 09 84   E..T.... @.K.....
0020  d9 d8 8d ac 00 00 f8 9f  8e 09 a4 01 40 88 65 ca   ........ ....@.e.
0030  00 07 43 f8 08 09 0a 0b  0c 0d 0e 0f 10 11 12 13   ..C..... ........
0040  14 15 16 17 18 19 1a 1b  1c 1d 1e 1f 20 21 22 23   ........ .... !"#
0050  24 25 26 27 28 29 2a 2b  2c 2d 2e 2f 30 31 32 33   $%&'()*+ ,-./0123

Today i got this error:

eth0: Promiscuous mode enabled.
device eth0 left promiscuous mode
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 00000000, resetting...
  Rx ring cf6b4000:  80000000 80000000 80000000 80000000 80000000 
80000000 80000000 80000000 80000000 80000000 80000000 80000000
  Tx ring cf6b5000:  80000000 80000000 0000 80000000 80000000 80000000
Badness in local_bh_enable at kernel/softirq.c:136
 [<c011c319>] local_bh_enable+0x89/0x90
 [<c0334f64>] ip_ct_find_proto+0x34/0x50
 [<c0335350>] destroy_conntrack+0x10/0x100
 [<c02db108>] __kfree_skb+0x98/0x120
 [<d088735c>] reset_tx_descriptors+0x5c/0xb0 [fealnx]
 [<d0887018>] tx_timeout+0xc8/0x130 [fealnx]
 [<c02e9db0>] dev_watchdog+0x0/0xc0
 [<c02e9e5e>] dev_watchdog+0xae/0xc0
 [<c011fe4a>] run_timer_softirq+0xca/0x190
 [<c011ffe7>] do_timer+0xc7/0xd0
 [<c011c259>] __do_softirq+0x79/0x80
 [<c011c287>] do_softirq+0x27/0x30
 [<c0105b39>] do_IRQ+0xf9/0x130
 [<c0104028>] common_interrupt+0x18/0x20

PS: nice my patch for mac address got in the official tree but, do you 
think it'd be better if it the driver implemented it's own 
"set_mac_address" function so only then it would update the card's 
registers and try to mess the less possible?

--------------080007090402060502010305
Content-Type: message/rfc822;
 name="[PATCH] Fealnx. Mac address and other issues"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[PATCH] Fealnx. Mac address and other issues"

Message-ID: <40885DCE.1090903@latinsud.com>
Date: Fri, 23 Apr 2004 02:05:34 +0200
From: "SuD (Alex)" <sud@latinsud.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fealnx. Mac address and other issues
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I recently was given a surecom 10/100 ethernet card and found that i 
could not change Mac address for it as other driver/devices allow.
I tried to implement the missing feature and noticed that the device is 
quite peculiar (or either my system is broken), when trying to fill mac 
address registers (no matter whether io_ops is set):
- If I write a byte (writeb) to an even i/o address it seems like 
actually a word was written (the next byte is set to 0).
- If I write a byte to an odd i/o address my pc gets bad freezed.

That made think of writing 16bit words (writew) for the memory address, 
as opposed to what most driver examples do. It works for me (I hope i 
set the lines at the right place in device_open function after the 
device is reset). I hope the code is clean enough and does not mess with 
byte ordering. This is the patch (this time against 2.6.5):


--- linux-2.6.5.orig/drivers/net/fealnx.c       2004-04-09 
05:04:20.000000000 +0200
+++ linux/drivers/net/fealnx.c  2004-04-23 01:47:38.000000000 +0200
@@ -882,12 +882,17 @@
 {
        struct netdev_private *np = dev->priv;
        long ioaddr = dev->base_addr;
-
+       int i;
+
        writel(0x00000001, ioaddr + BCR);       /* Reset */

        if (request_irq(dev->irq, &intr_handler, SA_SHIRQ, dev->name, dev))
                return -EAGAIN;

+       for (i = 0; i < 3; i++) {
+               writew(((unsigned short*)dev->dev_addr)[i], ioaddr + 
PAR0 + i*2);
+       }
+
        init_ring(dev);

        writel(np->rx_ring_dma, ioaddr + RXLBA);


----
By the way, i get some Watchdog Timeouts while transmitting every 10 
minutes or so (also with 2.4 and original drivers).
This is what i get:
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 00000000, resetting...
 Rx ring cf674000:  80000000 80000000 80000000 80000000 80000000 
80000000 80000000 80000000 80000000 80000000 80000000 80000000
 Tx ring cf675000:  80000000 80000000 80000000 80000000 80000000 0000

I have also recently experienced problems with my cablemodem Motorola 
SB5100e. It has registered this mac address:
    D4:62:00:02:44:1F
which does not exist but is a mixture of my surecom card (fealnx) 
00:02:44:1F:5F:59 and the network gateway 00:05:00:E2:D4:62.
I am not sure who's fault this is (i would not trust my cablemodem much 
anyway).

Thank you for reading.


--------------080007090402060502010305--
