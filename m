Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268329AbUI2MQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268329AbUI2MQI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 08:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268333AbUI2MQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 08:16:08 -0400
Received: from magic.adaptec.com ([216.52.22.17]:26805 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S268329AbUI2MQA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 08:16:00 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] gdth update
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Date: Wed, 29 Sep 2004 14:15:57 +0200
Message-ID: <B51CDBDEB98C094BB6E1985861F53AF302DE00@nkse2k01.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] gdth update
Thread-Index: AcSmGXF41ip0/oAfQQ2KeCQlX8LxaAAAnj7Q
From: "Leubner, Achim" <Achim_Leubner@adaptec.com>
To: <arjanv@redhat.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 2004-09-28 at 13:12, Linux Kernel Mailing List wrote:
> >   * IO-mapping with virt_to_bus(), gdth_readb(), gdth_writeb(), ...
> > - * register_reboot_notifier() to get a notify on shutdown used
> > + * register_reboot_notifier() to get a notify on shutown used
> 
> why this change ?
>
OK, my fault.
 
> > +#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
> > +static irqreturn_t gdth_interrupt(int irq, void *dev_id, struct
pt_regs *regs);
> >  #else
> > -static void gdth_interrupt(int irq,struct pt_regs *regs);
> > +static void gdth_interrupt(int irq, void *dev_id, struct pt_regs
*regs);
> >  #endif
> 
> this really is the wrong way to do such irq prototype compatibility in
> drivers. *really*
> 
So please tell me what the right way should be. It works without any
problem.

> > +static struct file_operations gdth_fops = {
> > +#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
> > +    .ioctl   = gdth_ioctl,
> > +    .open    = gdth_open,
> > +    .release = gdth_close,
> > +#else
> > +    ioctl:gdth_ioctl,
> > +    open:gdth_open,
> > +    release:gdth_close,
> > +#endif
> 
> C99 initializers work in all kernel versions since it's a property of
> the C compiler not of the kernel. I wonder why you are putting this
> ifdef here....
>
Agree. If the initializers works also fine with compiler versions in
older distributions with the 2.4.x and 2.2.x kernels, the ifdef is
really useless. 
 
> the rest of your ifdefs are generally quite fishy too
unfortionately...
>
Could you please explain it exactly? I really want to learn what the
problems are to correct it in the next version.

