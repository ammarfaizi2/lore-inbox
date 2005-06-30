Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262981AbVF3T3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262981AbVF3T3n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 15:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262985AbVF3T3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 15:29:42 -0400
Received: from mail.kroah.org ([69.55.234.183]:63117 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262981AbVF3T3g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 15:29:36 -0400
Date: Thu, 30 Jun 2005 10:10:10 -0700
From: Greg KH <greg@kroah.com>
To: linux-pm <linux-pm@lists.osdl.org>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] firmware leaves device in D3hot at boot
Message-ID: <20050630171010.GD11369@kroah.com>
References: <20050623191451.GA20572@tuxdriver.com> <20050624022807.GF28077@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050624022807.GF28077@tuxdriver.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2005 at 10:28:07PM -0400, John W. Linville wrote:
> On Thu, Jun 23, 2005 at 03:14:52PM -0400, John W. Linville wrote:
> 
> > This issue regarding D3hot->D0 state transitions seems like a piece
> > of minutiae that we should not force individual drivers to address.
> 
> After some thought, I'm inclined to think that the patch below is
> the right one.  It unconditionally saves and restores the PCI config
> registers when pci_enable_device is called.  Although this is often
> (usually?) unnecessary, it seems like a safe thing to do and it should
> not be a performance-sensitive path.  The code to check for whether
> or not this is necessary would be a little harder to read IMHO,
> so I think this is warranted.

But how does this solve your problem with the state change?

> The comment block at the head of pci_enable_device says "Initialize
> device before it's used by a driver" which implies that saving and
> restoring the PCI config should be safe if the function is used
> as intended.

All pci drivers must call pci_enable_device() before they start to use
it.

thanks,

greg k-h
