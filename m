Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311911AbSCOCaU>; Thu, 14 Mar 2002 21:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311912AbSCOCaK>; Thu, 14 Mar 2002 21:30:10 -0500
Received: from 12-249-40-19.client.attbi.com ([12.249.40.19]:17681 "EHLO
	rekl.dyn.dhs.org") by vger.kernel.org with ESMTP id <S311911AbSCOC36>;
	Thu, 14 Mar 2002 21:29:58 -0500
Date: Thu, 14 Mar 2002 20:29:54 -0600 (CST)
From: rob1@rekl.yi.org
X-X-Sender: rob1@rekl.dyn.dhs.org
To: linux-kernel@vger.kernel.org
Subject: IP Autoconfig doesn't work for USB network devices
Message-ID: <Pine.LNX.4.40.0203142010380.12787-100000@rekl.dyn.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  I'm trying to setup a generic kernel that can be booted from floppy
or flash that will let me setup an nfs-root machine.  I have it working
from machine "A", which has a PCI network card.  However, machine "B"
doesn't work because the USB network device (D-Link DSB-650) is not
detected until after the IP Autoconfig decides that there aren't any
network cards.

Excerpt from bootup/dmesg:

...
pegasus.c: v0.4.22 (2001/12/07):Pegasus/Pegasus II USB Ethernet driver
usb.c: registered new driver pegasus
...
NET4: Linux TCP/IP 1.0 for NET4.0
...
IP-Config: No network devices available.
...
hub.c: USB new device connect on bus2/1, assigned device number 2
pegasus.c: eth0: D-Link DSB-650
...


And then my bootup script fails to mount the nfs partition, etc since it
can't find the network.

I tried modifying the delay time in net/ipv4/ipconfig.c under the "Give
hardware a chance to settle" comment, but apparently the USB connection
stuff is done after it tries to mount root, etc.  (Is that a separate
kernel thread?  Can it be started sooner?)

Is there any way to get the USB network device recognized before IP
autoconfig is executed?


Please reply directly, since I'm not subscribed.  Thanks.


