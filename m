Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbUJ3QSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbUJ3QSe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 12:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbUJ3QRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 12:17:15 -0400
Received: from mail.kroah.org ([69.55.234.183]:48024 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261238AbUJ3P3Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 11:29:24 -0400
Date: Fri, 29 Oct 2004 20:23:57 -0700
From: Greg KH <greg@kroah.com>
To: David Vrabel <dvrabel@arcom.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] PCI: Add is_bridge to pci_dev to allow fixups to disable bridge functionality.
Message-ID: <20041030032357.GA1441@kroah.com>
References: <4174F909.1040804@arcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4174F909.1040804@arcom.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2004 at 12:22:49PM +0100, David Vrabel wrote:
> Hi,
> 
> This patch allows device fixups to force the PCI subsystem to ignore 
> bridges and hence not allocate resources to them.
> 
> I have an IXP425 (ARM) board with a CardBus controller on it (of which 
> only the PC card interfaces are used).  The problem is that the PCI 
> memory window is too small to fit in all the bridge resources and the 
> rest of the PCI devices and up being unconfigured.  With this patch, and 
> a fixup to clear is_bridge, this doesn't happen.
> 
> The plan was to make the CardBus driver (drivers/pcmcia/yenta_socket.c) 
> honour the is_bridge flag and not bother with CardBus stuff if it's cleared.

But why can't any code that wants to check this, just look at the
dev->hdr_type instead?  I don't think we need to add a new bit for this
because of that, right?

> Index: linux-2.6-armbe/drivers/pci/probe.c
> ===================================================================
> --- linux-2.6-armbe.orig/drivers/pci/probe.c	2004-10-14 
> 11:26:38.000000000 +0100
> +++ linux-2.6-armbe/drivers/pci/probe.c	2004-10-19 
> 12:00:00.000000000 +0100

Also, your patch was linewrapped :(

thanks,

greg k-h
