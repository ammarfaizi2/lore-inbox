Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262776AbTKCStX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 13:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262796AbTKCStX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 13:49:23 -0500
Received: from nat9.steeleye.com ([65.114.3.137]:38406 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262776AbTKCStO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 13:49:14 -0500
Subject: Re: virt_to_page/pci_map_page vs. pci_map_single
From: James Bottomley <James.Bottomley@steeleye.com>
To: Jes Sorensen <jes@wildopensource.com>
Cc: Jamie Wellnitz <Jamie.Wellnitz@emulex.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 03 Nov 2003 12:48:42 -0600
Message-Id: <1067885332.2076.13.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



    Jamie> The Document/DMA-mapping.txt in 2.6.0-test9 says "To map a
    Jamie> single region, you do:" and then shows pci_map_single.  Is
    Jamie> DMA-mapping.txt in need of patching?
    
    Sounds like it needs an update.
    
Erm, I don't think so.  pci_map_single() covers a different use case
from pci_map_page().

The thing pci_map_single() can do that pci_map_page() can't is cope with
contiguous regions greater than PAGE_SIZE in length (which you get
either from kmalloc() or __get_free_pages()).  This feature is used in
the SCSI layer for instance.

There has been talk of deprecating dma_map_single() in favour of
dma_map_sg() (i.e. make all transfers use scatter/gather and eliminate
dma_map_single() in favour of a single sg entry table) but nothing has
been done about it (at least as far as I know).

James


