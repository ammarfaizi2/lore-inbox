Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312529AbSEHJV4>; Wed, 8 May 2002 05:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312560AbSEHJVz>; Wed, 8 May 2002 05:21:55 -0400
Received: from [195.63.194.11] ([195.63.194.11]:40966 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S312529AbSEHJVx>; Wed, 8 May 2002 05:21:53 -0400
Message-ID: <3CD8DF5A.9070402@evision-ventures.com>
Date: Wed, 08 May 2002 10:18:34 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Patrick Mochel <mochel@osdl.org>
CC: benh@kernel.crashing.org, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
In-Reply-To: <Pine.LNX.4.33.0205071053070.6307-100000@segfault.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Patrick Mochel napisa?:
> On Tue, 7 May 2002 benh@kernel.crashing.org wrote:
> 
> 
>>>	/driverfs/root/pci0/00:1f.4/usb_bus/000/
>>>
>>>and it wouldn't be impossible (or even necessarily very hard) to make an
>>>IDE controller export the "IDE device tree" the same way a USB controller
>>>now exports the "USB device tree".
>>>
>>>For things like hotplug etc, I think driverfs is eventually the only way
>>>to go, simply because it gives you the full (and unambiguous) path to
>>>_any_ device, and is completely bus-agnostic.
>>>
>>>But there is definitely a potential backwards-compatibility-issue.
>>
>>One interesting thing here would be to have some optional link between
>>the bus-oriented device tree and the function-oriented tree (ie. devfs
>>or simply /dev). For example, an IDE node in driverfs could eventually
>>hold symlinks to the entries it provides in /dev when using devfs (or
>>just provide major/minor when not using devfs).
> 
> 
> I agree with such a concept, but as Linus said, it should go the other 
> way, from the functional interface to physical interface. There are many 
> details involved in doing such a thing, but it should work something like 
> this:
> 
> The logical subystems (ide disks, networking, etc) would register with the 
> device model core and get a directory in driverfs:
> 
> /driverfs/class/ide/
> 
> Devices would be discovered and get a driverfs directory representing the 
> physical location of the device:
> 
> /driverfs/root/pci0/07.2/
> 
> Note that no drivers have been bound to the device. When the driver is 
> bound, it registers the device with the subsystem, passing in a 
> subsystem-specific structure. These can be made to point in some way to 
> the generic struct device of the device (from which the physical path can 
> be inferred).
> 
> When this happens, the subsystem creates a directory underneath its 
> driverfs directory, so you get:
> 
> /driverfs/class/ide/0/
> 
> And, a symlink is created to point to the directory in the physical path. 
> As the driver discovers partitions on the device, it can create special 
> nodes in its class directory. 
> 
> At this point, userspace can be notified (via /sbin/hotplug). That can 
> create symlinks in /dev to the nodes that were just created, emulating 
> current /dev behavior. 
> 
> So, what does this do? To an extent, it reengineers the funtionality of 
> devfs. I'll be the first to admit it. However, it centers less around the 
> filesystem, and more on the device model core. 
> 
> Most devices already register with their subsystems, so having the 
> subsystesm pass device info onto the core is relatively easy. 
> 
> As partitions are discovered, you get paths like:
> 
> /driverfs/class/ide/0/2

Just a side note...
Please please name it /devices/ Some old boys like me (age 30)
can gain from similarities with some quite common "legacy" systems.
We don't have to "invent" for the sake of it.

And /devices/ is the way I have named it in the corresponding
documentation.

