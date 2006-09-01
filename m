Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750941AbWIADWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbWIADWy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 23:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWIADWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 23:22:54 -0400
Received: from ns1.suse.de ([195.135.220.2]:53712 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750932AbWIADWx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 23:22:53 -0400
Date: Thu, 31 Aug 2006 20:22:36 -0700
From: Greg KH <greg@kroah.com>
To: Brice Goglin <brice@myri.com>
Cc: Matt Porter <mporter@embeddedalley.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] Simple userspace interface for PCI drivers
Message-ID: <20060901032236.GB336@kroah.com>
References: <20060830062338.GA10285@kroah.com> <20060830143410.GB19477@gate.crashing.org> <20060830175529.GB6258@kroah.com> <44F78E88.8050602@myri.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44F78E88.8050602@myri.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2006 at 09:36:08PM -0400, Brice Goglin wrote:
> I might be nice to have something like a copy-block where the
> application writes/reads data, while the device does DMA only from/to
> there. We would need an easy way to mmap some anonymous DMA-ready memory
> in user-space, and something to give the corresponding DMA addresses to
> the application.

Sure, send a patch :)

> Additionally, the current code might not be flexible enough regarding
> acknowledging of interrupts. It might be good to use the bit that PCI
> 2.2 defines in the config space to mask/unmask interrupt in a generic
> way. Something like : when an interrupt comes, the driver mask the
> interrupts using this bit, and then passes the event to user-space. The
> user-space interrupt handler acknowledges the interrupt with the device
> specific code, and then unmask with the PCI 2.2 bit.

You can do that today with this code.  Remember, you have to have a
tiny kernelspace portion of your driver to handle the interrupt.  You
can do whatever you want in that interrupt handler.

thanks,

greg k-h
