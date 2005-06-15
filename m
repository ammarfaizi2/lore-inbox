Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbVFOPW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbVFOPW1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 11:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbVFOPW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 11:22:27 -0400
Received: from smtp5.wanadoo.fr ([193.252.22.26]:63103 "EHLO smtp5.wanadoo.fr")
	by vger.kernel.org with ESMTP id S261165AbVFOPWE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 11:22:04 -0400
X-ME-UUID: 20050615152200802.C3C411C0022C@mwinf0502.wanadoo.fr
Message-ID: <14131924.1118848920765.JavaMail.www@wwinf0503>
From: Pascal CHAPPERON <pascal.chapperon@wanadoo.fr>
Reply-To: pascal.chapperon@wanadoo.fr
To: Francois Romieu <romieu@fr.zoreil.com>
Subject: Re: sis190
Cc: Andrew Hutchings <info@a-wing.co.uk>, linux-kernel@vger.kernel.org,
       vinay kumar <b4uvin@yahoo.co.in>, jgarzik@pobox.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [80.14.41.118]
X-WUM-FROM: |~|
X-WUM-TO: |~|
X-WUM-CC: |~||~||~||~|
X-WUM-REPLYTO: |~|
Date: Wed, 15 Jun 2005 17:22:00 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Message du 14/06/05 22:06
> De : "Francois Romieu" <romieu@fr.zoreil.com>

> The patch of the day uses a 4 bytes aligned Rx buffer address (at least for
> the usual MTU) and copies the Rx data. Can you reproduce the usual testing
> and tell if it makes a difference ?
> 
> Patch available at:
> http://www.fr.zoreil.com/people/francois/misc/20050614-2.6.12-rc-sis190-test.patch
> 
> --
> Ueimor
> 

# cat /var/log/messages
[...]
Jun 15 15:24:37 local kernel: sis190 Gigabit Ethernet driver 1.2 loaded
Jun 15 15:24:37 local kernel: ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
Jun 15 15:24:37 local kernel: 0000:00:04.0: sis190 at ffffc20000004c00 (IRQ: 11), 00:11:2f:e9:42:70
Jun 15 15:24:37 local kernel: eth0: Enabling Auto-negotiation.
Jun 15 15:24:37 local kernel: eth0: status = 63000000
Jun 15 15:24:37 local kernel: eth0: status = 20000000
Jun 15 15:24:38 local last message repeated 109 times
Jun 15 15:24:38 local kernel: eth0: status = 22000000
Jun 15 15:24:39 local kernel: eth0: status = 20000000
Jun 15 15:24:39 local last message repeated 48 times
Jun 15 15:24:39 local network: Bringing up interface eth0:  succeeded
Jun 15 15:24:39 local kernel: eth0: status = 20000000
Jun 15 15:24:47 local last message repeated 606 times
Jun 15 15:24:47 local kernel: eth0: mii 0x1f = 0000.
Jun 15 15:24:47 local kernel: eth0: mii lpa = 45e1.
Jun 15 15:24:47 local kernel: eth0: Link on 1000 Mbps Full Duplex mode.
Jun 15 15:24:47 local kernel: eth0: status = 20000000
Jun 15 15:25:18 local last message repeated 2361 times
[...]
Jun 15 15:26:56 local kernel: eth0: Rx status = 400c0040
Jun 15 15:26:56 local kernel: eth0: Rx PSize = 01010040
Jun 15 15:26:56 local kernel: sk_buff[0]->tail = ffff81001f2bd814
Jun 15 15:26:56 local kernel: eth0: Rx status = c0000000
[...]
Jun 15 15:26:57 local kernel: eth0: Rx status = 400c0040
Jun 15 15:26:57 local kernel: eth0: Rx PSize = 01010040
Jun 15 15:26:57 local kernel: sk_buff[0]->tail = ffff81001ef4c014
Jun 15 15:26:57 local kernel: eth0: Rx status = c0000000
[...]

# ifconfig
eth0      Link encap:Ethernet  HWaddr 00:11:2F:E9:42:70
          inet addr:10.169.21.20  Bcast:10.169.23.255  Mask:255.255.252.0
          inet6 addr: fe80::211:2fff:fee9:4270/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
          Interrupt:11 Base address:0xdead

# ping -c 1 10.169.21.1
PING 10.169.21.1 (10.169.21.1) 56(84) bytes of data.
>From 10.169.21.20 icmp_seq=0 Destination Host Unreachable

--- 10.169.21.1 ping statistics ---
1 packets transmitted, 0 received, +1 errors, 100% packet loss, time 0ms

#tcpdump -enx [local]
15:30:56.690828 00:11:2f:e9:42:70 > Broadcast, ethertype ARP (0x0806), length 42: arp who-has 10.169.21.1 tell 10.169.21.20
        0x0000:  0001 0800 0604 0001 0011 2fe9 4270 0aa9  ........../.Bp..
        0x0010:  1514 0000 0000 0000 0aa9 1501            ............
15:30:56.691065 48:6e:08:06:00:01 > 42:70:00:30:4f:06, ethertype IPv4 (0x0800), length 60: IP0 bad-len 2
        0x0000:  0604 0002 0030 4f06 486e 0aa9 1501 0011  .....0O.Hn......
        0x0010:  2fe9 4270 0aa9 1514 0000 0000 0000 0000  /.Bp............
        0x0020:  0000 0000 0000 0000 0000 0c15 4f3d       ............O=
15:30:57.690671 00:11:2f:e9:42:70 > Broadcast, ethertype ARP (0x0806), length 42: arp who-has 10.169.21.1 tell 10.169.21.20
        0x0000:  0001 0800 0604 0001 0011 2fe9 4270 0aa9  ........../.Bp..
        0x0010:  1514 0000 0000 0000 0aa9 1501            ............
15:30:57.690840 48:6e:08:06:00:01 > 42:70:00:30:4f:06, ethertype IPv4 (0x0800), length 60: IP0 bad-len 2
        0x0000:  0604 0002 0030 4f06 486e 0aa9 1501 0011  .....0O.Hn......
        0x0010:  2fe9 4270 0aa9 1514 0000 0000 0000 0000  /.Bp............
        0x0020:  0000 0000 0000 0000 0000 0c15 4f3d       ............O=
15:30:58.690519 00:11:2f:e9:42:70 > Broadcast, ethertype ARP (0x0806), length 42: arp who-has 10.169.21.1 tell 10.169.21.20
        0x0000:  0001 0800 0604 0001 0011 2fe9 4270 0aa9  ........../.Bp..
        0x0010:  1514 0000 0000 0000 0aa9 1501            ............
15:30:58.690691 48:6e:08:06:00:01 > 42:70:00:30:4f:06, ethertype IPv4 (0x0800), length 60: IP0 bad-len 2
        0x0000:  0604 0002 0030 4f06 486e 0aa9 1501 0011  .....0O.Hn......
        0x0010:  2fe9 4270 0aa9 1514 0000 0000 0000 0000  /.Bp............
        0x0020:  0000 0000 0000 0000 0000 0c15 4f3d       ............O=

# ping -c 1 -s 250 10.169.21.1
PING 10.169.21.1 (10.169.21.1) 250(278) bytes of data.
>From 10.169.21.20 icmp_seq=0 Destination Host Unreachable


--- 10.169.21.1 ping statistics ---
1 packets transmitted, 0 received, +1 errors, 100% packet loss, time 0ms

#tcpdump -enx [local]
15:32:44.705404 00:11:2f:e9:42:70 > Broadcast, ethertype ARP (0x0806), length 42: arp who-has 10.169.21.1 tell 10.169.21.20
        0x0000:  0001 0800 0604 0001 0011 2fe9 4270 0aa9  ........../.Bp..
        0x0010:  1514 0000 0000 0000 0aa9 1501            ............
15:32:44.705641 48:6e:08:06:00:01 > 42:70:00:30:4f:06, ethertype IPv4 (0x0800), length 60: IP0 bad-len 2
        0x0000:  0604 0002 0030 4f06 486e 0aa9 1501 0011  .....0O.Hn......
        0x0010:  2fe9 4270 0aa9 1514 0000 0000 0000 0000  /.Bp............
        0x0020:  0000 0000 0000 0000 0000 0c15 4f3d       ............O=
15:32:45.705250 00:11:2f:e9:42:70 > Broadcast, ethertype ARP (0x0806), length 42: arp who-has 10.169.21.1 tell 10.169.21.20
        0x0000:  0001 0800 0604 0001 0011 2fe9 4270 0aa9  ........../.Bp..
        0x0010:  1514 0000 0000 0000 0aa9 1501            ............
15:32:45.705442 48:6e:08:06:00:01 > 42:70:00:30:4f:06, ethertype IPv4 (0x0800), length 60: IP0 bad-len 2
        0x0000:  0604 0002 0030 4f06 486e 0aa9 1501 0011  .....0O.Hn......
        0x0010:  2fe9 4270 0aa9 1514 0000 0000 0000 0000  /.Bp............
        0x0020:  0000 0000 0000 0000 0000 0c15 4f3d       ............O=
15:32:46.705098 00:11:2f:e9:42:70 > Broadcast, ethertype ARP (0x0806), length 42: arp who-has 10.169.21.1 tell 10.169.21.20
        0x0000:  0001 0800 0604 0001 0011 2fe9 4270 0aa9  ........../.Bp..
        0x0010:  1514 0000 0000 0000 0aa9 1501            ............
15:32:46.705325 48:6e:08:06:00:01 > 42:70:00:30:4f:06, ethertype IPv4 (0x0800), length 60: IP0 bad-len 2
        0x0000:  0604 0002 0030 4f06 486e 0aa9 1501 0011  .....0O.Hn......
        0x0010:  2fe9 4270 0aa9 1514 0000 0000 0000 0000  /.Bp............
        0x0020:  0000 0000 0000 0000 0000 0c15 4f3d       ............O=


# i tried to remove NET_IP_ALIGN :
# diff -puN sis190-20050614.c sis190.c
--- sis190-20050614.c   2005-06-15 16:39:08.000000000 +0200
+++ sis190.c    2005-06-15 16:41:28.000000000 +0200
@@ -405,11 +405,10 @@ static int sis190_alloc_rx_skb(struct pc
         * To be verified: the asic only DMA to a four bytes aligned address
         * -> the usual NET_IP_ALIGN margin must be increased by a 2x factor.
         */
-       skb = dev_alloc_skb(rx_buf_sz + 2*NET_IP_ALIGN);
+       skb = dev_alloc_skb(rx_buf_sz);
        if (!skb)
                goto err_out;

-       skb_reserve(skb, 2*NET_IP_ALIGN);
        *sk_buff = skb;

        mapping = pci_map_single(pdev, skb->tail, rx_buf_sz,
@@ -456,10 +455,8 @@ static inline int sis190_try_rx_copy(str

        if (pkt_size < rx_copybreak) {
                struct sk_buff *skb;
-
-               skb = dev_alloc_skb(pkt_size + NET_IP_ALIGN);
+               skb = dev_alloc_skb(pkt_size);
                if (skb) {
-                       skb_reserve(skb, NET_IP_ALIGN);
                        printk(KERN_INFO "sk_buff[0]->tail = %p\n",
                               sk_buff[0]->tail);
                        eth_copy_and_sum(skb, sk_buff[0]->tail, pkt_size, 0);
@@ -468,9 +465,6 @@ static inline int sis190_try_rx_copy(str
                        ret = 0;
                }
        }
-       /* Fix the IP align issue by hand. */
-       if (ret < 0)
-               sis190_align(sk_buff[0], pkt_size);
        return ret;
 }

 
It seemed to work :  ping, ping -s 1400, ping -s 10000.
I  could even connect (a short time) on the server via ssh and work on it.
But :
# ifconfig
eth0      Link encap:Ethernet  HWaddr 00:11:2F:E9:42:70
          inet addr:10.169.21.20  Bcast:10.169.23.255  Mask:255.255.252.0
          inet6 addr: fe80::211:2fff:fee9:4270/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:128 errors:0 dropped:0 overruns:0 frame:0
          TX packets:82 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:158305 (154.5 KiB)  TX bytes:7834 (7.6 KiB)
          Interrupt:11 Base address:0xdead

Everything failed after 128 packets were received.

I tried to increase NUM_RX_DESC from 64 to 256 :
# ifconfig
eth0      Link encap:Ethernet  HWaddr 00:11:2F:E9:42:70
          inet addr:10.169.21.20  Bcast:10.169.23.255  Mask:255.255.252.0
          inet6 addr: fe80::211:2fff:fee9:4270/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:512 errors:0 dropped:0 overruns:0 frame:0
          TX packets:271 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:709097 (692.4 KiB)  TX bytes:20284 (19.8 KiB)
          Interrupt:11 Base address:0xdead

Only 512 packets were received...

Nothing special in syslog after the failure, and tcpdump reported only Tx packets :
16:18:30.891922 00:11:2f:e9:42:70 > Broadcast, ethertype ARP (0x0806), length 42: arp who-has 10.169.21.1 tell 10.169.21.20
        0x0000:  0001 0800 0604 0001 0011 2fe9 4270 0aa9  ........../.Bp..
        0x0010:  1514 0000 0000 0000 0aa9 1501            ............


I got a serious headache as i tried to understand how the RX ring works.
But it is quite too difficult for me now.

Regards
Pascal



