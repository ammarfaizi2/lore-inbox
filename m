Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbTISMr3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 08:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbTISMr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 08:47:29 -0400
Received: from [193.126.32.23] ([193.126.32.23]:47324 "EHLO
	mail.paradigma.co.pt") by vger.kernel.org with ESMTP
	id S261538AbTISMr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 08:47:27 -0400
Date: Fri, 19 Sep 2003 13:47:30 +0100
From: Nuno Monteiro <nuno@paradigma.co.pt>
To: Bernhard Rosenkraenzer <bero@arklinux.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: via-rhine apparently broken in 2.4.23-pre4
Message-ID: <20030919124730.GA1512@hobbes.itsari.int>
References: <Pine.LNX.4.56.0309190254480.18687@dot.kde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed	DelSp=Yes
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.56.0309190254480.18687@dot.kde.org>; from bero@arklinux.org on Fri, Sep 19, 2003 at 01:58:21 +0100
X-Mailer: Balsa 2.0.14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003.09.19 01:58, Bernhard Rosenkraenzer wrote:
> Unverified (due to lack of hardware) report from a user:
> 
> Updating from 2.4.22 to 2.4.23-pre4 breaks networking with an onboard
> VIA Rhine II chip.
> 
> It seems to transfer about 2 kB of data, then stall forever.
>

Hi,


I can't confirm that, it's working perfectly here.

root:~# lspci -v -s 00:12.0
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II]  
(rev 74)
        Subsystem: Asustek Computer, Inc.: Unknown device 80a1
        Flags: bus master, stepping, medium devsel, latency 32, IRQ 23
        I/O ports at b400 [size=256]
        Memory at e5000000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 2

root:~# uname -a
Linux hobbes 2.4.23-pre4 #1 Fri Sep 19 12:43:29 WEST 2003 i686 unknown  
unknown GNU/Linux

root:~# ifconfig|grep -A7 eth0
eth0      Link encap:Ethernet  HWaddr 00:0C:6E:19:06:A9
          inet addr:192.168.0.17  Bcast:192.168.0.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:74532 errors:0 dropped:0 overruns:0 frame:0
          TX packets:73461 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          RX bytes:15080003 (14.3 Mb)  TX bytes:7089544 (6.7 Mb)
          Interrupt:23 Base address:0x6000

Relevant dmesg:

via-rhine.c:v1.10-LK1.1.19  July-12-2003  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
eth0: VIA VT6102 Rhine-II at 0xe5000000, 00:0c:6e:19:06:a9, IRQ 23.
eth0: MII PHY found at address 1, status 0x786d advertising 01e1 Link  
41e1.

It's an Asus A7V8X board connected to a nortel baystack 350 switch, and  
the kernel is built with ACPI, local APIC and IO-APIC (which are known  
for breaking stuff on occasion, although have always worked flawlessly  
here) and highmem (2Gb installed). See if your user can try booting with  
"pci=noapic" or "acpi=off" or "noapic", it should probably help.

Now, booting back to 2.6.0-test5 ;)


Cheers,

		Nuno

