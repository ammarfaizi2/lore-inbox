Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbUCVE5L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 23:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbUCVE5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 23:57:11 -0500
Received: from gate.crashing.org ([63.228.1.57]:34793 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261711AbUCVE5K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 23:57:10 -0500
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0403202038530.1816@pnote.perex-int.cz>
References: <20040320133025.GH9009@dualathlon.random>
	 <20040320144022.GC2045@holomorphy.com>
	 <20040320150621.GO9009@dualathlon.random>
	 <20040320154419.A6726@flint.arm.linux.org.uk>
	 <Pine.LNX.4.58.0403201651520.1816@pnote.perex-int.cz>
	 <20040320160911.B6726@flint.arm.linux.org.uk>
	 <Pine.LNX.4.58.0403202038530.1816@pnote.perex-int.cz>
Content-Type: text/plain
Message-Id: <1079930580.911.176.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 22 Mar 2004 15:43:00 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-03-21 at 06:44, Jaroslav Kysela wrote:
> On Sat, 20 Mar 2004, Russell King wrote:
> 
> > It is well known that virt_to_page() is only valid on virtual addresses
> > which correspond to kernel direct mapped RAM pages, and undefined on
> > everything else.  Unfortunately, ALSA has been using it with
> > pci_alloc_consistent() for a long time, and this behaviour is what
> > makes ALSA broken.  The fact it works on x86 is merely incidental.
> 
> It works on PPC as well (at least we have no error reports).

It works only on PPCs that have consistent IOs, not embedded ones which
will use special mappings for getting non-cacheable pages.

> Yes, I'm sorry about that, but the ->nopage usage was requested by Jeff
> Garzik and we're not gurus for the VM stuff. Because we're probably first
> starting using of this mapping scheme, it resulted to problems.


