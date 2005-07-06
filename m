Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262463AbVGFXQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262463AbVGFXQM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 19:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262556AbVGFXOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 19:14:09 -0400
Received: from mail.kroah.org ([69.55.234.183]:2741 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262563AbVGFXNR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 19:13:17 -0400
Date: Wed, 6 Jul 2005 16:13:10 -0700
From: Greg KH <greg@kroah.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Linus Torvalds <torvalds@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.13-rc2] yet another fix for setup-bus.c/x86 merge
Message-ID: <20050706231310.GA4505@kroah.com>
References: <20050707030756.B6806@den.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050707030756.B6806@den.park.msu.ru>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2005 at 03:07:56AM +0400, Ivan Kokshaysky wrote:
> There is a slight disagreement between setup-bus.c code and traditional
> x86 PCI setup wrt which recourses are invalid vs resources that are
> free for further allocations.
> Precisely, in the setup-bus.c, if we failed to allocate some resource,
> we nullify "start" and "flags" fields, but *not* the "end" one.
> But x86 pcibios_enable_resources() does the following check:
> if (!r->start && r->end) {
> 	printk(KERN_ERR "PCI: Device %s not available because of resource collisions\n", pci_name(dev));
> 	return -EINVAL;
> which means that the device owning the offending resource cannot be
> enabled.
> In particular, this breaks cardbus behind the normal decode p2p bridge -
> the cardbus code from setup-bus.c requests rather large IO and MEM windows,
> and if it fails, the socket is completely unavailable. Which is wrong, as
> the yenta code is capable to allocate smaller windows.
> 
> Signed-off-by: Ivan Kokshaysky <ink@jurassic.park.msu.ru>

Acked-by: Greg Kroah-Hartman <gregkh@suse.de>

Thanks Ivan for finding this so quickly.

greg k-h
