Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbVFCSWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbVFCSWQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 14:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVFCSWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 14:22:15 -0400
Received: from mail.kroah.org ([69.55.234.183]:25265 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261366AbVFCSWC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 14:22:02 -0400
Date: Fri, 3 Jun 2005 11:21:47 -0700
From: Greg KH <greg@kroah.com>
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>,
       Alan Stern <stern@rowland.harvard.edu>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [RFC/PATCH] Kdump: Disabling PCI interrupts in capture kernel
Message-ID: <20050603182147.GB5751@kroah.com>
References: <20050603112524.GB7022@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050603112524.GB7022@in.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2005 at 04:55:24PM +0530, Vivek Goyal wrote:
> Hi,
> 
> In kdump, sometimes, general driver initialization issues seems to be cropping 
> in second kernel due to devices not being shutdown during crash and these 
> devices are sending interrupts while second kernel is booting and drivers are 
> not expecting any interrupts yet.

What are the errors you are seeing?
How would the drivers be able to be getting interrupts delivered to them
if they haven't registered the irq handler yet?

> In some cases, we are observing a storm of interrupts while second kernel 
> is booting and kernel disables that irq line. May be the case of stuck irq
> line because it is shared level triggered irq and there is no driver
> loaded for the device. 
> 
> So, we need something generic which disables interrupt generation from device
> until a driver has been registered for that device and driver is ready to 
> receive the interrupts. PCI specifications (ver 2.3 onwards), have introduced
> interrupt disable bit in command register to disable interrupt generation
> from the device. This can become handy here. In capture kernel, traverse all 
> the PCI devices, disable interrupt generation. Enable the interrupt generation
> back once the driver for that device registers. May be after the probe handler 
> has run. In probe handler, driver can reset the device or register for irq so 
> that it can handle any interrupt from the device after that.
> 
> Greg mentioned that there are reasons that we can not disable all pci
> interrupts. Meanwhile I am going through archives to find more about it.

You recalled the conversation in the next paragraph:

> In previous conversations, Alan Stern had raised the issue of console also
> not working if interrupts are disabled on all the devices. I am not sure
> but this should be working at least for serial consoles and vga text consoles.
> May be sufficient to capture the dump.

That's the main objection a lot of people had to this kind of patch,
last time it was discussed.

thanks,

greg k-h
