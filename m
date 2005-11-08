Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030336AbVKHWxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030336AbVKHWxx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 17:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965305AbVKHWxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 17:53:53 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:6160 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S965285AbVKHWxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 17:53:52 -0500
Date: Tue, 8 Nov 2005 22:53:46 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Anil kumar <anils_r@yahoo.com>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: bus_to_virt equivalent
Message-ID: <20051108225346.GF13357@flint.arm.linux.org.uk>
Mail-Followup-To: Anil kumar <anils_r@yahoo.com>,
	Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
References: <20051108013722.GK23749@parisc-linux.org> <20051108224700.68513.qmail@web32406.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051108224700.68513.qmail@web32406.mail.mud.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2005 at 02:47:00PM -0800, Anil kumar wrote:
> Hi Matthew,
> 
> Thanks for the reply.
> I can store the returned dma_addr from
> pci_map_sg/single or pci_map_page in a driver
> structure.
> 
> struct page *page =
> virt_to_page(Cmnd->request_buffer);
>                 unsigned long offset = ((unsigned
> long)Cmnd->request_buffer &
>                                         ~PAGE_MASK);
>                 dma_addr_t busaddr =
> pci_map_page(hostdata->pci_dev,
>                                                  
> page, offset,
>                                                  
> Cmnd->request_bufflen,
>                                                  
> scsi_to_pci_dma_dir(Cmnd->sc_data_direction));
> 
> But how do I convert this returned "busaddr" into a
> virtual addr?

You don't - that's architecture implementation detail which drivers
have _zero_ business knowing about.

As far as you're concerned, the virtual address is Cmnd->request_buffer.

Anyway, you're using the wrong interface - pci_map_single() takes
a virtual address.  No need to play around getting the offset and
struct page for pci_map_page() when pci_map_single() implements
what you require.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
