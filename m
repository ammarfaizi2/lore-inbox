Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268061AbUHVS12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268061AbUHVS12 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 14:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268065AbUHVS12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 14:27:28 -0400
Received: from qfep05.superonline.com ([212.252.122.162]:34508 "EHLO
	qfep05.superonline.com") by vger.kernel.org with ESMTP
	id S268061AbUHVS1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 14:27:24 -0400
From: "Josan Kadett" <corporate@superonline.com>
To: "'Brad Campbell'" <brad@wasp.net.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Entirely ignoring TCP and UDP checksum in kernel level
Date: Sun, 22 Aug 2004 21:27:25 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
In-Reply-To: <41289C0B.7010805@wasp.net.au>
Thread-Index: AcSIScfXEOY9i3vERdyWNWPRKXO4cAAMbkOQ
Message-Id: <S268061AbUHVS1Y/20040822182724Z+153@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Very well I am trying to ping this device from a host connected to our linux
box whose source IP is translated. I changed the IP numbers a bit so they
won't interfere with each ether in any way (absolutely different subnets)

Eth0 is connected the path where the problematic 192.168.77.1 is reached.
The IP number of assigned to eth1 interface is 192.168.1.5. Now with the
patch applied, any request to 192.167.77.1 seems to return from 192.168.77.1

Eth1 is connected to a private network with the IP address of 1.1.1.1, and
the IP address of the host whose connection will be SNATted is 1.1.1.30.

When I ping 192.168.77.1, everything seems correct now, but when I ping that
IP 1.1.1.30, indeed the transaction is made, but the linux box is somehow
"reluctant" to send te response back.

Iptables -L -n -t nat:
Chain POSTROUTING (policy ACCEPT)
Target	prot	opt	source	destination 
SNAT		all	--	0.0.0.0/0	0.0.0.0/0
to:192.168.1.2

0.0.0.0 means anywhere I presume...

Ifconfig of the patched box
Eth0: inet address 192.168.1.5, netmask 255.255.0.0 (external if)
Eth1: inet address 1.1.1.1, netmak 255.255.255.0 (internal if)

Routing tables:
Destination		Gateway	Genmaks 	  Flags Metric Ref	Use
Iface
192.168.77.1	192.168.1.2 255.255.255.0 UGH	  0      0          0 eth0
1.1.1.0		0.0.0.0	255.255.255.0 U     0      0          0 eth1
192.168.0.0		0.0.0.0	255.255.0.0	  U     0      0          0
eth0

NAT client uses IP address 1.1.1.30, with netmask of 255.255.255.0 with the
default gateway 1.1.1.1 (linux box).

Tcpdump[ eth0 / the address translation occurs correctly]
Ping request - 192.168.1.5 to 192.168.77.1
Ping reply - From 192.168.77.1 to 192.168.1.5
Ping request - 192.168.1.5 to 192.168.77.1
Ping reply - From 192.168.77.1 to 192.168.1.5
Ping request - 192.168.1.5 to 192.168.77.1
Ping reply - From 192.168.77.1 to 192.168.1.5

Tcpdump[ eth1 / no reply is sent by our linux system]
Ping request - 1.1.1.30 to 192.168.77.1
Ping request - 1.1.1.30 to 192.168.77.1
Ping request - 1.1.1.30 to 192.168.77.1

Both dumps are taken at the same time, I ensure that the linux box just does
not redirect the ping reply to the client 1.1.1.30 that requested it.

What can this be now? NAT still does not work in a way - or is there
something missing ?


-----Original Message-----
From: Brad Campbell [mailto:brad@wasp.net.au] 
Sent: Sunday, August 22, 2004 3:14 PM
To: Josan Kadett
Cc: linux-kernel@vger.kernel.org
Subject: Re: Entirely ignoring TCP and UDP checksum in kernel level

Are you trying to ping 192.168.77.1 from 192.168.0.30?

Can you give me an iptables -L -n -t nat, ifconfig and route -n from the
patched box and also route 
-n and ifconfig from the dummy client at 192.168.0.30 so I can try and get a
handle on what you are 
doing and how it all is supposed to work?




