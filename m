Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965105AbWEYKZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965105AbWEYKZQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 06:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965107AbWEYKZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 06:25:16 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:21710 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S965105AbWEYKZP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 06:25:15 -0400
Subject: Re: [PATCH 1/2] request_firmware without a device
From: Marcel Holtmann <marcel@holtmann.org>
To: Greg KH <greg@kroah.com>
Cc: Shaohua Li <shaohua.li@intel.com>, lkml <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060525040134.GA29974@kroah.com>
References: <1148529045.32046.102.camel@sli10-desk.sh.intel.com>
	 <20060525040134.GA29974@kroah.com>
Content-Type: text/plain
Date: Thu, 25 May 2006 12:24:54 +0200
Message-Id: <1148552694.4734.10.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> > The patch allows calling request_firmware without a 'struct device'.
> > It appears we just need a name here from 'struct device'. I changed it
> > to use a kobject as Patrick suggested.
> > Next patch will use the new API to request firmware (microcode) for a CPU.
> 
> But a cpu does have a struct device.  Why not just use that?
> 
> > +fw_setup_class_device_id(struct class_device *class_dev, struct kobject *kobj)
> >  {
> >  	/* XXX warning we should watch out for name collisions */
> > -	strlcpy(class_dev->class_id, dev->bus_id, BUS_ID_SIZE);
> > +	strlcpy(class_dev->class_id, kobj->k_name, BUS_ID_SIZE);
> 
> There's a function for this, kobject_name(), please never touch k_name
> directly.
> 
> > +EXPORT_SYMBOL(request_firmware_kobj);
> 
> Ick, if you really want to do this, just fix up all callers of
> request_firmware(), there aren't that many of them.
> 
> But I don't recommend it anyway.

I also disagree with this change at all. The callers of request_firmware
should not fiddle around with kobject's to make this work. All of them
have their struct device and they should use it.

So I would propose that we fix the caller and the not request_firmware
code. However one option would be calling it with NULL as device
argument and it registers itself a dummy device for the operation.

Regards

Marcel


