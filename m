Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267055AbUBTHEV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 02:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267410AbUBTHEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 02:04:21 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58543 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267055AbUBTHEU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 02:04:20 -0500
Date: Thu, 19 Feb 2004 23:04:07 -0800
From: "David S. Miller" <davem@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: benh@kernel.crashing.org, greg@kroah.com, akpm@osdl.org,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] USB update for 2.6.3
Message-Id: <20040219230407.063ef209.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0402192257190.1107@ppc970.osdl.org>
References: <20040220012802.GA16523@kroah.com>
	<Pine.LNX.4.58.0402192156240.2244@ppc970.osdl.org>
	<1077256996.20789.1091.camel@gaston>
	<Pine.LNX.4.58.0402192221560.2244@ppc970.osdl.org>
	<1077258504.20781.1121.camel@gaston>
	<Pine.LNX.4.58.0402192243170.14296@ppc970.osdl.org>
	<1077259375.20787.1141.camel@gaston>
	<Pine.LNX.4.58.0402192257190.1107@ppc970.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Feb 2004 23:03:31 -0800 (PST)
Linus Torvalds <torvalds@osdl.org> wrote:

> 
> 
> On Fri, 20 Feb 2004, Benjamin Herrenschmidt wrote:
> > 
> > > Well, we do. The pcibios_xxx routines get called for all PCI devices 
> > > during discovery, and that's when you'd fill them in.
> > 
> > But what about USB or FireWire devices ? In theory, I'd like to see
> > the driver for those not have to bother about beeing hosted by a PCI
> > device or whatever else (there are typically non-PCI OHCI USBs on
> > embedded platform, faking a pci_dev is becoming painful).
> 
> Well, a USB device can't actually do DMA, so .. (it's only the USB _host_ 
> that does DMA, and while those aren't always PCI, they normally are).

You miss how all of this stuff is being used :-)

USB drivers do things like map DMA memory, and the generic DMA layer vectors it
so that if the USB device is attached to a PCI host the PCI DMA mapping routines
get used.
