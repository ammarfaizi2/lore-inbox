Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268051AbUIBJYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268051AbUIBJYL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 05:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268115AbUIBJYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 05:24:11 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:34284 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268051AbUIBJVq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 05:21:46 -0400
Message-ID: <93e09f0104090202216403c08d@mail.gmail.com>
Date: Thu, 2 Sep 2004 14:51:46 +0530
From: Rohit Neupane <rohitneupane@gmail.com>
Reply-To: Rohit Neupane <rohitneupane@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Weird Problem with TCP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 I have a linux box which acts as gateway and b/w manager for our wireless
network. I have 3 Interfaces ( one not is use yet). I have created 3 aliases
on the interface connected to the wireless (with 3 different class C
address).
I have around 350-400 wireless clients with over 10Mbps traffic at peak
hours.
These days I have observed some abnormal behavior.

System:
Dell P4 Poweredge
Red Hat 8.0 with 2.4.25 kernel
Lan Cards:
 1. Intel 82540EM Gigabit Ethernet Controller (Intenet)
 2. 3com 3c905B Cyclone (Wireless)


The problem is:
* Everything works fine for about 5-10 mins then all of a sudden TCP services
are not accessable.
* For some reason TCP times out. However at the same time ping,traceroute and
dns trace works without any problem.
* The connected TCP sokets keeps working without any problem. I verified this
by using Msn chat. I observerd that I chat session ( which I had started
when everything was normal) continued without any problem however I was not
able to initiate a new chat session.

Result of tcpdum on eth0 (internet) and eth2(wireless)

* I can see tcp SYN request coming in from eth2 (from client) and going out
via eth0 to destination.
* I can see tcp SYN+ACK coming in from eth0. But it doesn't get out through
eth2 !!! However other udp,icmp pkts can.

src 69.56.37.146  , dst 64.236.16.52
this is tcpdump on eth0 (internet side)
17:14:32.003370 69.56.37.146.3170 > 64.236.16.52.http: S
2446361626:2446361626(0) win 64240 <mss 1460,nop,nop,sackOK> (DF)
17:14:32.004694 64.236.16.52.http > 69.56.37.146.3170: S
3641974278:3641974278(0) ack 2446361627 win 65535 <mss 1460> (DF)
17:14:34.920578 69.56.37.146.3170 > 64.236.16.52.http: S
2446361626:2446361626(0) win 64240 <mss 1460,nop,nop,sackOK> (DF)
17:14:34.921800 64.236.16.52.http > 69.56.37.146.3170: S
3641974278:3641974278(0) ack 2446361627 win 65535 <mss 1460> (DF)
17:14:37.915564 64.236.16.52.http > 69.56.37.146.3170: S
3641974278:3641974278(0) ack 2446361627 win 65535 <mss 1460> (DF)
17:14:40.955491 69.56.37.146.3170 > 64.236.16.52.http: S
2446361626:2446361626(0) win 64240 <mss 1460,nop,nop,sackOK> (DF)
17:14:40.957682 64.236.16.52.http > 69.56.37.146.3170: S
3641974278:3641974278(0) ack 2446361627 win 65535 <mss 1460> (DF)

this is tcpdump on eth2  (client side)
17:14:32.003179 69.56.37.146.3170 > 64.236.16.52.http: S
2446361626:2446361626(0) win 64240 <mss 1460,nop,nop,sackOK> (DF)
17:14:34.920212 69.56.37.146.3170 > 64.236.16.52.http: S
2446361626:2446361626(0) win 64240 <mss 1460,nop,nop,sackOK> (DF)
17:14:40.955257 69.56.37.146.3170 > 64.236.16.52.http: S
2446361626:2446361626(0) win 64240 <mss 1460,nop,nop,sackOK> (DF)

As you can see i am getting the ACK from source from seq. 2446361626 (with
ack 2446361627 ) on eth0. But it is not going out via eth2!!

After sometime everthing starts working normally again. So what may be the
problem? I have problem only with the tcp protocol and not with other. I
haven't changed any tcp memory related settings.

net.ipv4.tcp_rmem = 4096        87380   174760
net.ipv4.tcp_wmem = 4096        87380   174760
net.ipv4.tcp_mem = 195584       196096  196608
net.core.optmem_max = 10240
net.core.rmem_default = 65535
net.core.wmem_default = 65535
net.core.rmem_max = 131071
net.core.wmem_max = 131071


Has anyone come across this probelm? any suggestion?

Thanks
Rohit
