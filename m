Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030726AbWKOTK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030726AbWKOTK2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 14:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030910AbWKOTK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 14:10:28 -0500
Received: from hera.kernel.org ([140.211.167.34]:46007 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1030726AbWKOTK1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 14:10:27 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
Date: Wed, 15 Nov 2006 11:09:53 -0800
Organization: OSDL
Message-ID: <20061115110953.6cafdef8@freekitty>
References: <20061114.192117.112621278.davem@davemloft.net>
	<Pine.LNX.4.64.0611141935390.3349@woody.osdl.org>
	<455A938A.4060002@garzik.org>
	<20061114.201549.69019823.davem@davemloft.net>
	<455A9664.50404@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1163617793 10909 10.8.0.54 (15 Nov 2006 19:09:53 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Wed, 15 Nov 2006 19:09:53 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2006 23:24:04 -0500
Jeff Garzik <jeff@garzik.org> wrote:

> David Miller wrote:
> > Is this absolutely true?  I've never been sure about this point, and I
> > was rather convinced after reading various documents that once you
> > program up the MSI registers to start generating MSI this implicitly
> > disabled INTX and this was even in the PCI specification.
> > 
> > It would be great to get a definitive answer on this.
> > 
> > If it is mandatory, perhaps the driver shouldn't be doing it and
> > rather the PCI layer MSI enabling should.

pci_enable_msi() calls msi_capability_init() and that disables intx
already.


> 
> I can't answer for the spec, but at least two independent device vendors 
> recommended to write an MSI driver that way (disable intx, enable msi).
> 
> Completely independent of MSI though, a PCI 2.2 compliant driver should 
> be nice and disable intx on exit, just to avoid any potential interrupt 
> hassles after driver unload.  And of course be aware that it might need 
> to enable intx upon entry.
> 
> 	Jeff

The driver shouldn't deal with this, pci_disable_msi() does.

-- 
Stephen Hemminger <shemminger@osdl.org>
