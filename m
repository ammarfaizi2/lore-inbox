Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbUBZASz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 19:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbUBZASz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 19:18:55 -0500
Received: from mail.kroah.org ([65.200.24.183]:21741 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261656AbUBZASx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 19:18:53 -0500
Date: Wed, 25 Feb 2004 16:18:31 -0800
From: Greg KH <greg@kroah.com>
To: Hollis Blanchard <hollisb@us.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Ryan Arnold <rsa@us.ibm.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Dave Boutcher <sleddog@us.ibm.com>
Subject: Re: device/kobject naming
Message-ID: <20040226001830.GB3702@kroah.com>
References: <1077667227.21201.73.camel@SigurRos.rchland.ibm.com> <20040225012845.GA3909@kroah.com> <opr3woijnwl6e53g@us.ibm.com> <20040225042224.GA5135@kroah.com> <1077708874.22213.13.camel@gaston> <C4149BD3-67A9-11D8-B826-000A95A0560C@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C4149BD3-67A9-11D8-B826-000A95A0560C@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 09:46:24AM -0600, Hollis Blanchard wrote:
> On Feb 25, 2004, at 5:34 AM, Benjamin Herrenschmidt wrote:
> >On Wed, 2004-02-25 at 15:22, Greg KH wrote:
> >>I agree.  Is there any reason we _have_ to stick with the OF names?  
> >>It
> >>seems to me to make more sense here not to, to make it more like the
> >>rest of the kernel.
> >>
> >>That is, if the address after the @ is unique.  Is that always the 
> >>case?
> >
> >One thing though is that it's only unique at a given level of
> >hierarchy. The Unit Address in OF has no meaning outside of the
> >context of the parent bus. That may be just fine for sysfs, but
> >if I take as an example the PCI devices, they do have a globally
> >unique ID here with the domain number.
> 
> Yes, that's certainly the case. Every unit address on the virtual bus 
> will be unique, but device_add() uses dev.bus_id as the kobject name, 
> which is system-wide.
> 
> Apparently PCI gets away with multiple busses by encoding the domain 
> and bus IDs into dev.bus_id along with the slot number. Even then, it's 
> just kind of coincidence that nothing else wants to register kobjects 
> with names like 0000:00:0b.0, right? Unless we want to start defining 
> mandatory "domains" for every type of device and prefixing things like 
> that...

No, I think you are confused.  The only thing that has to be unique in
the kobject/device name is it must be unique for the bus it is on.

So for PCI we encode the domain and bus id into .bus_id as we know it
will be unique on this system.  There is no "coincidence" involved at
all.  Same thing with USB, and all other busses.  You only have to be
unique for your specific bus.

So for this bus, that is all that is needed.  You don't have to worry
about the PCI/USB/FooBUS namespace at all.

> At any rate, virtual IO devices effectively have just a slot number and 
> nothing else. Do you really want to start registering kobjects with 
> names like "30000000"?

Why not?  We do it for every other bus type.

> Or what about "vio:30000000", and then have it show up as
> "/sys/devices/vio/vio:30000000"? Seems redundant to me.

Exactly, it is redundant.  That's why you don't need the "vio:" portion.

Does this help out?

thanks,

greg k-h
