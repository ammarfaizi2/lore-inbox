Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759657AbWLFCIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759657AbWLFCIO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 21:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759661AbWLFCIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 21:08:14 -0500
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:41291 "EHLO
	rwcrmhc11.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759654AbWLFCIN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 21:08:13 -0500
Message-ID: <457625CF.2080105@comcast.net>
Date: Tue, 05 Dec 2006 21:07:11 -0500
From: Ed Sweetman <safemode2@comcast.net>
User-Agent: Icedove 1.5.0.8 (X11/20061129)
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Why SCSI module needed for PCI-IDE ATA only disks ?
References: <fa.juE97gahpb4n2kNNH/Todtcvh3s@ifi.uio.no> <fa.IqtlZas3d+ZPuhF6S6N/ivdF8Wo@ifi.uio.no> <fa.HDRhmOhDQliejH7ijqJBWw9Jw0o@ifi.uio.no> <45761B2F.9060804@shaw.ca>
In-Reply-To: <45761B2F.9060804@shaw.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> Ed Sweetman wrote:
>> Jeff Garzik wrote:
>>> Bernard Pidoux wrote:
>>>> I am asking why need to compile the following modules while I do not
>>>> have any SCSI device ?
>>>
>>> libata uses SCSI to provide a lot of infrastructure that it would 
>>> otherwise have to recreate.  Also, using SCSI meant that it 
>>> automatically worked in existing installers.
>>>
>>>     Jeff
>>>
>> This confusion could easily be remedied by explaining the requirement 
>> in the Help output for libata drivers/section.  Also, making a 
>> dependency in the menu (since there is one) or automatically 
>> selecting the required scsi items when you select a libata driver 
>> would seem logical. As it is, nothing is said of scsi requirements in 
>> menuconfig. Trying to boot a machine without compiling the scsi 
>> drivers (something you're allowed to do) results in a system that 
>> boots and initializes the ata busses but can't communicate to any of 
>> the drives on them, (useless).
>
> You can't select libata drivers without the SCSI core. However, you 
> can select libata drivers without the SCSI disk (sd) or the SCSI CD 
> (sr) drivers. However, that's a legitimate configuration as you may 
> have only hard disks, only CD drives, etc. and there would be no need 
> to build the other module. This isn't a major problem for most 
> standard configurations as those drivers are needed to handle things 
> like USB and FireWire flash drives, external HDs/optical drives, etc. 
> anyway.
>
What's not a legitimate configuration is libata drivers, no low level 
scsi drivers, no ide drivers and no sd,sr,sg drivers.  Yet, that is the 
configuration the kernel currently gives you. How is that more correct 
than any of the 3 solutions I have suggested?

The point is there is nothing in the help section in libata to tell you 
that these "scsi" drivers are needed for disk / cdrom / generic device 
access in libata.  Indeed, there is no obvious connection to the two. 

Either configuration options need to be put in the libata directory that 
would just select the drivers (libata disk, cdrom, generic configuration 
options which would just enable the appropriate config variable, in 
other words in the menu config have two config directives which would 
enable the same drivers but be under different submenus to avoid 
confusion), or a short description in the help dialog to tell users that 
they have to enable those scsi drivers under the scsi section to use 
their drivers under the libata section.  

It's not safe to assume people will have those drivers compiled because 
of usb or firewire or flash drives.  Assuming that situation is 10 times 
more problematic than any possible argument against just selecting those 
scsi drivers automatically and letting the user  deselect them as needed 
when they select a libata driver.


Personaly, I prefer a help dialog blurb explaining that the user has to 
enable certain scsi drivers to actually use their libata driven 
devices.    That, at the very least, I believe is necessary and not 
asking much.  

I've made patches before that impliment these trivial features in 
menuconfig. In the grand scheme of things this isn't that important to 
kernel development, but it's going to get more and more feedback as more 
people move to libata and eventually it will be fixed in some manner 
similar to those i've mentioned, I think it would just be better to do 
it now than wait until the mailing list is filled with end users asking 
why they need scsi when they obviously only have sata/ide and want to 
use libata.
