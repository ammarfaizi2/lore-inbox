Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161274AbWJPKgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161274AbWJPKgS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 06:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbWJPKgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 06:36:18 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51075 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751092AbWJPKgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 06:36:17 -0400
Subject: Re: [PATCH 1/2] [PCI] Check that MWI bit really did get set
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: David Brownell <david-b@pacbell.net>, matthew@wil.cx,
       val_henson@linux.intel.com, netdev@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       gregkh@suse.de
In-Reply-To: <20061015164402.f9b8b4d2.akpm@osdl.org>
References: <1160161519800-git-send-email-matthew@wil.cx>
	 <20061015191631.DE49D19FEC8@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	 <20061015123432.4c6b7f15.akpm@osdl.org>
	 <200610151545.59477.david-b@pacbell.net>
	 <20061015161834.f96a0761.akpm@osdl.org>
	 <1160956960.5732.99.camel@localhost.localdomain>
	 <20061015164402.f9b8b4d2.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Oct 2006 12:02:56 +0100
Message-Id: <1160996576.24237.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-10-15 am 16:44 -0700, ysgrifennodd Andrew Morton:
> Let me restore the words from my earlier email which you removed so that
> you could say that:
> 
>   For you the driver author to make assumptions about what's happening
>   inside pci_set_mwi() is a layering violation.  Maybe the bridge got
>   hot-unplugged.  Maybe the attempt to set MWI caused some synchronous PCI
>   error.  For example, take a look at the various implementations of
>   pci_ops.read() around the place - various of them can fail for various
>   reasons.  

Let me repeat what I said before. As a driver author I do not care. It
doesn't matter if it failed because it is not supported or because a
pink elephant went for a dance on the PCI bus.

>   Now it could be that an appropriate solution is to make pci_set_mwi()
>   return only 0 or 1, and to generate a warning from within pci_set_mwi()
>   if some unexpected error happens.  In which case it is legitimate for
>   callers to not check for errors.

That would be my belief, and ditto for a lot of these other functions -
even the correctly __must_check ones like pci_set_master should do the
error reporting in the set_master() function etc not in every driver.
That gives us a single consistent printk and avoids missing them out or
bloat.

Alan

