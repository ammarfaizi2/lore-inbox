Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbWIAE2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWIAE2I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 00:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbWIAE2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 00:28:08 -0400
Received: from mail.suse.de ([195.135.220.2]:35032 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932088AbWIAE2F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 00:28:05 -0400
Date: Thu, 31 Aug 2006 21:27:50 -0700
From: Greg KH <greg@kroah.com>
To: Brice Goglin <brice@myri.com>
Cc: Matt Porter <mporter@embeddedalley.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] Simple userspace interface for PCI drivers
Message-ID: <20060901042750.GA2230@kroah.com>
References: <20060830062338.GA10285@kroah.com> <20060830143410.GB19477@gate.crashing.org> <20060830175529.GB6258@kroah.com> <44F78E88.8050602@myri.com> <20060901032236.GB336@kroah.com> <44F7AB16.30405@myri.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44F7AB16.30405@myri.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2006 at 11:37:58PM -0400, Brice Goglin wrote:
> Greg KH wrote:
> >> Additionally, the current code might not be flexible enough regarding
> >> acknowledging of interrupts. It might be good to use the bit that PCI
> >> 2.2 defines in the config space to mask/unmask interrupt in a generic
> >> way. Something like : when an interrupt comes, the driver mask the
> >> interrupts using this bit, and then passes the event to user-space. The
> >> user-space interrupt handler acknowledges the interrupt with the device
> >> specific code, and then unmask with the PCI 2.2 bit.
> >>     
> >
> > You can do that today with this code.  Remember, you have to have a
> > tiny kernelspace portion of your driver to handle the interrupt.  You
> > can do whatever you want in that interrupt handler.
> >   
> 
> The whole point of masking interrupt with this config-space bit is that
> we might not need any tiny kernelspace portion for our driver anymore.
> It won't work for devices that are not PCI 2.2 compliant. But, it might
> be good for the ones that are?

I don't really know.  I think 2.2 PCI devices might still be a bit rare,
but do not know for sure.

thanks,

greg k-h
