Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261466AbVBHFfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbVBHFfV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 00:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbVBHFfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 00:35:21 -0500
Received: from mail.kroah.org ([69.55.234.183]:63433 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261466AbVBHFfO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 00:35:14 -0500
Date: Mon, 7 Feb 2005 21:34:41 -0800
From: Greg KH <greg@kroah.com>
To: "Mark F. Haigh" <Mark.Haigh@spirentcom.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc3-bk4] arch/i386/kernel/pci/irq.c:  Wrong message output
Message-ID: <20050208053441.GA31216@suse.de>
References: <420848CA.2030008@spirentcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <420848CA.2030008@spirentcom.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2005 at 09:06:18PM -0800, Mark F. Haigh wrote:
> 
> (Same basic problem I just reported in a seperate thread against 2.4.29-bk8)
> 
> The following has been reported in the wild for kernel 2.6.8-24:
> 
> PCI: Enabling device 0000:00:05.0 (0000 -> 0002)
> PCI: No IRQ known for interrupt pin @ of device 0000:00:05.0. Probably 
> buggy MP table.
> 
> It should read "No IRQ known for interrupt pin A", but the 'pin' 
> variable has already been decremented (from 1 to 0), so the line:
> 
> printk(KERN_WARNING "PCI: No IRQ known for interrupt pin %c of device 
> %s.%s\n", 'A' + pin - 1, dev->slot_name, msg);
> 
> causes "pin @" to be output, because 'A' + 0 - 1 == '@'.
> 
> The supplied patch should fix it.  It also removes a redundant check for 
> a nonzero pin.
> 
> 
> Mark F. Haigh
> Mark.Haigh@spirentcom.com
> 

> --- arch/i386/pci/irq.c.orig	2005-02-07 20:40:58.140856536 -0800
> +++ arch/i386/pci/irq.c	2005-02-07 20:46:06.713946296 -0800

Can you resend this so it can be applied with -p1 to patch, and a
Signed-off-by: line?

thanks,

greg k-h
