Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbUC3XZZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 18:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbUC3XZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 18:25:24 -0500
Received: from mesa.unizar.es ([155.210.11.66]:46027 "EHLO relay.unizar.es")
	by vger.kernel.org with ESMTP id S261554AbUC3XZH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 18:25:07 -0500
Mime-Version: 1.0 (Apple Message framework v613)
Content-Transfer-Encoding: 7bit
Message-Id: <7617358E-82A1-11D8-82F0-000A9585C204@able.es>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: Linux-Kernel <linux-kernel@vger.kernel.org>
From: "J.A. Magallon" <jamagallon@able.es>
Subject: NFS sloow on 2.4
Date: Wed, 31 Mar 2004 01:24:58 +0200
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

I have noticed that NFS is very slow on writes with 2.4.26-pre6.
Some example:

- On the server:
annwn:~> time -p dd if=/dev/zero of=tst bs=1024 count=2048
2048+0 records in
2048+0 records out
real 0.04
user 0.01
sys 0.04

-On the client:
2048+0 records in
2048+0 records out
real 21.56
user 0.00
sys 0.02

Any idea on what's happening ?

SERVER
/etc/exports:
/home   *.net1.cluster(rw,no_root_squash,no_subtree_check,no_auth_nlm)
annwn:~> ifconfig eth2
eth2      Link encap:Ethernet  HWaddr 00:03:47:23:D5:74
           inet addr:192.168.1.1  Bcast:192.168.1.255  Mask:255.255.255.0
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:225214 errors:0 dropped:0 overruns:0 frame:0
           TX packets:135234 errors:0 dropped:0 overruns:0 carrier:134665
           collisions:0 txqueuelen:1000
           RX bytes:36314498 (34.6 Mb)  TX bytes:47083712 (44.9 Mb)
           Memory:df000000-df020000
03:01.0 Ethernet controller: Intel Corp. 82543GC Gigabit Ethernet 
Controller (Copper) (rev 02)

CLIENT
mount:
192.168.1.1:/home on /home type nfs 
(rw,nfsvers=3,tcp,rsize=8192,wsize=8192,noac,addr=192.168.1.1)
node06:~> ifconfig eth1
eth1      Link encap:Ethernet  HWaddr 00:30:48:70:DE:5B
           inet addr:192.168.1.16  Bcast:192.168.1.255  
Mask:255.255.255.0
           UP BROADCAST NOTRAILERS RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:31710 errors:0 dropped:0 overruns:0 frame:0
           TX packets:41138 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:11676250 (11.1 Mb)  TX bytes:9522033 (9.0 Mb)
           Base address:0xa800 Memory:f2020000-f2040000
02:0a.0 Ethernet controller: Intel Corp.: Unknown device 1013
(is also a Gigabit from Intel, on board)

Are this expected timings, or something is really wrong ?

TIA


--
J.A. Magallon <jamagallon()able!es>   \          Software is like sex:
werewolf!able!es                       \    It's better when it's free
MacOS X 10.3.3, Build 7F44, Darwin Kernel Version 7.3.0

