Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261539AbVBNTep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbVBNTep (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 14:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbVBNTep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 14:34:45 -0500
Received: from mail.kroah.org ([69.55.234.183]:55171 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261539AbVBNTej (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 14:34:39 -0500
Date: Mon, 14 Feb 2005 11:34:13 -0800
From: Greg KH <greg@kroah.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: avoiding pci_disable_device()...
Message-ID: <20050214193413.GA10231@kroah.com>
References: <4210021F.7060401@pobox.com> <20050214190619.GA9241@kroah.com> <s5h7jlbc5ci.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h7jlbc5ci.wl@alsa2.suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2005 at 08:24:29PM +0100, Takashi Iwai wrote:
> At Mon, 14 Feb 2005 11:06:19 -0800,
> Greg KH wrote:
> > 
> > > As a result, I have committed the attached patch to libata-2.6.  In many 
> > > cases, it is a "semantic fix", addressing the case
> > > 
> > > 	* pci_request_regions() indicates hardware is in use
> > > 	* we rudely disable the in-use hardware
> > > 
> > > that would not occur in practice.
> > > 
> > > But better safe than sorry.  Code cuts cut-n-pasted all over the place.
> > > 
> > > I'm hoping one or two things will happen now:
> > > * janitors fix up the other PCI drivers along these lines
> > > * improve the PCI API so that pci_request_regions() is axiomatic
> > 
> > Do you have any suggestions for how to do this?
> 
> How about to add an exclusiveness check in pci_enable_device()?
> Most drivers suppose that the given pci resources are exclusively
> available.

You mean only allow pci_enable_device() to work for the first caller of
it?  I don't see how that would help this issue out.

thanks,

greg k-h
