Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264039AbTGAXmm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 19:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264052AbTGAXml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 19:42:41 -0400
Received: from ns.suse.de ([213.95.15.193]:8709 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264039AbTGAXmk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 19:42:40 -0400
Date: Wed, 2 Jul 2003 01:57:01 +0200
From: Andi Kleen <ak@suse.de>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: axboe@suse.de, grundler@parisc-linux.org, davem@redhat.com,
       suparna@in.ibm.com, linux-kernel@vger.kernel.org,
       alex_williamson@hp.com, bjorn_helgaas@hp.com
Subject: Re: [RFC] block layer support for DMA IOMMU bypass mode II
Message-Id: <20030702015701.6007ac26.ak@suse.de>
In-Reply-To: <1057077975.2135.54.camel@mulgrave>
References: <1057077975.2135.54.camel@mulgrave>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01 Jul 2003 11:46:12 -0500
James Bottomley <James.Bottomley@steeleye.com> wrote:

On further thought about the issue:

The K8 IOMMU cannot support this virtually contiguous thing. The reason
is that there is no guarantee that an entry in a sglist is a multiple
of page size. And the aperture can only map 4K sized chunks, like 
a CPU MMU. So e.g. when you have an sglist with multiple 1K entries there is 
no way to get them continuous in IOMMU space (short of copying)

This means I just need a flag to turn this assumption off in the block layer.

Currently it doesn't even guarantee that pci_map_sg is continuous for page sized chunks - pci_map_sg is essentially just a loop that calls pci_map_single 
and is quite possible that all the entries are spread over the IOMMU hole.

Also James do you remember when these changes were added to the block layer?
We have a weird IDE corruption here and I'm wondering if it is related
to this.

-Andi


