Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264718AbSJOSaq>; Tue, 15 Oct 2002 14:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264741AbSJOSaq>; Tue, 15 Oct 2002 14:30:46 -0400
Received: from fw-az.mvista.com ([65.200.49.158]:61687 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id <S264718AbSJOSao>; Tue, 15 Oct 2002 14:30:44 -0400
Message-ID: <3DAC60C6.9090507@mvista.com>
Date: Tue, 15 Oct 2002 11:39:02 -0700
From: Steven Dake <sdake@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] [PATCHES] Advanced TCA Hotswap Support in Linux Kernel
References: <3DAB1007.6040400@mvista.com> <20021015005909.GC10278@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

Responses below.

Greg KH wrote:

>On Mon, Oct 14, 2002 at 11:42:15AM -0700, Steven Dake wrote:
>  
>
>>lkml,
>>
>>http://www.sourceforge.net/project/showfiles.php?group_id=64580
>>
>>I am announcing a sourceforge project for developing support in Linux 
>>kernel for Advanced TCA (PICMG 3.0) architecture.  Advanced TCA is a 
>>technology where boards exist in a chassis and can either be processor 
>>nodes or storage nodes.  All boards in the chassis are connected by 
>>FibreChannel and Ethernet.  The blades can be hot added or hot removed 
>>while the Linux processor nodes are active, meaning, that the SCSI 
>>subsystem must add devices on insertion request and remove devices on 
>>ejection requests.  Further the typical /dev/sda naming of devices is 
>>not appropriate since device nodes can change depending on the insertion 
>>order of disks.
>>
>>These patches are for Linux 2.4.19 and work with the Qlogic 2300 
>>FibreChannel driver and at this point mostly support hotswap of the disk 
>>subsystem.
>>    
>>
>
>Some questions:
>	- is there a public spec for this architecture?
>  
>
The spec hasn't ratified yet and I don't have a copy (I only have 
pre-spec hardware).  I think distribution is limited to PICMG members 
once a spec is available, but I'm not sure.  Who needs specs anyway :)

>	- are you going to be generating a 2.5 version of this so that
>	  this feature can be added to the main kernel tree?
>
If you think it would be accepted, I'd spend the time making 2.5 kernel 
patches.  Beyond your other comments, any suggestions to get it accepted?

>	- Why don't you use the existing kernel way of notifying
>	  userspace of hotplug events, through /sbin/hotplug?
>
The hotplug events occur through IPMI (a system management interface 
specification) messages.  I'm not sure if the hotswap manager will go in 
the kernel or not, but if it were in the kernel, it could use 
/sbin/hotplug to notify management software of hotswap events (which 
would allow the scsi hotswap commands to be used to add or remove 
devices).  Initially I am going to probably do a user space manager 
since its simpler and I think that sort of thing probably belongs in 
user space.  It will access the IPMI driver, read hotswap events from 
the IPMI driver, and swap in and out devices and map/unmap devices via 
the ga mapper.

Perhaps what is really needed is a kernel driver that uses the IPMI 
driver kernel interface to pump disk device hotswap messages through 
/sbin/hotplug.  After I get a userspace implementation working (which is 
easier to debug and test) I can start work on something like this.  What 
would you think of that?  The nice thing about using /sbin/hotplug is 
more things can be scripted like automatically removing a MD disk if the 
hotswapped device is part of an MD device.

I've not started on this component yet and am just figuring out the IPMI 
messaging at this point.  Any comments you have on how to best integrate 
this into the current hotplug system would be highly welcomed.

>	- You create a lot of new ioctls, which is not nice.  You should
>	  probably do what was done for the pci hotplug subsystem, and
>	  create a ram based filesystem for this subsystem.  That way
>	  you don't need to have a /dev node, and the userspace tools
>	  become dirt simple.
>  
>
I'll have to look at that.  I'm not familiar with the ram based 
filesystem.  Could you point me to a source file that uses some of the 
interfaces?

Thanks
-steve

>thanks,
>
>greg k-h
>
>
>
>  
>

