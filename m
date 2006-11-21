Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030742AbWKULZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030742AbWKULZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 06:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966961AbWKULZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 06:25:26 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38096 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S966964AbWKULZZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 06:25:25 -0500
Date: Tue, 21 Nov 2006 11:28:29 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Ray Lee <ray-lk@madrabbit.org>
Cc: Larry Finger <Larry.Finger@lwfinger.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Problem with DMA on x86_64 with 3 GB RAM
Message-ID: <20061121112829.19a9c043@localhost.localdomain>
In-Reply-To: <456282DE.1000407@madrabbit.org>
References: <455B63EC.8070704@madrabbit.org>
	<20061118112438.GB15349@nineveh.rivenstone.net>
	<1163868955.27188.2.camel@johannes.berg>
	<455F3D44.4010502@lwfinger.net>
	<455F4271.1060405@madrabbit.org>
	<455FF672.4070502@lwfinger.net>
	<456282DE.1000407@madrabbit.org>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Confused. As in, once the bcm43xx module initcall happens? Or without bcm43xx
> at all? If the former, is the behavior different when built as a module versus
> built-in? (ie, are there ordering problems.)

The pci_dma code on the x86_64 platform is broken for the case of PCI
devices with < 32bit DMA. Has been forever, this is a problem with
various devices, although most of the others are obsolete except for the
bcm43xx and b44 (the latter has hacks to work around the x86-64
brokenness).

At the very least the pci_set_dma_mask should error in this situation or
switch to using GFP_DMA (24bit) memory spaces. Having it error isn't the
whole solution as you still need some way to handle the "what do I do
next". 

Alan
