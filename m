Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbTD3Uve (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 16:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262416AbTD3Uvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 16:51:33 -0400
Received: from sccimhc02.insightbb.com ([63.240.76.164]:28616 "EHLO
	sccimhc02.insightbb.com") by vger.kernel.org with ESMTP
	id S262410AbTD3Uvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 16:51:32 -0400
Date: Wed, 30 Apr 2003 16:03:45 -0500 (EST)
From: Leif Delgass <ldelgass@retinalburn.net>
X-X-Sender: ldelgass@istanbul.retinalburn.dnsalias.net
To: linux-kernel@vger.kernel.org
Subject: mmap() and pci_alloc_consistent()
Message-ID: <Pine.LNX.4.44.0304301148090.3282-100000@istanbul.retinalburn.dnsalias.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a correct and portable way to implement mmap() for memory
allocated with pci_alloc_consistent()?  In the DRM drivers, PCI DMA memory
(for graphics chips that don't support a pcigart scatter-gather table) is
currently allocated with __get_free_pages(), so virt_to_bus() is used to
get the bus address to pass to the card for DMA.  I would like to convert
the drivers to use pci_alloc_consistent() instead.  These DMA buffers
(usually about 1-2MB worth) are allocated and held for the life of the X
server.

The current mmap() implementation for these buffers uses virt_to_page() on
the address from __get_free_pages() to reserve the pages and to find pages
in nopage().  However, I have seen references indicating that
virt_to_page() is not a valid operation on the cpu address returned from
pci_alloc_consistent().  Is this the case, and if so, is there a 
workaround or alternative?

Please CC: me on any replies since I'm not subscribed.

Thanks.

-- 
Leif Delgass 
http://www.retinalburn.net






