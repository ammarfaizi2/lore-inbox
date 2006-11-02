Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWKBW3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWKBW3K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 17:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752705AbWKBW3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 17:29:09 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:44814 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S1750733AbWKBW3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 17:29:08 -0500
Date: Fri, 3 Nov 2006 01:28:38 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Steve Langasek <vorlon@debian.org>, Eki <eki@sci.fi>,
       Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org,
       thias.lelourd@gmail.com, jharrison@linuxbs.org
Subject: Re: [patch] video: support for VGA hoses on alpha TITAN, TSUNAMI systems (ES45, DS25)
Message-ID: <20061103012838.A15986@jurassic.park.msu.ru>
References: <20061102083718.GC12267@mauritius.dodds.net> <20061102131443.918d6c2e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20061102131443.918d6c2e.akpm@osdl.org>; from akpm@osdl.org on Thu, Nov 02, 2006 at 01:14:43PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2006 at 01:14:43PM -0800, Andrew Morton wrote:
> What is a "hose"?

A real name of "pci domain". ;-)

> > +	/* First, fixup the VGA resource bounds WRT the hose it is on. */
> > +	if (pci_vga_hose) {
> > +		new->start += pci_vga_hose->io_space->start;
> > +		new->end += pci_vga_hose->io_space->start;
> > +	}
> > +
> > +	/* Finally, do a normal request_resource(). */
> > +	return request_resource(root, new);

This will always fail. Should be

	return request_resource(pci_vga_hose->io_space, new);

> > +}
> > 
> 
> So if the resource is being requested by vga we adjust the caller's
> resource before actually requesting it.
> 
> Isn't this a bit hacky?  How come vgacon ended up requesting the wrong
> addresses in the first place?

vgacon requests the correct _bus_ address, but it doesn't work with
multiple buses. So a fixup similar to pcibios_fixup_resource() or
pcibios_bus_to_resource() is needed.

Ivan.
