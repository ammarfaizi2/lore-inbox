Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262291AbSJOAxD>; Mon, 14 Oct 2002 20:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262297AbSJOAxD>; Mon, 14 Oct 2002 20:53:03 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:59910 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262291AbSJOAxD>;
	Mon, 14 Oct 2002 20:53:03 -0400
Date: Mon, 14 Oct 2002 17:59:09 -0700
From: Greg KH <greg@kroah.com>
To: Steven Dake <sdake@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] [PATCHES] Advanced TCA Hotswap Support in Linux Kernel
Message-ID: <20021015005909.GC10278@kroah.com>
References: <3DAB1007.6040400@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DAB1007.6040400@mvista.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2002 at 11:42:15AM -0700, Steven Dake wrote:
> lkml,
> 
> http://www.sourceforge.net/project/showfiles.php?group_id=64580
> 
> I am announcing a sourceforge project for developing support in Linux 
> kernel for Advanced TCA (PICMG 3.0) architecture.  Advanced TCA is a 
> technology where boards exist in a chassis and can either be processor 
> nodes or storage nodes.  All boards in the chassis are connected by 
> FibreChannel and Ethernet.  The blades can be hot added or hot removed 
> while the Linux processor nodes are active, meaning, that the SCSI 
> subsystem must add devices on insertion request and remove devices on 
> ejection requests.  Further the typical /dev/sda naming of devices is 
> not appropriate since device nodes can change depending on the insertion 
> order of disks.
> 
> These patches are for Linux 2.4.19 and work with the Qlogic 2300 
> FibreChannel driver and at this point mostly support hotswap of the disk 
> subsystem.

Some questions:
	- is there a public spec for this architecture?
	- are you going to be generating a 2.5 version of this so that
	  this feature can be added to the main kernel tree?
	- Why don't you use the existing kernel way of notifying
	  userspace of hotplug events, through /sbin/hotplug?
	- You create a lot of new ioctls, which is not nice.  You should
	  probably do what was done for the pci hotplug subsystem, and
	  create a ram based filesystem for this subsystem.  That way
	  you don't need to have a /dev node, and the userspace tools
	  become dirt simple.

thanks,

greg k-h
