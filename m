Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030308AbWJPApO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030308AbWJPApO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 20:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030306AbWJPApN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 20:45:13 -0400
Received: from ozlabs.org ([203.10.76.45]:13187 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1030304AbWJPApM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 20:45:12 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17714.54766.390707.532248@cargo.ozlabs.ibm.com>
Date: Mon, 16 Oct 2006 10:44:30 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Brownell <david-b@pacbell.net>,
       matthew@wil.cx, val_henson@linux.intel.com, netdev@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: [PATCH 1/2] [PCI] Check that MWI bit really did get set
In-Reply-To: <20061015164402.f9b8b4d2.akpm@osdl.org>
References: <1160161519800-git-send-email-matthew@wil.cx>
	<20061015191631.DE49D19FEC8@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<20061015123432.4c6b7f15.akpm@osdl.org>
	<200610151545.59477.david-b@pacbell.net>
	<20061015161834.f96a0761.akpm@osdl.org>
	<1160956960.5732.99.camel@localhost.localdomain>
	<20061015164402.f9b8b4d2.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> Let me restore the words from my earlier email which you removed so that
> you could say that:
> 
>   For you the driver author to make assumptions about what's happening
>   inside pci_set_mwi() is a layering violation.  Maybe the bridge got
>   hot-unplugged.  Maybe the attempt to set MWI caused some synchronous PCI
>   error.  For example, take a look at the various implementations of
>   pci_ops.read() around the place - various of them can fail for various
>   reasons.  

Maybe aliens are firing a ray-gun at the card.  I think it's
fundamentally wrong for the driver to deny service completely because
of a maybe.

Either there was a transient error that only affected the attempt to
set MWI, in which case a printk (inside pci_set_mwi!) is appropriate,
and we carry on.  Or there is a persistent error condition, in which
case the driver will see something else fail soon enough - something
that the driver actually needs to have working in order to operate -
and fail at that point.

For the driver to stop and refuse to go any further because of an
error in pci_set_mwi has far more disadvantages than advantages.

Paul.
