Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261852AbULaLR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbULaLR7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 06:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261853AbULaLR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 06:17:59 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38809 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261852AbULaLRz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 06:17:55 -0500
Date: Fri, 31 Dec 2004 06:28:26 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrew Morton <akpm@osdl.org>
Cc: William Park <opengeometry@yahoo.ca>, juhl-lkml@dif.dk,
       linux-kernel@vger.kernel.org
Subject: Re: waiting 10s before mounting root filesystem?
Message-ID: <20041231082826.GE7081@logos.cnet>
References: <20041227195645.GA2282@node1.opengeometry.net> <20041227201015.GB18911@sweep.bur.st> <41D07D56.7020702@netshadow.at> <20041229005922.GA2520@node1.opengeometry.net> <20041230152531.GB5058@logos.cnet> <Pine.LNX.4.61.0412310011400.3494@dragon.hygekrogen.localhost> <Pine.LNX.4.61.0412310234040.4725@dragon.hygekrogen.localhost> <20041231035834.GA2421@node1.opengeometry.net> <20041231014905.30b05a11.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041231014905.30b05a11.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 31, 2004 at 01:49:05AM -0800, Andrew Morton wrote:
> William Park <opengeometry@yahoo.ca> wrote:
> >
> > -		printk("VFS: Cannot open root device \"%s\" or %s\n",
> >  -				root_device_name, b);
> >  -		printk("Please append a correct \"root=\" boot option\n");
> >  +		if (--tryagain) {
> >  +		    printk (KERN_WARNING "VFS: Waiting %dsec for root device...\n", tryagain);
> >  +		    ssleep (1);
> >  +		    goto retry;
> >  +		}
> >  +		printk (KERN_CRIT "VFS: Cannot open root device \"%s\" or %s\n", root_device_name, b);
> >  +		printk (KERN_CRIT "Please append a correct \"root=\" boot option\n");
> 
> Why is this patch needed?  If it is to offer the user a chance to insert
> the correct medium or to connect the correct device, 

The media may take a while to become readable (think of CDROM).

> why not rely upon the user doing that thing and then hitting reset? 

I think this is not the case (only) case the patch covers up.

Yes its ugly.

