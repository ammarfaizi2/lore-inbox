Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266595AbUIVSTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266595AbUIVSTu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 14:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266582AbUIVSTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 14:19:50 -0400
Received: from [213.146.154.40] ([213.146.154.40]:62858 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266595AbUIVSTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 14:19:42 -0400
Subject: Re: The new PCI fixup code ate my IDE controller
From: David Woodhouse <dwmw2@infradead.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040922174929.GP16153@parcelfarce.linux.theplanet.co.uk>
References: <20040922174929.GP16153@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Message-Id: <1095877177.17821.1535.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Wed, 22 Sep 2004 19:19:37 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-22 at 18:49 +0100, Matthew Wilcox wrote:
> The new DECLARE_PCI_FIXUP_HEADER() now makes the order of fixups depend
> on link order.  This is a bad thing because it's now one more thing that
> link order is used to determine.  Eventually, we're going to have a knot
> where you can't move link order to make everything work.
> 
> The specific problem here is that quirk_ide_bases() is called before
> superio_fixup_pci().  This is only a problem on PA-RISC.  I can see
> a few solutions to this.  First, we can move the whole suckyio driver
> to arch/parisc, ensuring it gets linked before drivers/pci.  Second,
> just move the DECLARE_PCI_FIXUP_HEADER to arch/parisc.  Third, link
> drivers/parisc ahead of drivers/pci (what other fun ordering problems
> might we have?)  Fourth, move the IDE quirk from drivers/pci/quirks.c
> to drivers/ide somewhere (which is linked after drivers/parisc so would
> happen to fix our problem).  Fifth, back out the quirk changes.  Sixth,
> change the pci fixup stuff to sort the quirks by vendor ID (PCI_ANY_ID
> sorts after any other ID).
> 
> Suggestions?

Hmm. We already have two passes through the fixup stuff. Add a third?

But sorting PCI_ANY_ID to go last seems like a reasonable first stab at
an answer, if that's sufficient for your purposes.

-- 
dwmw2

