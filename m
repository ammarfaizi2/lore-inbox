Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263432AbTDSSxG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 14:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263435AbTDSSxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 14:53:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43685 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263432AbTDSSxF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 14:53:05 -0400
Message-ID: <3EA19DD6.4010106@pobox.com>
Date: Sat, 19 Apr 2003 15:04:54 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: romieu@fr.zoreil.com
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers/net/rcpci45 DMA mapping API conversion
References: <20030105144559.A2835@se1.cogenit.fr>
In-Reply-To: <20030105144559.A2835@se1.cogenit.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adding to my last email, I think the solution is to look at the 
implementation of pci_alloc_consistent and the other functions your 
patch calls.  You may be able to get away with simply changing your 
pci_alloc_consistent call to

dma_alloc_coherent(&hwdev->dev, size, dma_handle, GFP_DMA | GFP_KERNEL);

Take a look at include/asm-generic/pci-dma-compat.h for how 
pci_alloc_consistent is implemented on most platforms.

Thanks!

	Jeff




