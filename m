Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbWEIX3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbWEIX3s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 19:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWEIX3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 19:29:48 -0400
Received: from wr-out-0506.google.com ([64.233.184.232]:33814 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932094AbWEIX3r convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 19:29:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WOuA0y7E0wrqhNXEtPbuyxUE5bQbOc8MM5dhG7Etjt25cD/iy1adXerDj6yQWeYQ6Nhi+T8Cuew13kOPICDkQ0gPOlSlzQWhmVuC1Vz2NRS/W+3upe5pHSW7JtYPxFBIjfiUP2xNK/lf5sYbM0PudbDAkswASM2sCwwPsvkKBjo=
Message-ID: <df35dfeb0605091629y6f2390f3lad8f99c7aad62c4f@mail.gmail.com>
Date: Tue, 9 May 2006 16:29:47 -0700
From: "Yum Rayan" <yum.rayan@gmail.com>
To: amah@highpoint-tech.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, akpm@osdl.org
Subject: Re:[PATCH] hptiop: HighPoint RocketRAID 3xxx controller driver
In-Reply-To: <464B3C0C5BFD894FADEFDD94B6D734E488181E@taus-ies1.dom1.taus.us.thales>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <464B3C0C5BFD894FADEFDD94B6D734E488181E@taus-ies1.dom1.taus.us.thales>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +static ssize_t hptiop_show_devicelist(struct class_device *class_dev,
> char
> *buf)

There is a one value per sysfs attribute rule. Seems like you are
returning quite some info here.

> + /* map buffer to kernel. */
> + if (ioctl_k.inbuf_size) {
> +  ioctl_k.inbuf = kmalloc(ioctl_k.inbuf_size, GFP_KERNEL);
> +  if (!ioctl_k.inbuf) {
> +   dprintk("scsi%d: fail to alloc inbuf\n",
> +     hba->host->host_no);
> +   err = -ENOMEM;
> +   goto err_exit;
> +  }
> +
> +  if (copy_from_user(ioctl_k.inbuf,
> +    ioctl_u->inbuf, ioctl_k.inbuf_size)) {
> +   goto err_exit;
> +  }

You are essentially wrapping ioctl with sysfs and passing user space
buffers....

> + .proc_name                  = driver_name,

I believe this is going away.

> + printk(KERN_INFO "%s %s\n", driver_name_long, driver_ver);
> +
> + return pci_module_init(&hptiop_pci_driver);
> +}
> +

pci_register_driver? pci.h indicates that pci_module_init is being obsoleted...
