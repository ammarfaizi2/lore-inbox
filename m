Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316500AbSE0RO0>; Mon, 27 May 2002 13:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316517AbSE0ROZ>; Mon, 27 May 2002 13:14:25 -0400
Received: from www.stpibonline.soft.net ([164.164.128.17]:3816 "EHLO
	cyclops.soft.net") by vger.kernel.org with ESMTP id <S316500AbSE0ROY>;
	Mon, 27 May 2002 13:14:24 -0400
Message-ID: <91A7E7FABAF3D511824900B0D0F95D10137099@BHISHMA>
From: Abdij Bhat <Abdij.Bhat@kshema.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-mips-kernel@lists.sourceforge.net'" 
	<linux-mips-kernel@lists.sourceforge.net>
Cc: Abdij Bhat <Abdij.Bhat@kshema.com>, Prasad HA <prasad@kshema.com>,
        Prakash P <Prakash@kshema.com>
Subject: IP Forwarding Problem
Date: Mon, 27 May 2002 22:42:50 +0530
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 I am trying to deploy IP Forwarding on an embedded system running on Linux
[ Kernel > 2.4 ] with mips target.
 I do a "echo "1" > /proc/sys/net/ipv4/ip_forward" to enable and "echo "0" >
/proc/sys/net/ipv4/ip_forward" to disable the IP Forwarding feature.

 The hardware setup i have is as below

1. Linux PC [ Ref PC A ] with eth0 IP Address say 192.168.100.5
2. Linux PC [ Ref PC B ] with eth0 IP Address say 192.168.101.5
3. The embedded target has 2 NIC's. eth0 IP Address is 192.168.100.6 and
eth1 IP Address is 192.168.101.6.
4. A hub connecting subnet 100 machines
5. A hub connecting subnet 101 machines

 I setup the default gateways on both the Reference PC's to reflect their
own IP Address. Each of the Ref PC's can ping to the machines on their
subnet.
 But when i ping Ref PC A to Ref PC B; the give the error "Destination host
is unreachable".

 I tried to resolve the problem and found a few info on the net. Based on
that i found that
1. there was no /etc/sysconfig directory on the target embedded system 
2. there was no /etc/sysconfig/network-scripts directory
3. no /etc/sysconfig/network-scripts/ifcfg-eth0, eth1, eth0:1 and eth1:0
files 
4. there was no /etc/sysconfig/network file

 I created all of the above [ i have pasted the contents of each file below
]. Yet i get the same error. Can somebody tell what am i not doing or what
am i doing wrong?

Thanks and Regards,
Abdij

*******************************
/etc/sysconfig/network-scripts/ifcfg-eth0

DEVICE=eth0
IPADDR=192.168.100.6
NETWORK=192.168.100.0
NETMASK=255.255.255.0
BROADCAST=192.168.100.255
ONBOOT=yes

*******************************

/etc/sysconfig/network-scripts/ifcfg-eth1

DEVICE=eth1
IPADDR=192.168.101.6
NETWORK=192.168.101.0
NETMASK=255.255.255.0
BROADCAST=192.168.101.255
ONBOOT=yes

*******************************

/etc/sysconfig/network-scripts/ifcfg-eth0:1

IPADDR="192.168.100.0-255"

*******************************

/etc/sysconfig/network-scripts/ifcfg-eth1:0

IPADDR="192.168.101.0-255"

*******************************

/etc/sysconfig/network

NETWORKING=yes
FORWARD_IPV4="yes"
HOSTNAME=localhost.localdomain
DOMAINNAME=mydomain.co
GATEWAY=="192.168.100.254"
GATEWAYDEV="eth0"
