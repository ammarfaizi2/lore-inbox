Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965030AbWEYEus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965030AbWEYEus (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 00:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965031AbWEYEur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 00:50:47 -0400
Received: from mga02.intel.com ([134.134.136.20]:6323 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S965030AbWEYEur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 00:50:47 -0400
X-IronPort-AV: i="4.05,170,1146466800"; 
   d="scan'208"; a="41065237:sNHT14671104"
Subject: Re: [PATCH 1/2] request_firmware without a device
From: Shaohua Li <shaohua.li@intel.com>
To: Greg KH <greg@kroah.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060525040134.GA29974@kroah.com>
References: <1148529045.32046.102.camel@sli10-desk.sh.intel.com>
	 <20060525040134.GA29974@kroah.com>
Content-Type: text/plain
Date: Thu, 25 May 2006 12:49:10 +0800
Message-Id: <1148532550.32046.107.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-24 at 21:01 -0700, Greg KH wrote:
> On Thu, May 25, 2006 at 11:50:45AM +0800, Shaohua Li wrote:
> > The patch allows calling request_firmware without a 'struct device'.
> > It appears we just need a name here from 'struct device'. I changed it
> > to use a kobject as Patrick suggested.
> > Next patch will use the new API to request firmware (microcode) for a CPU.
> 
> But a cpu does have a struct device.  Why not just use that?
It's a sysdev, no 'struct device' in it, IIRC.

> > +fw_setup_class_device_id(struct class_device *class_dev, struct kobject *kobj)
> >  {
> >  	/* XXX warning we should watch out for name collisions */
> > -	strlcpy(class_dev->class_id, dev->bus_id, BUS_ID_SIZE);
> > +	strlcpy(class_dev->class_id, kobj->k_name, BUS_ID_SIZE);
> 
> There's a function for this, kobject_name(), please never touch k_name
> directly.
Ok, will do.

> > +EXPORT_SYMBOL(request_firmware_kobj);
> 
> Ick, if you really want to do this, just fix up all callers of
> request_firmware(), there aren't that many of them.
> 
> But I don't recommend it anyway.
I didn't see why we need a 'struct device' for request_firmware. It just
needs a name to me.

Thanks,
Shaohua
