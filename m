Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287558AbRLaQch>; Mon, 31 Dec 2001 11:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287559AbRLaQc1>; Mon, 31 Dec 2001 11:32:27 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:1500 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S287558AbRLaQcO>; Mon, 31 Dec 2001 11:32:14 -0500
Date: Mon, 31 Dec 2001 10:32:13 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200112311632.KAA51999@tomcat.admin.navo.hpc.mil>
To: girish@bombay.retortsoft.com, linux-kernel@vger.kernel.org
Subject: Re: how to map network cards ?
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Girish Hilage <girish@bombay.retortsoft.com>:
> 
> Hello everybody,
> 
>  This is my first mail to the list. I want to know, what /sbin/lspci outputs are nothing but the contents of '/proc/bus/pci/devices' in a readable form?
> 
>  And if so how do I know which entry implies which network interface (e.g. eth0, eth1 etc.)?

You don't.

There is no fixed method, though the following may help:

1. eth0 is assigned to the first device identified. This works if you have
   multiple interfaces (using different drivers), then the order the drivers
   are loaded will define which is eth0 - I do this for a system with
   mixed 3c509 (ISA), and 3c905 (PCI) interfaces.
2. In a muli-interface environment with (say) two 3c509 - the order happens
   to be in bus order. This has implied that the slot number it is plugged
   in determines which is eth0. In my case a system has two PCI 3c905C
   interfaces, the first at 00:0e.0, and the second at 00:0f.0. The 0e.0
   interface appears as eth0.

Note: if one of the interfaces is unplugged/fails dramatically , the bus scan
will assign the FIRST interface located as eth0. The only way to determine
the ACTUAL eth0 is via mac number and trial and error.

I configure ONE interface (all others are down), then plug in to a working
network.

If I can ping the other machine then I know which network a given
interface is on - label it.

Now down that interface, and initialize another one. Repeat until all
interfaces are identified.
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
