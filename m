Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263762AbTLOQxQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 11:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263786AbTLOQxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 11:53:16 -0500
Received: from smtp.fusemail.net ([69.31.1.141]:35338 "EHLO fuse1")
	by vger.kernel.org with ESMTP id S263762AbTLOQxL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 11:53:11 -0500
Subject: Query about Adaptive Load Balancing (bonding) on 2.4.23
From: Mike Insch <ordan@fusemail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1071507189.10133.13.camel@it002-host.sfs-creative.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 15 Dec 2003 16:53:09 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to use the Bonding driver in kernel version 2.4.23 to
aggregate two NIC's together. The network switches don't support
Round-Robin, XOR or 802.3ad mode, so I am trying to use Adaptive Load
Balancing (ALB) mode. Unfortunately, I'm running into a few snags!

I'm trying to use two 3Com 3c905C NIC's. Both NIC's work fine
themselves. To get things working, I am doing:

    # modprobe bonding mode=6
    # ifconfig bond0 192.168.1.1 netmask 255.255.255.0 up
    # ifenslave bond0 eth0 eth1

The first two work OK, and the bonding interface comes up. When I try
and enslave the two NIC's, ifenslave responds with:

    SIOCBONDENSLAVE: Operation not supported.

And the following entries are recorded in /var/log/messages:

    bonding: Error: alb_set_slave_mac_addr: dev->set_mac_address of
    dev eth0 failed! ALB mode requires that the base driver support
    setting the hw address also when the network devices interface is
    open

(and the same for eth1).

I've looked in the code for the Bonding driver, and I can see exactly
where it is failing (line 971 in bond_alb.c), but I don't know nearly
enough about the kernel network dirvers and modules to trace back the
problem to it's root (which appears to be in the 3c59x driver).

I've looked for a list of devices which are compatable with ALB in the
Bonding driver, and have come up empty (google was not my friend!)

I have a few quick questions:
* Does anyone have any good pointers to a compatability list between
network drivers and the bonding driver?
* Can someone give me any pointers about which bits of the code in each
driver to look at so that I can make such a list for myself?
* Does anyone know of any patches for the 3c59x driver which will allow
the bonding driver to change the MAC address while the interface is
open? (Is this even possible in the hardware, or is it purely a driver
issue?)

Any pointers to more information, or advice on which bits of the code to
look at would be greatly appreciated. I'm happy to apply patches, or
even to have a stab at writing one myself if I can work out where to
start!!!

