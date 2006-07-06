Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWGFTlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWGFTlw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 15:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbWGFTlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 15:41:52 -0400
Received: from cantor.suse.de ([195.135.220.2]:7845 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750756AbWGFTlv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 15:41:51 -0400
Date: Thu, 6 Jul 2006 12:38:04 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: tiwai@suse.de, arjan@infradead.org, kkeil@suse.de, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hisax fix usage of __init*
Message-ID: <20060706193804.GB20621@kroah.com>
References: <20060705112357.GA7003@pingi.kke.suse.de> <1152099459.3201.19.camel@laptopd505.fenrus.org> <s5h8xn8144m.wl%tiwai@suse.de> <20060706191129.GA20255@kroah.com> <20060706122250.34fdeded.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060706122250.34fdeded.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2006 at 12:22:50PM -0700, Andrew Morton wrote:
> On Thu, 6 Jul 2006 12:11:29 -0700
> Greg KH <greg@kroah.com> wrote:
> 
> > > > Tips:
> > > > 	The module_init()/module_exit() functions (and all initialization
> > > >         functions called only from these) should be marked __init/exit.
> > > > 	The struct pci_driver shouldn't be marked with any of these tags.
> > > >	The ID table array should be marked __devinitdata.
> > 
> > Yes, and that is correct.  They should never be marked __initdata, as
> > that is wrong for when CONFIG_HOTPLUG is enabled and the module is built
> > in.
> > 
> > So either use __devinitdata, or nothing (as it's only a memory savings
> > if CONFIG_HOTPLUG is not enabled, which is real tough these days, and
> > the driver is built into the system.)
> 
> I think the problem is that pci_driver has a pointer to the id_table.  So
> we have a ref to __devinitdata from .text.
> 
> That's runtimely-correct, but the new section checker could get offended.

Yes, it probably could get hard to check for it, but the code is correct
:)

thanks,

greg k-h
