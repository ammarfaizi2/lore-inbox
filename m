Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263067AbUCMJeK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 04:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263074AbUCMJeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 04:34:10 -0500
Received: from imap.gmx.net ([213.165.64.20]:26065 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263067AbUCMJeE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 04:34:04 -0500
X-Authenticated: #4512188
Message-ID: <4052D58F.40104@gmx.de>
Date: Sat, 13 Mar 2004 10:34:07 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 021 release
References: <20040303000957.GA11755@kroah.com> <404F1085.5080808@gmx.de> <20040310225114.GD24336@kroah.com> <404FA1F8.9060306@gmx.de> <20040311012127.GC11828@kroah.com>
In-Reply-To: <20040311012127.GC11828@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Thu, Mar 11, 2004 at 12:17:12AM +0100, Prakash K. Cheemplavam wrote:
> 
>>Greg KH wrote:
>>
>>>On Wed, Mar 10, 2004 at 01:56:37PM +0100, Prakash K. Cheemplavam wrote:
>>>
>>>>I have a problem with udev and my ZIP drive (using latest mm based 
>>>>kernel):
>>>>
>>>>When I insert a zip the /dev for the partition doesn't get created (ie 
>>>>hdd4, fdisk shows it though).
> 
> See the manpage for udev and look at the NAME{all_partitions} section.
> 

Well, I tried several variatons of following rule:

SYSFS{dev}="22:64", KERNEL="hdd", NAME{all_partitions}="hdd%n"

But no partitions popped up. I searched a bit in lkml and some time ago, 
there was a thread about a jaz drive with the same problem. It rather 
seems udev doesn't see the partitions appearing or I do something wrong.

For the time being I just put this into my local.start:

mknod -m 660 /dev/hdd4 b 22 68
chown root:disk hdd4

If you are sure udev should hanlde it, it would be nice if you kick me a 
bit further into the right direction...

Prakash

PS:udevinfo -a -p /sys/block/hdd/

udevinfo starts with the device the node belongs to and then walks up the
device chain to print for every device found all possibly useful attributes
in the udev key format.
Only attributes within one device section may be used in a rule to match the
device for which the node will be created.

device '/sys/block/hdd' has major:minor 22:64
   looking at class device '/sys/block/hdd':
     SYSFS{dev}="22:64"
     SYSFS{range}="64"
     SYSFS{size}="196608"
     SYSFS{stat}="      35        0       42      747        0        0 
        0        0        0      747      747"

follow the class device's "device"
   looking at the device chain at 
'/sys/devices/pci0000:00/0000:00:09.0/ide1/1.1':
     BUS="ide"
     ID="1.1"
     SYSFS{detach_state}="0"

   looking at the device chain at 
'/sys/devices/pci0000:00/0000:00:09.0/ide1':
     BUS=""
     ID="ide1"
     SYSFS{detach_state}="0"

   looking at the device chain at '/sys/devices/pci0000:00/0000:00:09.0':
     BUS="pci"
     ID="0000:00:09.0"
     SYSFS{detach_state}="0"
     SYSFS{vendor}="0x10de"
     SYSFS{device}="0x0065"
     SYSFS{subsystem_vendor}="0x147b"
     SYSFS{subsystem_device}="0x1c00"
     SYSFS{class}="0x01018a"
     SYSFS{irq}="0"

   looking at the device chain at '/sys/devices/pci0000:00':
     BUS=""
     ID="pci0000:00"
     SYSFS{detach_state}="0"

