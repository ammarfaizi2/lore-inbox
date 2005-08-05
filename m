Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263125AbVHEViz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263125AbVHEViz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 17:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263135AbVHEVf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 17:35:58 -0400
Received: from mail.kroah.org ([69.55.234.183]:32661 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263109AbVHEVdm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 17:33:42 -0400
Date: Fri, 5 Aug 2005 14:33:16 -0700
From: Greg KH <greg@kroah.com>
To: Dave Jones <davej@redhat.com>,
       Kristen Accardi <kristen.c.accardi@intel.com>,
       pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       rajesh.shah@intel.com
Subject: Re: [PATCH] use bus_slot number for name
Message-ID: <20050805213316.GA3239@kroah.com>
References: <1123269366.8917.39.camel@whizzy> <20050805195123.GN2241@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050805195123.GN2241@redhat.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 03:51:23PM -0400, Dave Jones wrote:
> On Fri, Aug 05, 2005 at 12:16:06PM -0700, Kristen Accardi wrote:
>  > For systems with multiple hotplug controllers, you need to use more than
>  > just the slot number to uniquely name the slot.  Without a unique slot
>  > name, the pci_hp_register() will fail.  This patch adds the bus number
>  > to the name.
>  > 
>  > Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
>  > 
>  > diff -uprN -X linux-2.6.13-rc4/Documentation/dontdiff linux-2.6.13-rc4/drivers/pci/hotplug/pciehp.h linux-2.6.13-rc4-shpchp-slot-name-fix/drivers/pci/hotplug/pciehp.h
>  > --- linux-2.6.13-rc4/drivers/pci/hotplug/pciehp.h	2005-07-28 15:44:44.000000000 -0700
>  > +++ linux-2.6.13-rc4-shpchp-slot-name-fix/drivers/pci/hotplug/pciehp.h	2005-08-04 17:57:18.000000000 -0700
>  > @@ -302,7 +302,7 @@ static inline void return_resource(struc
>  >  
>  >  static inline void make_slot_name(char *buffer, int buffer_size, struct slot *slot)
>  >  {
>  > -	snprintf(buffer, buffer_size, "%d", slot->number);
>  > +	snprintf(buffer, buffer_size, "%04d_%04d", slot->bus, slot->number);
>  >  }
> 
> Won't using..
> 
> 	snprintf(buffer, buffer_size, "%s", pci_name(slot));

As Kristen already said, a slot could refer to multiple pci_dev devices,
so I don't know how well this would really work out.

Although you might want to put the domain in that name, if known, as
large boxes might need that, right?

thanks,

greg k-h
