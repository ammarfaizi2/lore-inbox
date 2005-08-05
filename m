Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261883AbVHEUsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261883AbVHEUsq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 16:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbVHEUsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 16:48:46 -0400
Received: from fmr19.intel.com ([134.134.136.18]:48336 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S263152AbVHEUsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 16:48:01 -0400
Subject: Re: [PATCH] use bus_slot number for name
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: Dave Jones <davej@redhat.com>
Cc: pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       greg@kroah.com, rajesh.shah@intel.com
In-Reply-To: <20050805195123.GN2241@redhat.com>
References: <1123269366.8917.39.camel@whizzy>
	 <20050805195123.GN2241@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 05 Aug 2005 13:47:36 -0700
Message-Id: <1123274856.8917.54.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
X-OriginalArrivalTime: 05 Aug 2005 20:47:37.0041 (UTC) FILETIME=[E9A27C10:01C599FE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-05 at 15:51 -0400, Dave Jones wrote:
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
> 
> work equally as well, and also future-proof this ?
>  
> 		Dave

Well, it isn't as convenient since pci_dev is not available from the
slot structure. But I will do it if this is the general consensus.

