Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbWFGOVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWFGOVM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 10:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWFGOVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 10:21:12 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:938 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S932088AbWFGOVM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 10:21:12 -0400
Subject: Re: pci_map_single() on IA64
From: Alex Williamson <alex.williamson@hp.com>
To: Adhiraj <adhiraj@linsyssoft.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1149671049.3499.27.camel@triumph>
References: <1149671049.3499.27.camel@triumph>
Content-Type: text/plain
Organization: OSLO R&D
Date: Wed, 07 Jun 2006 08:21:08 -0600
Message-Id: <1149690068.5528.15.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-07 at 14:34 +0530, Adhiraj wrote:
> Hi all,
> 
> How is it possible that on an IA64 machine, the address returned by
> pci_map_single() is above 4G (32 bits) when I have only 2G of physical
> memory?
> 
> The DMA mask is set to 64 bits (using pci_set_dma_mask()). When I change
> it to 32 bit DMA mask, the problem goes away.
> 
> This problem does not appear on i388/x86_64 machines.

   What is the physical layout of that 2GB of memory?  You can't count
on memory being contiguous, especially on IA64 systems.  If the address
you get back is within the DMA mask of the device, then the DMA mapping
is valid.  You can run 'grep "System RAM" /proc/iomem' to get some idea
of the physical memory address map.  Thanks,

	Alex

-- 
Alex Williamson                             HP Open Source & Linux Org.

