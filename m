Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262113AbVHCGs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbVHCGs4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 02:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbVHCGse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 02:48:34 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:20416 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262113AbVHCGrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 02:47:36 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: "David S. Miller" <davem@davemloft.net>, jgarzik@pobox.com
Subject: 2.6.11-rc5 and 2.6.12: cannot transmit anything - more info
Date: Wed, 3 Aug 2005 09:47:01 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508030947.01901.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As reported earlier, sometimes my home box don't want
to send anything.

# ip r
1.1.5.5 dev tun0  proto kernel  scope link  src 1.1.5.6
1.1.4.0/24 dev if  proto kernel  scope link  src 1.1.4.6
default via 1.1.5.5 dev tun0
# ping 1.1.4.1 -i 0.01

kernel log:
2005-07-30_21:28:25.15338 kern.info: qdisc_restart: start
2005-07-30_21:28:25.16438 kern.info: qdisc_restart: start
2005-07-30_21:28:25.17538 kern.info: qdisc_restart: start
2005-07-30_21:28:25.18638 kern.info: qdisc_restart: start
2005-07-30_21:28:25.19738 kern.info: qdisc_restart: start
2005-07-30_21:28:25.20837 kern.info: qdisc_restart: start
2005-07-30_21:28:25.21937 kern.info: qdisc_restart: start
2005-07-30_21:28:25.23037 kern.info: qdisc_restart: start
2005-07-30_21:28:25.24137 kern.info: qdisc_restart: start
...

updated kernel log:
2005-08-02_19:12:06.14733 kern.info: qdisc_restart: start, q->dequeue=c03e8662
2005-08-02_19:12:06.15832 kern.info: qdisc_restart: start, q->dequeue=c03e8662
2005-08-02_19:12:06.16932 kern.info: qdisc_restart: start, q->dequeue=c03e8662
2005-08-02_19:12:06.18032 kern.info: qdisc_restart: start, q->dequeue=c03e8662
2005-08-02_19:12:06.19132 kern.info: qdisc_restart: start, q->dequeue=c03e8662
2005-08-02_19:12:06.20232 kern.info: qdisc_restart: start, q->dequeue=c03e8662
2005-08-02_19:12:06.21332 kern.info: qdisc_restart: start, q->dequeue=c03e8662
2005-08-02_19:12:06.22431 kern.info: qdisc_restart: start, q->dequeue=c03e8662
2005-08-02_19:12:06.23531 kern.info: qdisc_restart: start, q->dequeue=c03e8662
2005-08-02_19:12:08.04506 kern.info: qdisc_restart: start, q->dequeue=c03e8662
2005-08-02_19:12:12.19652 kern.info: qdisc_restart: start, q->dequeue=c03e8662
2005-08-02_19:12:17.19567 kern.info: qdisc_restart: start, q->dequeue=c03e8662
2005-08-02_19:12:18.19551 kern.info: qdisc_restart: start, q->dequeue=c03e8662
2005-08-02_19:12:19.19536 kern.info: qdisc_restart: start, q->dequeue=c03e8662

System.map:
c03e8662 t noop_dequeue

I guess this explains why I do not see calls to pfifo_fast_dequeue! :)
But how come my interface is using noop queue, is a mystery to me.

# ip l 
[I have 4 wireless PCI cards for testing - lots of netdevs:]
1: if: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 1000
    link/ether 00:0a:e6:7c:dd:79 brd ff:ff:ff:ff:ff:ff
2: lo: <LOOPBACK,UP> mtu 16436 qdisc noqueue
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
3: wifi0: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 1000
    link/ieee802.11 00:09:5b:67:8f:70 brd ff:ff:ff:ff:ff:ff
4: ifh: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue
    link/[802] 00:09:5b:67:8f:70 brd ff:ff:ff:ff:ff:ff
5: wifi1: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 1000
    link/ieee802.11 00:09:5b:68:2b:d7 brd ff:ff:ff:ff:ff:ff
6: ifm: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue
    link/[802] 00:09:5b:68:2b:d7 brd ff:ff:ff:ff:ff:ff
7: wifi2: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 1000
    link/ieee802.11 00:09:5b:69:17:c8 brd ff:ff:ff:ff:ff:ff
8: ifn: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue
    link/[802] 00:09:5b:69:17:c8 brd ff:ff:ff:ff:ff:ff
9: ifhwds0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop
    link/ether 00:09:5b:67:8f:70 brd ff:ff:ff:ff:ff:ff
10: ifmwds0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop
    link/ether 00:09:5b:68:2b:d7 brd ff:ff:ff:ff:ff:ff
13: tun0: <POINTOPOINT,MULTICAST,NOARP,UP> mtu 1464 qdisc pfifo_fast qlen 100
    link/[65534]

After modprobe -r hostap_pci:

# ip l
1: if: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 1000
    link/ether 00:0a:e6:7c:dd:79 brd ff:ff:ff:ff:ff:ff
2: lo: <LOOPBACK,UP> mtu 16436 qdisc noqueue
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
17: tun0: <POINTOPOINT,MULTICAST,NOARP,UP> mtu 1464 qdisc pfifo_fast qlen 100
    link/[65534]

As you can see, ip l reports that iface 'if' uses pfifo_fast, not noop...

Any ideas?
--
vda

