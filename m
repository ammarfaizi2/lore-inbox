Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbVFDBxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbVFDBxw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 21:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVFDBxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 21:53:52 -0400
Received: from fire.osdl.org ([65.172.181.4]:62095 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261220AbVFDBxu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 21:53:50 -0400
Date: Fri, 3 Jun 2005 18:55:40 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>
cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: PROBLEM: Devices behind PCI Express-to-PCI bridge not mapped
In-Reply-To: <20050604013311.GA30151@erebor.esa.informatik.tu-darmstadt.de>
Message-ID: <Pine.LNX.4.58.0506031851220.1876@ppc970.osdl.org>
References: <20050603232828.GA29860@erebor.esa.informatik.tu-darmstadt.de>
 <Pine.LNX.4.58.0506031706450.1876@ppc970.osdl.org>
 <20050604013311.GA30151@erebor.esa.informatik.tu-darmstadt.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 4 Jun 2005, Andreas Koch wrote:
> 
> As you suspected, it wasn't a panacea: The kernel now panics, with a
> call chain of
> 
> 	...
> 	pcibios_init()
> 	pci_assign_unassigned_resources()
> 	pci_bus_assign_resources()
> 	pci_setup_bridge()
> 
> I can collect more specific info if necessary.

It would be nice to know exactly what it is that panics, I could well
imagine that it's something like the "bus->self" that ends up being NULL
for the root bus or something silly like that, simply because x86 has 
never needed to use these functions.

If so, it migth be as easy as just skipping buses that don't have bridge 
device associated with them, but this would require that you try to debug 
the oops a bit to figure out where it is..

Greg, do you have any PCI Express hw? Although I suspect that the 
pci_assign_unassigned_resources() problem probably happens on any PC, I 
could try it on my laptop.

		Linus
