Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130380AbRCWINk>; Fri, 23 Mar 2001 03:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130216AbRCWINa>; Fri, 23 Mar 2001 03:13:30 -0500
Received: from gate.unige.ch ([129.194.8.77]:25014 "EHLO gate.unige.ch")
	by vger.kernel.org with ESMTP id <S130317AbRCWINQ>;
	Fri, 23 Mar 2001 03:13:16 -0500
Date: Fri, 23 Mar 2001 09:12:34 +0100
From: Pfenniger Daniel <daniel.pfenniger@obs.unige.ch>
Subject: Channel bonding kernel crash, workaround
To: linux-kernel@vger.kernel.org
Message-id: <3ABB0572.BB100F30@obs.unige.ch>
MIME-version: 1.0
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.7 sun4u)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: fr-CH, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Up to the latests kernels (-> 2.4.2) channel bonding crashes the kernel
(aille...) when turning it off (e.g. at reboot).  

Here is a way to avoid this, which might help gourous to track the bug. 
Suppose ifconfig says: 
 
bond0     Link encap:Ethernet  HWaddr 00:40:05:A1:C4:13  
          inet addr:192.168.2.64  Bcast:192.168.2.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MASTER MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:823297 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 

eth0      Link encap:Ethernet  HWaddr 00:40:05:A1:C4:13  
          inet addr:192.168.2.64  Bcast:192.168.2.255  Mask:255.255.255.0
          UP BROADCAST RUNNING SLAVE MULTICAST  MTU:1500  Metric:1
          RX packets:487424 errors:0 dropped:0 overruns:0 frame:0
          TX packets:411649 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100 
          Interrupt:19 Base address:0xd000 

eth1      Link encap:Ethernet  HWaddr 00:40:05:A1:C4:13  
          inet addr:192.168.2.64  Bcast:192.168.2.255  Mask:255.255.255.0
          UP BROADCAST RUNNING SLAVE MULTICAST  MTU:1500  Metric:1
          RX packets:487526 errors:0 dropped:0 overruns:0 frame:0
          TX packets:411648 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100 
          Interrupt:18 Base address:0xb800 

then the exact sequence:

ifconfig eth0 down 
ifconfig eth1 down 
ifconfig bond0 down 
ifconfig eth0 down 
ifconfig eth1 down 

turns off bond0 without crash.  This was tested on several computers with 
all kernel 2.4.2, SMP Pentium II and tulip 21140 and/or 21142/3 NICs.

	Dan
