Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbVFMITe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbVFMITe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 04:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbVFMITe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 04:19:34 -0400
Received: from smtp15.wanadoo.fr ([193.252.23.84]:18752 "EHLO
	smtp15.wanadoo.fr") by vger.kernel.org with ESMTP id S261405AbVFMITO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 04:19:14 -0400
X-ME-UUID: 20050613081908710.AD8B57000081@mwinf1501.wanadoo.fr
Message-ID: <18320560.1118650748703.JavaMail.www@wwinf1518>
From: Pascal CHAPPERON <pascal.chapperon@wanadoo.fr>
Reply-To: pascal.chapperon@wanadoo.fr
To: Francois Romieu <romieu@fr.zoreil.com>
Subject: Re: sis190
Cc: Andrew Hutchings <info@a-wing.co.uk>, linux-kernel@vger.kernel.org,
       vinay kumar <b4uvin@yahoo.co.in>, jgarzik@pobox.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [193.251.58.174]
X-WUM-FROM: |~|
X-WUM-TO: |~|
X-WUM-CC: |~||~||~||~|
X-WUM-REPLYTO: |~|
Date: Mon, 13 Jun 2005 10:19:08 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Message du 11/06/05 12:58
> De : "Francois Romieu" <romieu@fr.zoreil.com>
> Can you reproduce the tests (dhcp/no dhcp) with the patch linked below and
> add a tcpdump -x output taken at the server as an addition to the usual
> information ?
> 
> http://www.fr.zoreil.com/people/francois/misc/20050611a-2.6.12-rc-sis190-test.patch
> 
> If you are in a hurry and have any output, I'll look at it today (~18h).
> 
> Thanks.
> 
> --
> Ueimor
> 
> 
No, i am not in hurry, and many thanks for working on this driver.

The results :
# cat /var/log/messages
Jun 13 09:04:27 local kernel: sis190 Gigabit Ethernet driver 1.2 loaded
Jun 13 09:04:27 local kernel: ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
Jun 13 09:04:27 local kernel: ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
Jun 13 09:04:27 local kernel: 0000:00:04.0: sis190 at ffffc20000004c00 (IRQ: 11), 00:11:2f:e9:42:70
Jun 13 09:04:27 local kernel: eth0: Enabling Auto-negotiation.
Jun 13 09:04:27 local kernel: eth0: status = 20000000
Jun 13 09:04:29 local last message repeated 155 times
Jun 13 09:04:29 local kernel: eth0: status = 20010000
Jun 13 09:04:29 local kernel: eth0: link change
Jun 13 09:04:29 local kernel: eth0: Link on unknown mode.
Jun 13 09:04:29 local kernel: eth0: status = 20000000
Jun 13 09:04:29 local last message repeated 4 times
Jun 13 09:04:29 local network: Bringing up interface eth0:  succeeded
Jun 13 09:04:29 local kernel: eth0: status = 20000000
Jun 13 09:04:31 local last message repeated 147 times
Jun 13 09:04:31 local kernel: eth0: status = 2000000c
Jun 13 09:04:31 local kernel: eth0: status = 20000000
...
Jun 13 09:05:02 local kernel: eth0: Rx status = 40040040
Jun 13 09:05:02 local kernel: eth0: Rx PSize = 01010040
Jun 13 09:05:02 local kernel: eth0: Rx status = c0000000
Jun 13 09:05:03 local kernel: eth0: Rx status = 40040040
Jun 13 09:05:03 local kernel: eth0: Rx PSize = 01010040
Jun 13 09:05:03 local kernel: eth0: Rx status = c0000000
Jun 13 09:05:04 local kernel: eth0: Rx status = 40040040
Jun 13 09:05:04 local kernel: eth0: Rx PSize = 01010040
Jun 13 09:05:04 local kernel: eth0: Rx status = c0000000
Jun 13 09:05:05 local kernel: eth0: Rx status = 40040040
Jun 13 09:05:05 local kernel: eth0: Rx PSize = 01010040
Jun 13 09:05:05 local kernel: eth0: Rx status = c0000000
Jun 13 09:05:06 local kernel: eth0: Rx status = 40040040
Jun 13 09:05:06 local kernel: eth0: Rx PSize = 01010040
Jun 13 09:05:06 local kernel: eth0: Rx status = c0000000
Jun 13 09:05:07 local kernel: eth0: Rx status = 40040040
Jun 13 09:05:07 local kernel: eth0: Rx PSize = 01010040
Jun 13 09:05:07 local kernel: eth0: Rx status = c0000000
...

# ifconfig
eth0      Link encap:Ethernet  HWaddr 00:11:2F:E9:42:70
          inet addr:10.169.21.20  Bcast:10.169.23.255  Mask:255.255.252.0
          inet6 addr: fe80::211:2fff:fee9:4270/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:141 errors:0 dropped:0 overruns:0 frame:0
          TX packets:144 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:8460 (8.2 KiB)  TX bytes:6104 (5.9 KiB)
          Interrupt:11 Base address:0xbeef

NOTE : here is something strange about base address =>
dmesg :  sis190 at ffffc20000004c00 (IRQ: 11)
ifconfig :          Interrupt:11 Base address:0xbeef

# local tcpdump  : ping server 10.169.21.1 from local 10.169.21.20
09:09:41.798748 arp who-has 10.169.21.1 tell 10.169.21.20
        0x0000:  0001 0800 0604 0001 0011 2fe9 4270 0aa9  ........../.Bp..
        0x0010:  1514 0000 0000 0000 0aa9 1501            ............
09:09:41.798920 4f:06:48:6e:08:06 null > 2f:e9:42:70:00:30 sap 08 I (s=3,r=2,C) len=42
        0x0000:  0800 0604 0002 0030 4f06 486e 0aa9 1501  .......0O.Hn....
        0x0010:  0011 2fe9 4270 0aa9 1514 0000 0000 0000  ../.Bp..........
        0x0020:  0000 0000 0000 0000 0000 0000 0c15       ..............
09:09:42.798592 arp who-has 10.169.21.1 tell 10.169.21.20
        0x0000:  0001 0800 0604 0001 0011 2fe9 4270 0aa9  ........../.Bp..
        0x0010:  1514 0000 0000 0000 0aa9 1501            ............
09:09:42.798767 4f:06:48:6e:08:06 null > 2f:e9:42:70:00:30 sap 08 I (s=3,r=2,C) len=42
        0x0000:  0800 0604 0002 0030 4f06 486e 0aa9 1501  .......0O.Hn....
        0x0010:  0011 2fe9 4270 0aa9 1514 0000 0000 0000  ../.Bp..........
        0x0020:  0000 0000 0000 0000 0000 0000 0c15       ..............
...

# server tcpdump  : ping server 10.169.21.1 from local 10.169.21.20
09:27:40.749713 arp who-has 10.169.21.1 tell 10.169.21.20
        0x0000:  0001 0800 0604 0001 0011 2fe9 4270 0aa9  ........../.Bp..
        0x0010:  1514 0000 0000 0000 0aa9 1501 0000 0000  ................
        0x0020:  0000 0000 0000 0000 0000 0000 0000       ..............
09:27:40.749797 arp reply 10.169.21.1 is-at 00:30:4f:06:48:6e
        0x0000:  0001 0800 0604 0002 0030 4f06 486e 0aa9  .........0O.Hn..
        0x0010:  1501 0011 2fe9 4270 0aa9 1514            ..../.Bp....
09:27:41.749522 arp who-has 10.169.21.1 tell 10.169.21.20
        0x0000:  0001 0800 0604 0001 0011 2fe9 4270 0aa9  ........../.Bp..
        0x0010:  1514 0000 0000 0000 0aa9 1501 0000 0000  ................
        0x0020:  0000 0000 0000 0000 0000 0000 0000       ..............
09:27:41.749605 arp reply 10.169.21.1 is-at 00:30:4f:06:48:6e
        0x0000:  0001 0800 0604 0002 0030 4f06 486e 0aa9  .........0O.Hn..
        0x0010:  1501 0011 2fe9 4270 0aa9 1514            ..../.Bp....

It seems that sis190 driver shifts 4 bytes...


further test about autoneg, probably silly:
be nice, as i know nothing to network drivers dev.
i do not understand what is LPA_SLCT...

modification :
# diff -puN sis190-20050611a.c sis190.c
--- sis190-20050611a.c  2005-06-13 08:54:56.000000000 +0200
+++ sis190.c    2005-06-13 09:41:29.000000000 +0200
@@ -630,7 +630,7 @@ static irqreturn_t sis190_interrupt(int

                SIS_W32(IntrStatus, status);

-               printk(KERN_INFO "%s: status = %08x\n", dev->name, status);
+               // printk(KERN_INFO "%s: status = %08x\n", dev->name, status);

                if ((status & LinkChange) && netif_running(dev)) {
                        printk(KERN_INFO "%s: link change\n", dev->name);
@@ -823,18 +823,17 @@ static void sis190_phy_task(void * data)
                        u16 ctl;
                        const char *msg;
                } reg31[] = {
-                       { _1000bpsF,    0x1c01, "1000 bps Full Duplex" },
-                       { _1000bpsH,    0x0c01, "1000 bps Half Duplex" },
-                       { _100bpsF,     0x1801, "100 bps Full Duplex" },
-                       { _100bpsH,     0x0801, "100 bps Half Duplex" },
-                       { _10bpsF,      0x1401, "10 bps Full Duplex" },
-                       { _10bpsH,      0x0401, "10 bps Half Duplex" },
+                       { LPA_1000XFULL | LPA_SLCT,  0x1c01, "1000 bps Full Duplex" },
+                       { LPA_1000XHALF | LPA_SLCT,  0x0c01, "1000 bps Half Duplex" },
+                       { LPA_100FULL,  0x1801, "100 bps Full Duplex" },
+                       { LPA_100HALF,  0x0901, "100 bps Half Duplex" },
+                       { LPA_10FULL,   0x1401, "10 bps Full Duplex" },
+                       { LPA_10HALF,   0x0401, "10 bps Half Duplex" },
                        { 0,            0x0000, "unknown" }
                }, *p;
-               val = mdio_read(ioaddr, LPA_SLCT) & 0x1c; // bit 4:2
-
+               val = mdio_read(ioaddr, MII_LPA);
                for (p = reg31; p->ctl; p++) {
-                       if (val == p->val)
+                 if ((val &  p->val) == p->val)
                                break;
                }
                if (p->ctl)

# dmesg
...
[  remote card forced in 10 half autoneg off ]
...
sis190 Gigabit Ethernet driver 1.2 loaded
ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [LNKD] -> GSI 11 (level, low) ->
IRQ 11
PCI: Setting latency timer of device 0000:00:04.0 to 64
0000:00:04.0: sis190 at ffffc20000004c00 (IRQ: 11), 00:11:2f:e9:42:70
eth0: Enabling Auto-negotiation.
eth0: Link on 10 bps Half Duplex mode.
eth0: no IPv6 routers present
...
[ remote card in 10 full autoneg off ]
[ I must restart the network to have (false) mode detection ]
...
eth0: Link on 10 bps Half Duplex mode.
eth0: Link on 10 bps Half Duplex mode.
...
[ remote card in 100 full autoneg on ]
[ no network restart ]
...
eth0: no IPv6 routers present
eth0: link change
eth0: PHY reset until link up
eth0: link change
eth0: Link on 100 bps Full Duplex mode.
eth0: Link on 100 bps Full Duplex mode.
...


Regards
Pascal

