Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264874AbTIDJXA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 05:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264881AbTIDJXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 05:23:00 -0400
Received: from ozlabs.org ([203.10.76.45]:50067 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264874AbTIDJVu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 05:21:50 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16215.1054.262782.866063@nanango.paulus.ozlabs.org>
Date: Thu, 4 Sep 2003 19:21:34 +1000 (EST)
From: Paul Mackerras <paulus@samba.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix ppc ioremap prototype
In-Reply-To: <20030904083007.B2473@flint.arm.linux.org.uk>
References: <20030903203231.GA8772@lst.de>
	<16214.34933.827653.37614@nanango.paulus.ozlabs.org>
	<20030904071334.GA14426@lst.de>
	<20030904083007.B2473@flint.arm.linux.org.uk>
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King writes:

> But phys_addr_t in struct resource and being passed into ioremap is
> confusing.  Apparantly, it isn't a physical address, but a platform
> defined cookie which just happens to look like a physical address.

It happens to be a physical address on PPC.  So I don't see why so
much fuss is being made over the PPC declaration of ioremap using
phys_addr_t for it.  Other architectures might well do something
different.

> (or are we finally going to admit that it is a physical address?)

Well, it has to be globally unique across all resources of all devices
in the system.  If you can have multiple PCI domains, that means you
can't just use the PCI bus address, for instance.  And it is
preferably something that you can easily translate into a physical
address.

What I would prefer is if we passed a struct device pointer, a
resource pointer and an offset to ioremap.  Then we could just have
bus addresses in PCI device resources instead of having to translate
them into physical addresses.

Paul.

