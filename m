Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030267AbWEZDmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030267AbWEZDmT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 23:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030281AbWEZDmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 23:42:19 -0400
Received: from mga02.intel.com ([134.134.136.20]:34937 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030275AbWEZDmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 23:42:18 -0400
X-IronPort-AV: i="4.05,174,1146466800"; 
   d="scan'208"; a="41607305:sNHT15242416"
Subject: Re: [PATCH 1/2] request_firmware without a device
From: Shaohua Li <shaohua.li@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1148552694.4734.10.camel@localhost>
References: <1148529045.32046.102.camel@sli10-desk.sh.intel.com>
	 <20060525040134.GA29974@kroah.com>  <1148552694.4734.10.camel@localhost>
Content-Type: text/plain
Date: Fri, 26 May 2006 11:40:39 +0800
Message-Id: <1148614839.32046.143.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-05-25 at 12:24 +0200, Marcel Holtmann wrote:
> Hi Greg,
> 
> > > The patch allows calling request_firmware without a 'struct device'.
> > > It appears we just need a name here from 'struct device'. I changed it
> > > to use a kobject as Patrick suggested.
> > > Next patch will use the new API to request firmware (microcode) for a CPU.
> > 
> > But a cpu does have a struct device.  Why not just use that?
> > 
> > > +fw_setup_class_device_id(struct class_device *class_dev, struct kobject *kobj)
> > >  {
> > >  	/* XXX warning we should watch out for name collisions */
> > > -	strlcpy(class_dev->class_id, dev->bus_id, BUS_ID_SIZE);
> > > +	strlcpy(class_dev->class_id, kobj->k_name, BUS_ID_SIZE);
> > 
> > There's a function for this, kobject_name(), please never touch k_name
> > directly.
> > 
> > > +EXPORT_SYMBOL(request_firmware_kobj);
> > 
> > Ick, if you really want to do this, just fix up all callers of
> > request_firmware(), there aren't that many of them.
> > 
> > But I don't recommend it anyway.
> 
> I also disagree with this change at all. The callers of request_firmware
> should not fiddle around with kobject's to make this work. All of them
> have their struct device and they should use it.
So why we need a 'struct device'? I didn't see any point we need it. We
just need a 'name'.

> So I would propose that we fix the caller and the not request_firmware
> code. However one option would be calling it with NULL as device
> argument and it registers itself a dummy device for the operation.
This doesn't work, as we need a 'name'.

do we really need to differentiate between sysdev and device anymore. I
> recall a plan to unify all devices, but I might be wrong.
I'd like this idea. But it means many works. In addition, a sysdev could
have multiple drivers, and a 'device' can't to me.

Thanks,
Shaohua
