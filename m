Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267418AbTA3FkS>; Thu, 30 Jan 2003 00:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267421AbTA3FkR>; Thu, 30 Jan 2003 00:40:17 -0500
Received: from fmr01.intel.com ([192.55.52.18]:24530 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S267418AbTA3FkR>;
	Thu, 30 Jan 2003 00:40:17 -0500
Date: Thu, 30 Jan 2003 13:46:35 +0800 (CST)
From: Stanley Wang <stanley.wang@linux.co.intel.com>
X-X-Sender: stanley@manticore.sh.intel.com
To: Greg KH <greg@kroah.com>
cc: Stanley Wang <stanley.wang@linux.co.intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       PCI_Hot_Plug_Discuss <pcihpd-discuss@lists.sourceforge.net>
Subject: Re: [PATCH] Replace pcihpfs with sysfs.
In-Reply-To: <20030130052313.GK12898@kroah.com>
Message-ID: <Pine.LNX.4.44.0301301342370.21512-100000@manticore.sh.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jan 2003, Greg KH wrote:

> On Thu, Jan 30, 2003 at 11:21:54AM +0800, Stanley Wang wrote:
> > On Wed, 22 Jan 2003, Greg KH wrote:
> > 
> > > > diff -Nru a/drivers/hotplug/cpci_hotplug_core.c b/drivers/hotplug/cpci_hotplug_core.c
> > > > --- a/drivers/hotplug/cpci_hotplug_core.c	Wed Jan 22 09:30:20 2003
> > > > +++ b/drivers/hotplug/cpci_hotplug_core.c	Wed Jan 22 09:30:20 2003
> > > > @@ -130,7 +130,7 @@
> > > >  		return -EINVAL;
> > > >  	memcpy(&info, hotplug_slot->info, sizeof(struct hotplug_slot_info));
> > > >  	info.latch_status = value;
> > > > -	return pci_hp_change_slot_info(hotplug_slot->name, &info);
> > > > +	return 0;
> > > 
> > > We really need to keep this functionality.  Unfortunatly sysfs doesn't
> > > support that yet.  I'd keep the call to pci_hp_change_slot_info() around
> > > to point out that this needs to be fixed in sysfs.
> > Sorry for my carelessness. I found that we could implement this function
> > with sysfs. Following the patch against my last patch. And I will resend a
> > new updated all-in-one patch to you.
> 
> No, this patch does not update the proper file within sysfs, only the
> directory entry, which isn't what we really want.  I just sent off the
> following patch to Pat Mochel that adds sysfs_update_file() to sysfs,
> and modified the pci hotplug core to use it.  I've already applied your
> previous patches, so you don't have to resend anything to me :)
Yes, you ar right. Although I think we could find the inode through the 
kobj->dentry finally, but the more elegant way is to implement it in sysfs :)

Thanks.

Regards,
-Stan 
-- 
Opinions expressed are those of the author and do not represent Intel
Corporation


