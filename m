Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261555AbVB1E7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbVB1E7P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 23:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbVB1E7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 23:59:14 -0500
Received: from mail.siliconiriver.com.au ([203.34.93.66]:47745 "EHLO
	mail.siliconriver.com.au") by vger.kernel.org with ESMTP
	id S261555AbVB1E7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 23:59:05 -0500
From: Jarne Cook <jcook@siliconriver.com.au>
To: linux-kernel@vger.kernel.org
Subject: Complicated networking problem
Date: Mon, 28 Feb 2005 14:59:31 +1000
User-Agent: KMail/1.7.1
Cc: Jarne Cook <jcook@siliconriver.com.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200502281459.31402.jcook@siliconriver.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all

(I am not subscribed. Please CC me)

Please forgive me if I have posed this message in the wrong place.  I have 
been searching for the answer for days with no resolve.

The question is: 

How do I get eth0 and wlan0 both working together.  

They are both using dhcp to the same simple network.  That's right.  Same 
network.  They both end up with gateway=192.168.0.1, netmask=255.255.255.0.  
But ofcourse they do not have the same IP addresses.

I dont know if this matters but im using ISC's dhclient3.

This is what it looks like when wlan0 is brought up, followed by eth0.
------------------------------------------------------------------------------
i8600:~# ifconfig eth0
eth0      Link encap:Ethernet  HWaddr 00:11:43:5F:E7:1D
          inet addr:192.168.0.238  Bcast:192.168.0.255  Mask:255.255.255.0
          inet6 addr: fe80::211:43ff:fe5f:e71d/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:277 errors:0 dropped:0 overruns:0 frame:0
          TX packets:60 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:24784 (24.2 KiB)  TX bytes:9278 (9.0 KiB)
          Interrupt:11
------------------------------------------------------------------------------
i8600:~# ifconfig wlan0
wlan0     Link encap:Ethernet  HWaddr 00:11:F5:0C:D9:A3
          inet addr:192.168.0.202  Bcast:192.168.0.255  Mask:255.255.255.0
          inet6 addr: fe80::211:f5ff:fe0c:d9a3/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:1538 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1085 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:203213 (198.4 KiB)  TX bytes:130588 (127.5 KiB)
          Interrupt:7 Memory:faff6000-faff7fff
------------------------------------------------------------------------------
i8600:~# ip rule list
0:      from all lookup local
32766:  from all lookup main
32767:  from all lookup default
------------------------------------------------------------------------------
i8600:~# ip route list table local
local 192.168.0.238 dev eth0  proto kernel  scope host  src 192.168.0.238
broadcast 192.168.0.255 dev wlan0  proto kernel  scope link  src 192.168.0.202
broadcast 192.168.0.255 dev eth0  proto kernel  scope link  src 192.168.0.238
broadcast 127.255.255.255 dev lo  proto kernel  scope link  src 127.0.0.1
local 192.168.0.202 dev wlan0  proto kernel  scope host  src 192.168.0.202
broadcast 192.168.0.0 dev wlan0  proto kernel  scope link  src 192.168.0.202
broadcast 192.168.0.0 dev eth0  proto kernel  scope link  src 192.168.0.238
broadcast 127.0.0.0 dev lo  proto kernel  scope link  src 127.0.0.1
local 127.0.0.1 dev lo  proto kernel  scope host  src 127.0.0.1
local 127.0.0.0/8 dev lo  proto kernel  scope host  src 127.0.0.1
------------------------------------------------------------------------------
i8600:~# ip route list table main
192.168.0.0/24 dev wlan0  proto kernel  scope link  src 192.168.0.202
192.168.0.0/24 dev eth0  proto kernel  scope link  src 192.168.0.238
default via 192.168.0.1 dev eth0
default via 192.168.0.1 dev wlan0
------------------------------------------------------------------------------
i8600:~# ip route list table default
------------------------------------------------------------------------------
i8600:~# iptables-save
------------------------------------------------------------------------------


So.
Is there a way to allow an application which has bound to wlan0 
(192.168.0.202) and an application bound to eth0 (192.168.0.238) both have 
access to the internet at the same time, and not require an application to 
bind to a different local address?

Thanks

Jarne

-- 
Jarne Cook <jcook@siliconriver.com.au>
Siliconriver.com.au
