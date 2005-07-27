Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262119AbVG0RdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbVG0RdT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 13:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbVG0RdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 13:33:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9918 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262290AbVG0Rc3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 13:32:29 -0400
Date: Wed, 27 Jul 2005 13:32:22 -0400
From: Dave Jones <davej@redhat.com>
To: Aleksey Gorelov <Aleksey_Gorelov@Phoenix.com>
Cc: Giancarlo Formicuccia <giancarlo.formicuccia@gmail.com>,
       Greg KH <greg@kroah.com>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix incorrect Asus k7m irq router detection
Message-ID: <20050727173222.GD20938@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Aleksey Gorelov <Aleksey_Gorelov@Phoenix.com>,
	Giancarlo Formicuccia <giancarlo.formicuccia@gmail.com>,
	Greg KH <greg@kroah.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <0EF82802ABAA22479BC1CE8E2F60E8C33D2D00@scl-exch2k3.phoenix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0EF82802ABAA22479BC1CE8E2F60E8C33D2D00@scl-exch2k3.phoenix.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2005 at 10:10:35AM -0700, Aleksey Gorelov wrote:
 
 > > >  static __init int via_router_probe(struct irq_router *r, 
 > >struct pci_dev *router, u16 device)
 > > >  {
 > > >  	/* FIXME: We should move some of the quirk fixup stuff here */
 > > > +
 > > > +	if (router->device == PCI_DEVICE_ID_VIA_82C686 &&
 > > > +			device == PCI_DEVICE_ID_VIA_82C586_0) {
 > > > +		/* Asus k7m bios wrongly reports 82C686A as 
 > >586-compatible */
 > > > +		device = PCI_DEVICE_ID_VIA_82C686;
 > > > +	}
 > > > +
 > > >  	switch(device)
 > > >  	{
 > > >  		case PCI_DEVICE_ID_VIA_82C586_0:
 > >
 > >If this really is a problem with that board, it should have a DMI entry
 > >for that board alone, not for every VIA chipset that uses the 
 > >586/686 combo,
 > >as I'm fairly certain there are some that legitimately use 
 > >this combination,
 > >and the patch above will force them all to be reported as 82C686's.
 > 
 >   How can they use it legitimately if 586 & 686 routers are not
 > programming register compatible ? Any board which reports  that 686 is
 > compatible with 586 will have that issue.

Actually now that I've woken up properly, your patch looks ok to me.
For some reason I was thinking we were comparing a north and south
bridge here.

		Dave

