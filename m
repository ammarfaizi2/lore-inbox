Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbVDYVDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbVDYVDm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 17:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbVDYVCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 17:02:13 -0400
Received: from mail.kroah.org ([69.55.234.183]:9176 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261188AbVDYVAi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 17:00:38 -0400
Date: Mon, 25 Apr 2005 14:00:14 -0700
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Amit Gud <gud@eth.net>, Alan Stern <stern@rowland.harvard.edu>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       akpm@osdl.org, jgarzik@pobox.com, cramerj@intel.com,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [PATCH] PCI: Add pci shutdown ability
Message-ID: <20050425210014.GA25247@kroah.com>
References: <Pine.LNX.4.44L0.0504251128070.5751-100000@iolanthe.rowland.org> <20050425182951.GA23209@kroah.com> <SVLXCHCON1syWVLEFN00000099e@SVLXCHCON1.enterprise.veritas.com> <20050425185113.GC23209@kroah.com> <20050425190606.GA23763@kroah.com> <20050425204207.GA23724@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050425204207.GA23724@elf.ucw.cz>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2005 at 10:42:07PM +0200, Pavel Machek wrote:
> Hi!
> 
> > Well it seems that people are starting to want to hook the reboot
> > notifier, or the device shutdown facility in order to properly shutdown
> > pci drivers to make kexec work nicer.
> > 
> > So here's a patch for the PCI core that allows pci drivers to now just
> > add a "shutdown" notifier function that will be called when the system
> > is being shutdown.  It happens just after the reboot notifier happens,
> > and it should happen in the proper device tree order, so everyone should
> > be happy.
> > 
> > Any objections to this patch?
> 
> Yes.
> 
> I believe it should just do suspend(PMSG_SUSPEND) before system
> shutdown. If you think distintion between shutdown and suspend is
> important (I am not 100% convinced it is), we can just add flag
> saying "this is system shutdown".

Then why even have the device_shutdown() call and notifier in the struct
device_driver?

> Actually this patch should be in the queue somewhere... We had it in
> suse trees for a long time, and IMO it can solve problem easily.
> 
> 								Pavel
> 
> --- clean-git/kernel/sys.c	2005-04-23 23:21:55.000000000 +0200
> +++ linux/kernel/sys.c	2005-04-24 00:20:47.000000000 +0200
> @@ -404,6 +404,7 @@
>  	case LINUX_REBOOT_CMD_HALT:
>  		notifier_call_chain(&reboot_notifier_list, SYS_HALT, NULL);
>  		system_state = SYSTEM_HALT;
> +		device_suspend(PMSG_SUSPEND);
>  		device_shutdown();

Again, why keep device_shutdown() around at all then?

thanks,

greg k-h
