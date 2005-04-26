Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbVDZGhB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbVDZGhB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 02:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbVDZGhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 02:37:00 -0400
Received: from mail.kroah.org ([69.55.234.183]:41619 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261347AbVDZGg4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 02:36:56 -0400
Date: Mon, 25 Apr 2005 23:36:34 -0700
From: Greg KH <greg@kroah.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-pci@atrey.karlin.mff.cuni.cz,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: pci-sysfs resource mmap broken
Message-ID: <20050426063634.GB5372@kroah.com>
References: <1114493609.7183.55.camel@gaston> <1114495782.7112.60.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114495782.7112.60.camel@gaston>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2005 at 04:09:41PM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2005-04-26 at 15:33 +1000, Benjamin Herrenschmidt wrote:
> 
> > In a similar vein, the "resource" is exposing directly to userland the
> > content of "struct resource". This doesn't mean anything. The kernel is
> > internally playing all sort of offset tricks on these values, so they
> > can't be used for anything useful, either via /dev/mem, or for io port
> > accesses, or whatever.
> > 
> > Shouldn't we expose the BAR values & size rather here ? That is,
> > reconsitutes non-offset'd resources, possibly with arch help, or just
> > reading BAR to get base, and apply resource size & flags ?
> 
>   .../...
> 
> Ok, after a bit more thinking, I think I'll go that way for now, please
> let me know if you think I'm wrong:
> 
> rename "resource" to "resources" and make it contain a start address
> that matches the BAR value, that is something that has at least some
> sort of meaning in userland and can be passed to pci_mmap_page_range().
> To do that "translation", I'll read the BAR value, and use it as start,
> then use the resource size & flags.

That sounds fine with me.

thanks,

greg k-h
