Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264947AbTIDMjA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 08:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264951AbTIDMjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 08:39:00 -0400
Received: from ozlabs.org ([203.10.76.45]:56979 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264947AbTIDMi7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 08:38:59 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16215.12889.496875.461596@nanango.paulus.ozlabs.org>
Date: Thu, 4 Sep 2003 22:38:49 +1000 (EST)
From: Paul Mackerras <paulus@samba.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "David S. Miller" <davem@redhat.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix ppc ioremap prototype
In-Reply-To: <20030904095128.GA16696@lst.de>
References: <20030903203231.GA8772@lst.de>
	<16214.34933.827653.37614@nanango.paulus.ozlabs.org>
	<20030904071334.GA14426@lst.de>
	<20030904083007.B2473@flint.arm.linux.org.uk>
	<16215.1054.262782.866063@nanango.paulus.ozlabs.org>
	<20030904023624.592f1601.davem@redhat.com>
	<20030904104801.A7387@flint.arm.linux.org.uk>
	<20030904095128.GA16696@lst.de>
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig writes:

> Yupp.  This makes me question again how the phys_addr_t thing is
> supposed to work at all given struct resource uses unsigned long
> for start and len, so the whole generic resource infrastructure
> doesn't know about the higher bits...

That's what fixup_bigphys_addr is for.  Basically, on the 440 the
first 4GB of physical address space is all RAM.  PCI memory space
occupies 2GB from 380000000 - 3ffffffff.  So if ioremap is given an
address between 2GB and 4GB, it is assumed to be from a PCI driver,
and fixup_bigphys_addr adds on the 0x300000000.

> Could someone point me a to a driver actually making use of the
> extented ioremap address on ppc 44x?

drivers/net/ibm_emac/ibm_ocp_enet.c in 2.4 does - it's an ocp driver,
not a pci driver.  Yes, we owe Jeff Garzik a 2.5 version of that
driver.

Paul.
