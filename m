Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbTKCIKw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 03:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbTKCIKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 03:10:52 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:30947 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S261939AbTKCIKu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 03:10:50 -0500
To: Jamie Wellnitz <Jamie.Wellnitz@emulex.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: virt_to_page/pci_map_page vs. pci_map_single
References: <20031102181224.GD2149@ma.emulex.com>
From: Jes Sorensen <jes@trained-monkey.org>
Date: 03 Nov 2003 03:10:46 -0500
In-Reply-To: <20031102181224.GD2149@ma.emulex.com>
Message-ID: <yq0wuahan3t.fsf@trained-monkey.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jamie" == Jamie Wellnitz <Jamie.Wellnitz@emulex.com> writes:

Jamie> page = virt_to_page(buffer); offset = ((unsigned long)buffer &
Jamie> ~PAGE_MASK); busaddr = pci_map_page(pci_dev, page, offset, len,
Jamie> direction);

Jamie> How is this preferable to:

Jamie> pci_map_single( pci_dev, buffer, len, direction);

Jamie> pci_map_single can't handle highmem pages (because they don't
Jamie> have a kernel virtual address) but doesn't virt_to_page suffer
Jamie> from the same limitation?  Is there some benefit on
Jamie> architectures that don't have highmem?

virt_to_page() can handle any page in the standard kernel region
including pages that are physically in 64-bit space if the
architecture requires it. It doesn't handle vmalloc pages etc. but
one shouldn't try and dynamically map vmalloc pages at
random. pci_map_page() can handle all memory in the system though as
every page that can be mapped has a struct page * entry.

pci_map_page() is the correct API to use, pci_map_single() is
deprecated.

Cheers,
Jes
