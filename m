Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315929AbSGARgt>; Mon, 1 Jul 2002 13:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315941AbSGARgs>; Mon, 1 Jul 2002 13:36:48 -0400
Received: from air-2.osdl.org ([65.172.181.6]:7581 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S315929AbSGARgs>;
	Mon, 1 Jul 2002 13:36:48 -0400
Date: Mon, 1 Jul 2002 10:33:44 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: Ihno Krumreich <ihno@suse.de>
cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] /proc/scsi/map
In-Reply-To: <20020626180350.A29197@wotan.suse.de>
Message-ID: <Pine.LNX.4.33.0207011027050.8496-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> by following the discussion I still miss a naming sceme for
> devices like disks, tapes, cdrom for the user (no kernelhackers, but the
> daily user running the system for some productive work). Does there exist
> a naming sceme for persistant names for those devices? I think of something
> like scsidev (http://www.garloff.de/kurt/linux/scsidev/#scsidev). 
> 
> I think the scsidev idea could be extended to a general sceme that
> satisfies all technologies (not only ide and scsi).
> 
> I think of something like 
> 
> /dev/<device-type>/<technologie>_<Uniq-Number>_<Bus-number>_<Target>_<Lun>_<Device_type_specific>
...
> Beside some standard devices, the devices could be created
> 
> - at system start for coldplugged devices
> - by /sbin/hotplug for hotpluged devices
> 
> This naming sceme could be used for kernel 2.4 by creating nodes and for
> kernel 2.5 by making symbolic links to /devices.

We're intending to leave the naming scheme entirely up to userspace. The 
kernel will not create/impose any type of default naming scheme for 
devices. 

When a device is registered with the class that it belongs to (disk, 
cdrom, sound, etc), /sbin/hotplug will be called with the path to the 
device. This path will correspond to a driverfs path for the device. 
/sbin/hotplug will then be able to ascertain all necessary information 
about the device to create device nodes for it, including major and minor 
numbers. 

It will be up to userspace to process this data to determine what device 
nodes it will create. We have some starting ideas concerning this. Once I 
get settled back in, I'll post some documentation on everything that was 
discussed in Ottawa, and how we propose to do this...

	-pat

