Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261306AbVFHQKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbVFHQKw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 12:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbVFHQKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 12:10:11 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:6797 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S261340AbVFHQFL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 12:05:11 -0400
X-IronPort-AV: i="3.93,183,1115010000"; 
   d="scan'208"; a="252043287:sNHT25687950"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 2.6.12-rc3] modifications in firmware_class.c to support nohotplug
Date: Wed, 8 Jun 2005 11:04:09 -0500
Message-ID: <367215741E167A4CA813C8F12CE0143B0283F1FC@ausx2kmpc115.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 2.6.12-rc3] modifications in firmware_class.c to support nohotplug
Thread-Index: AcVsQrhUpUFRjboMQ/S95aqI0cqDpgAAHXzw
From: <Abhay_Salunke@Dell.com>
To: <dtor_core@ameritech.net>
Cc: <linux-kernel@vger.kernel.org>, <akpm@osdl.org>, <Matt_Domsch@Dell.com>,
       <greg@kroah.com>, <ranty@debian.org>
X-OriginalArrivalTime: 08 Jun 2005 16:04:30.0438 (UTC) FILETIME=[C0DF1060:01C56C43]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> Sent: Wednesday, June 08, 2005 10:56 AM
> To: Salunke, Abhay
> Cc: linux-kernel@vger.kernel.org; Andrew Morton; Salunke, Abhay;
Domsch,
> Matt; Greg KH; Manuel Estrada Sainz
> Subject: Re: [patch 2.6.12-rc3] modifications in firmware_class.c to
> support nohotplug
> 
> On 6/8/05, Abhay Salunke <Abhay_Salunke@dell.com> wrote:
> > This is a patch with modifications in firmware_class.c to have no
> hotplug
> > support.
> ...
> 
> > @@ -87,7 +87,7 @@ static struct class firmware_class = {
> >        .name           = "firmware",
> >        .hotplug        = firmware_class_hotplug,
> >        .release        = fw_class_dev_release,
> > -};
> > +};
> 
> Adds trailing whitespace.
> > @@ -364,6 +364,7 @@ fw_setup_class_device(struct firmware *f
> >                printk(KERN_ERR "%s: class_device_create_file
failed\n",
> >                       __FUNCTION__);
> >                goto error_unreg;
> > +r
> 
> What is this?
> > -out:
> > -       return retval;
> > +       return _request_firmware(firmware_p, name, device,
> FW_DO_HOTPLUG);
> >  }
> 
> Tab vs. space identation.
> 
> >  /* Async support */
> >  struct firmware_work {
> >        struct work_struct work;
> > -       struct module *module;
> > +       struct module *module;
> >        const char *name;
> >        struct device *device;
> >        void *context;
> > +       int hotplug;
> >        void (*cont)(const struct firmware *fw, void *context);
> >  };
Will fix it all.
> 
> I think it would be better if you just have request_firmware and
> request_firmware_nowait accept timeout parameter that would override
> default timeout in firmware_class. 0 would mean use default,
> MAX_SCHED_TIMEOUT - wait indefinitely.

But we still need to avoid hotplug being invoked as we need it be a
manual process.

Thanks
Abhay
