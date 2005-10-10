Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbVJJJBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbVJJJBh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 05:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbVJJJBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 05:01:37 -0400
Received: from scipost.dolphinics.no ([193.71.152.3]:25503 "EHLO
	scipost.dolphinics.no") by vger.kernel.org with ESMTP
	id S1750772AbVJJJBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 05:01:36 -0400
Message-ID: <434A2E3A.7060706@dolphinics.no>
Date: Mon, 10 Oct 2005 11:02:50 +0200
From: Simen Thoresen <simentt@dolphinics.no>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: vmalloc=256M broken on x86 on >4G ram?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm seeing a somewhat curious problem on an Opteron-machine with 5G ram. 
   For outside reasons (driver development for our own cards) we have to 
set the vmalloc=256M parameter when booting the kernel. This causes the 
machine to panic due to missing a root filesystem right when the SCSI 
subsystem should have been initialized. I do not see any error messages, 
but do not have the full console log. Nothing noticeable on what is on 
the screen, at aleast.

On a working boot (ie not with vmalloc=256M specified), the system 
continues loading the MPT drivers;

....
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 32768 buckets, 512Kbytes
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI wakeup devices:
TP2P  USB G0PA G0PB G1PA G1PB
ACPI: (supports S0 S1 S5)
Freeing unused kernel memory: 236k freed
SCSI subsystem initialized
Fusion MPT base driver 3.01.20
Copyright (c) 1999-2004 LSI Logic Corporation
ACPI: PCI Interrupt 0000:0e:01.0[A] -> GSI 29 (level, low) -> IRQ 169
mptbase: Initiating ioc0 bringup
....

On systems with <=4G ram, this does not occur. Also, just removing the 
vmalloc=256M (or changing it to =128M) parameter causes the system to 
continue booting.

I've tested this on the RH 2.6.9-11 kernel and also on the most recent 
kernel I could get to work (2.6.12.6 - there seems to be a problem with 
RHs mkinitrd for 2.6.13 and the MPT-drivers) with the same result.

Is this known? Anything I can do to assist with diagnosing or fixing this?

-S
-- 
Simen Thoresen, Wulfkit Support, Dolphin ICS
http://www.tysland.com/~simentt/cluster
