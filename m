Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129775AbQLVRxE>; Fri, 22 Dec 2000 12:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130320AbQLVRwy>; Fri, 22 Dec 2000 12:52:54 -0500
Received: from natmail2.webmailer.de ([192.67.198.65]:53223 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S129775AbQLVRwr>; Fri, 22 Dec 2000 12:52:47 -0500
From: Stefan Hoffmeister <Stefan.Hoffmeister@Econos.de>
To: linux-kernel@vger.kernel.org
Subject: rtl8139 driver broken? (2.2.16)
Date: Fri, 22 Dec 2000 18:23:05 +0100
Organization: Econos
Message-ID: <vb074t8d27bdedg6m7pv4c4qqu1f8324cq@4ax.com>
X-Mailer: Forte Agent 1.8/32.548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[please CC replies; I am not on the list]

I have a 2.2.16 kernel on an HP Omnibook 800 CT with docking station. That
docking station contains an Allied Telesyn 2500TX NIC, identified by lspci
as "Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)". Versions 1.07
(RedHat 7.0) and 1.08 (SuSE 7.0) exhibit the same behaviour.

The network is set up correctly - I can ping 127.0.0.1 without problems,
but the connection to the external network simply "stops working" after a
while as soon as I do something more exciting.

Examples of failure when the rtl8139 driver is used:

  ping 192.168.0.55
  // (sometimes) works for ages

  ping -s 5000 192.168.0.55
  // makes network die almost instantaneously
  // after that, all outbound traffic just does
  // not get through

  ftp 192.168.0.55
  binary
  get <largish file>
  // makes network die almost instantaneously

The network is resurrected by /etc/rc.d/[init.d/]network restart. This
happens both with the stock kernel + modules shipped with RedHat 7.0, a
default SuSE 7.0 setup, and a self-built kernel + modules based on SuSE
7.0.

I do not see any kernel messages indicating any failure anywhere; only on
boot do I get "neighbour table overflow" (4x), but the NIC works
nevertheless.

When I insert a PCMCIA NIC and use the network over *that* card,
everything works fine forever ("ifconfig eth0 down", then "ifconfig eth1
up").

Fiddling with BIOS options (PnP, PCI bridge configuration) does not seem
to have any effect.

Questions: 
* Is the rtl8139 driver broken?
* Is there some kind of problem with the docking station (bridge)?

FWIW, this combination ran perfectly fine with Windows NT4 SP3...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
