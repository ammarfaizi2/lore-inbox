Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751949AbWJXTWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949AbWJXTWN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 15:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751942AbWJXTWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 15:22:13 -0400
Received: from havoc.gtf.org ([69.61.125.42]:7634 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751798AbWJXTWM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 15:22:12 -0400
Date: Tue, 24 Oct 2006 15:22:10 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Roland Dreier <rdreier@cisco.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       John Partridge <johnip@sgi.com>
Subject: Re: Ordering between PCI config space writes and MMIO reads?
Message-ID: <20061024192210.GE2043@havoc.gtf.org>
References: <adafyddcysw.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adafyddcysw.fsf@cisco.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2006 at 12:13:19PM -0700, Roland Dreier wrote:
>  1) Is this something that should be fixed in the driver?  The PCI
>     spec allows MMIO cycles to start before an earlier config cycle
>     completed, but do we want to expose this fact to drivers?  Would
>     it be better for ia64 to use some sort of barrier to make sure
>     pci_write_config_xxx() is strongly ordered with MMIO?

The PCI config APIs have traditionally enforced very strong ordering.
Heck, the PCI config APIs often take a spinlock on each read or write;
so they are definitely not intended to be as fast as MMIO.

	Jeff



