Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275213AbTHAMZW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 08:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275214AbTHAMZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 08:25:22 -0400
Received: from main.gmane.org ([80.91.224.249]:30873 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S275213AbTHAMZK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 08:25:10 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: IP multicast errors with linux 2.6.0-test2 and SiS900
Date: Fri, 01 Aug 2003 14:20:07 +0200
Message-ID: <yw1xu191k1s8.fsf@users.sourceforge.net>
References: <yw1xznitk857.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:SoQewDTunAbP57i20xaYDBkHFxs=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mru@users.sourceforge.net (Måns Rullgård) writes:

> I'm experiencing some strange behavior with IP multicast in linux
> 2.6.0-test2 on a SiS900 NIC.
>
> It will only receive multicast packets with destination address
> 239.1.1.*, unless I "ifconfig eth0 allmulti".  With allmulti set, all
> multcast addresses are received.  Setting promisc mode also does the
> trick.
>
> This isn't the intended bahavior, is it?

Update: 239.2.*.1 seems to work as well, but 239.1.1.1 doesn't work.

Also, if I join several multicast groups using the same port number,
all sockets receive packets from all groups.  Maybe this is intended,
I can't find any details on this.

Hardware details:

$ lscpi
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 650 Host (rev 01)
00:01.0 PCI bridge: Silicon Integrated Systems [SiS] SiS 530 Virtual PCI-to-PCI bridge (AGP)
00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev 10)
00:02.1 SMBus: Silicon Integrated Systems [SiS]: Unknown device 0016
00:02.2 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB Controller (rev 07)
00:02.3 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB Controller (rev 07)
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)
00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] SiS7012 PCI Audio Accelerator (rev a0)
00:03.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet (rev 90)
00:0a.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev a8)
00:0a.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev a8)
00:0a.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller
00:0c.0 Communication controller: Conexant HSF 56k HSFi Modem (rev 01)
01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] SiS650/651/M650/740 PCI/AGP VGA Display Adapter

$ lspci -s3 -v
00:03.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet (rev 90)
	Subsystem: Asustek Computer, Inc.: Unknown device 1455
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at a000 [size=256]
	Memory at e6000000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: <available only to root>

$ dmesg [in part]
sis900.c: v1.08.06 9/24/2002
eth0: ICS LAN PHY transceiver found at address 1.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0xa000, IRQ 11, 00:0c:6e:40:b0:22.
eth0: Media Link On 100mbps full-duplex 


-- 
Måns Rullgård
mru@users.sf.net

