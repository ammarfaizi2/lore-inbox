Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbTKDQgA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 11:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbTKDQgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 11:36:00 -0500
Received: from fed1mtao08.cox.net ([68.6.19.123]:61649 "EHLO
	fed1mtao08.cox.net") by vger.kernel.org with ESMTP id S262353AbTKDQf6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 11:35:58 -0500
Date: Tue, 4 Nov 2003 09:35:56 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Jes Sorensen <jes@trained-monkey.org>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       Jamie Wellnitz <Jamie.Wellnitz@emulex.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: virt_to_page/pci_map_page vs. pci_map_single
Message-ID: <20031104093556.A24704@home.com>
References: <1067885332.2076.13.camel@mulgrave> <yq0znfcjwh1.fsf@trained-monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <yq0znfcjwh1.fsf@trained-monkey.org>; from jes@trained-monkey.org on Tue, Nov 04, 2003 at 04:48:10AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 04, 2003 at 04:48:10AM -0500, Jes Sorensen wrote:
> >>>>> "James" == James Bottomley <James.Bottomley@steeleye.com> writes:
> 
> James> Erm, I don't think so.  pci_map_single() covers a different use
> James> case from pci_map_page().
> 
> James> The thing pci_map_single() can do that pci_map_page() can't is
> James> cope with contiguous regions greater than PAGE_SIZE in length
> James> (which you get either from kmalloc() or __get_free_pages()).
> James> This feature is used in the SCSI layer for instance.
> 
> The question is whether that should be allowed in the first place. Some
> IOMMU's will have to map it page-by-page anyway. However if it is to
> remain a valid use then I don't see why pci_map_page() shouldn't be
> able to handle it under the same conditions by passing it a
> size > PAGE_SIZE.

This raises a question for me regarding these rules in 2.4 versus
2.6.  While fixing a bug in PPC's 2.4 pci_map_page/pci_map_sg
implementations I noticed that a scatterlist created by the IDE
subsystem will pass nents by page struct reference with a
size > PAGE_SIZE.  Is this a 2.4ism resulting from allowing both
address and page reference scatterlist entries?  This isn't
explicitly mentioned in the DMA docs AFAICT.  I'm wondering
if this is the same expected behavior in 2.6 as well.  If
pci_map_page() is limited to size <= PAGE_SIZE then I would
expect pci_map_sg() to be limited as well (and vice versa).

-Matt
