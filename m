Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264939AbSJOV6M>; Tue, 15 Oct 2002 17:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264941AbSJOV6M>; Tue, 15 Oct 2002 17:58:12 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:34057 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264939AbSJOV6L>;
	Tue, 15 Oct 2002 17:58:11 -0400
Date: Tue, 15 Oct 2002 15:04:09 -0700
From: Greg KH <greg@kroah.com>
To: Steven Dake <sdake@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] [PATCHES] Advanced TCA Hotswap Support in Linux Kernel
Message-ID: <20021015220409.GA16966@kroah.com>
References: <3DAB1007.6040400@mvista.com> <20021015052916.GA11190@kroah.com> <3DAC52A7.907@mvista.com> <20021015205200.GK15864@kroah.com> <3DAC89FA.9000505@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DAC89FA.9000505@mvista.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 02:34:50PM -0700, Steven Dake wrote:
> >Given that there are a number of kernel developers working their
> >respective asses off trying to get devfs out of the kernel (by obsoleting
> >it), I would not really recommend tying your driver to it if you want it
> >to be around for very long :)
> > 
> >
> What is replacing devfs?  Atleast for kernel 2.4, devfs is a good 
> solution.  Is something new in 2.5 used to provide device nodes at 
> kernel runtime?

A combination of /sbin/hotplug notification, and information in the
driverfs tree will enable userspace to create and remove device nodes
whereever and with whatever name they want to.

> We didn't drop picmg2.12 support at all.  What was dropped was the 
> initial prototype implementation that used those minors (and has been 
> replaced by a better implementation that doesn't use them).  PICMG 2.12 
> support (as well as redundant system slot) is still supported in the CGL 
> tress and in MontaVista Linux.  I don't know much about picmg 2.12 
> implementation, another developer @ Mvista is doing the work.

My main complaint (as the pci hotplug maintainer) is that Mvista isn't
trying to work with the community for their code.  I had a number of
good emails with the main developer (at the time), but unfortunatly I
haven't heard anything in quite some time.  Any proding you might
provide in this area would be greatly appreciated.

Otherwise Mvista is going to be supporting that patch outside of the
main tree for forever, and that can get old and expensive over time.

> >As I mentioned previously, this can probably be done in userspace (unless
> >you have some unreasonable performance reasons, what are the
> >requirements?)
> > 
> >
> 20 msec from hotswap request to disk extraction.

Yes, that sounds pretty unreasonable :)  What drives such a quick
request turnaround time?

> The functionality is intertwined in devfs_register_partition.  I don't 
> think I understand what you mean here, could you expand in mail?

Hm, ok, let me go dig up the patch again, ugh.  Ok, I don't really know
how, but it could proably be done cleaner :)

> Ok and I'll take a look at using ramfs and driverfs instead of devfs and 
> ioctls in both patches for the 2.5 tree.  We may probably keep the patch 
> for the 2.4 tree since I dont think there is driverfs or ramfs in 2.4.

Yes, ramfs is in 2.4, and the pci hotplug core uses a filesystem just
like this in the 2.4 kernel.  But if you want to keep your patch out of
the kernel, it's fine with me :)

> >That's up to the QLogic people, I'm just too confused with the vast
> >number of different drivers from them :)
> > 
> >
> Mark Bellon @ MontaVista is working with them to support their driver in 
> MontaVista Linux.  We have made a number of quality improvements and 
> submitted them back to Qlogic.  We have talked to their development team 
> and they would be willing to submit their Qlogic 6 driver to the Linux 
> kernel.  We can do the integration work here of including it in the 
> kernel.  Should I submit a patch to the list ?

Here, and/or to the linux-scsi mailing list.

thanks,

greg k-h
