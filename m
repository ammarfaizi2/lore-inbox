Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263776AbTLQIXU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 03:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263832AbTLQIXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 03:23:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46485 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263776AbTLQIXT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 03:23:19 -0500
Date: Wed, 17 Dec 2003 09:22:35 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Vladimir Kondratiev <vladimir.kondratiev@intel.com>, arjanv@redhat.com,
       Gabriel Paubert <paubert@iram.es>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@redhat.com>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Martin Mares <mj@ucw.cz>, zaitcev@redhat.com, hch@infradead.org
Subject: Re: PCI Express support for 2.4 kernel
Message-ID: <20031217082235.GA24027@devserv.devel.redhat.com>
References: <20031215103142.GA8735@iram.es> <3FDDACA9.1050600@intel.com> <1071494155.5223.3.camel@laptop.fenrus.com> <3FDDBDFE.5020707@intel.com> <Pine.LNX.4.58.0312151154480.1631@home.osdl.org> <3FDEDC77.9010203@intel.com> <Pine.LNX.4.58.0312160844110.1599@home.osdl.org> <3FDFF81F.7040309@intel.com> <Pine.LNX.4.58.0312162240040.8541@home.osdl.org> <3FDFFDEC.7090109@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FDFFDEC.7090109@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Dec 17, 2003 at 01:55:40AM -0500, Jeff Garzik wrote:
> Linus Torvalds wrote:
> >So if this will only matter for PCI-X drivers and not for discovery etc, I
> >wonder if it wouldn't make sense to have this as a totally separate
> >function? Instead of trying to make the existing "pci_config_xxxx()" 
> >stuff work with PCI-X, wouldn't it be nicer to have the driver just map 
> >its config space on probe?
> 
> Not a bad idea...  After posting yesterday on this thread, I had the 
> thought:  Just like PCI has readl() and sbus has sbus_readl(), why not 
> pciex_cfg_readl() ?
> 
> Any PCI-Ex drivers would obviously _know_ they are PCI Ex, and they 
> could communicate that by virtue of simply using new functions.  Older 
> drivers for older hardware would use the old API and not care... 
> Further, PCI-Ex operations are already basically readl/writel anyway, so 
> going through the forest of pci_cfg_ops pointers and such would just add 
> needless layering.

BUT powermanagement and co will need to potentially do stuff too with the
config space...
