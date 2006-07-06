Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbWGFUT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWGFUT3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 16:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbWGFUT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 16:19:28 -0400
Received: from xenotime.net ([66.160.160.81]:55710 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750803AbWGFUT2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 16:19:28 -0400
Date: Thu, 6 Jul 2006 13:22:13 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Greg KH <greg@kroah.com>
Cc: akpm@osdl.org, tiwai@suse.de, arjan@infradead.org, kkeil@suse.de,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hisax fix usage of __init*
Message-Id: <20060706132213.6041daa5.rdunlap@xenotime.net>
In-Reply-To: <20060706193804.GB20621@kroah.com>
References: <20060705112357.GA7003@pingi.kke.suse.de>
	<1152099459.3201.19.camel@laptopd505.fenrus.org>
	<s5h8xn8144m.wl%tiwai@suse.de>
	<20060706191129.GA20255@kroah.com>
	<20060706122250.34fdeded.akpm@osdl.org>
	<20060706193804.GB20621@kroah.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jul 2006 12:38:04 -0700 Greg KH wrote:

> On Thu, Jul 06, 2006 at 12:22:50PM -0700, Andrew Morton wrote:
> > On Thu, 6 Jul 2006 12:11:29 -0700
> > Greg KH <greg@kroah.com> wrote:
> > 
> > > > > Tips:
> > > > > 	The module_init()/module_exit() functions (and all initialization
> > > > >         functions called only from these) should be marked __init/exit.
> > > > > 	The struct pci_driver shouldn't be marked with any of these tags.
> > > > >	The ID table array should be marked __devinitdata.
> > > 
> > > Yes, and that is correct.  They should never be marked __initdata, as
> > > that is wrong for when CONFIG_HOTPLUG is enabled and the module is built
> > > in.
> > > 
> > > So either use __devinitdata, or nothing (as it's only a memory savings
> > > if CONFIG_HOTPLUG is not enabled, which is real tough these days, and
> > > the driver is built into the system.)
> > 
> > I think the problem is that pci_driver has a pointer to the id_table.  So
> > we have a ref to __devinitdata from .text.
> > 
> > That's runtimely-correct, but the new section checker could get offended.
> 
> Yes, it probably could get hard to check for it, but the code is correct
> :)

I think that there are already some exceptions in the modpost
checking, so adding another won't be a big deal.

---
~Randy
