Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbVDZGKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbVDZGKH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 02:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbVDZGKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 02:10:07 -0400
Received: from gate.crashing.org ([63.228.1.57]:44743 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261290AbVDZGKB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 02:10:01 -0400
Subject: Re: pci-sysfs resource mmap broken
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linux-pci@atrey.karlin.mff.cuni.cz
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
In-Reply-To: <1114493609.7183.55.camel@gaston>
References: <1114493609.7183.55.camel@gaston>
Content-Type: text/plain
Date: Tue, 26 Apr 2005 16:09:41 +1000
Message-Id: <1114495782.7112.60.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-26 at 15:33 +1000, Benjamin Herrenschmidt wrote:

> In a similar vein, the "resource" is exposing directly to userland the
> content of "struct resource". This doesn't mean anything. The kernel is
> internally playing all sort of offset tricks on these values, so they
> can't be used for anything useful, either via /dev/mem, or for io port
> accesses, or whatever.
> 
> Shouldn't we expose the BAR values & size rather here ? That is,
> reconsitutes non-offset'd resources, possibly with arch help, or just
> reading BAR to get base, and apply resource size & flags ?

  .../...

Ok, after a bit more thinking, I think I'll go that way for now, please
let me know if you think I'm wrong:

rename "resource" to "resources" and make it contain a start address
that matches the BAR value, that is something that has at least some
sort of meaning in userland and can be passed to pci_mmap_page_range().
To do that "translation", I'll read the BAR value, and use it as start,
then use the resource size & flags.

The name change will also allow userland to "detect" the fixed
implementation.

Ben.


