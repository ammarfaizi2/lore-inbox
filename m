Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261738AbVFQF4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbVFQF4N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 01:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbVFQF4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 01:56:13 -0400
Received: from mail.kroah.org ([69.55.234.183]:45008 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261738AbVFQF4I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 01:56:08 -0400
Date: Thu, 16 Jun 2005 22:55:55 -0700
From: Greg KH <greg@kroah.com>
To: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Oops calling sysfs_create_link() from pci_probe()
Message-ID: <20050617055555.GA16371@kroah.com>
References: <42B1D9AE.5000002@adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B1D9AE.5000002@adaptec.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2005 at 03:57:34PM -0400, Luben Tuikov wrote:
> Hi,
> 
> I'm calling
> 
> sysfs_create_link(&class->kobj,
> 		  &pcidev->driver->driver.kobj, "driver");
> 
> To create a link from a syfs directory of an object which I've
> created with class_device_regsiter(), to point to the
> driver directory of the pci driver.

Ick, why?  Shouldn't something like this be done in the driver core, and
not in the individual drivers?

> This is effectively called at the bottom of the pci_driver->probe
> function.
> 
> But I get this oops:
>  printing eip:
> c0229e7b
> *pde = 00000000
> Oops: 0000 [#1]
> PREEMPT SMP 
> Modules linked in: aic94xx sas_class
> CPU:    0
> EIP:    0060:[<c0229e7b>]    Not tainted VLI
> EFLAGS: 00010296   (2.6.12-rc6) 
> EIP is at kref_get+0xb/0x50

Looks like one of the kobjects that you are wanting to link is not fully
initialized and registered with sysfs.  Where are you getting that
"&class->kobj" from?

Have a pointer to your patch anywhere?

Also, try turning on kobject and driver core debugging, you should get a
lot of helpful information in your syslog right before this oops.

thanks,

greg k-h
