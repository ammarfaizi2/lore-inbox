Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263444AbTDST5O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 15:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263447AbTDST5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 15:57:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:440 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263444AbTDST5N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 15:57:13 -0400
Message-ID: <3EA1ACDD.4090306@pobox.com>
Date: Sat, 19 Apr 2003 16:09:01 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Francois Romieu <romieu@fr.zoreil.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/net/rcpci45 DMA mapping API conversion
References: <20030105144559.A2835@se1.cogenit.fr> <3EA19CF8.8030109@pobox.com> <20030419215526.A3020@electric-eye.fr.zoreil.com>
In-Reply-To: <20030419215526.A3020@electric-eye.fr.zoreil.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu wrote:
> Re,
> 
> Jeff Garzik <jgarzik@pobox.com> :
> [...]
> 
>>Ok, I finally got around to attacking this one.  Your patch looked ok to 
>>me until I noticed one detail:
>>
>>         pDpa->msgbuf = kmalloc (MSG_BUF_SIZE, GFP_DMA | GFP_KERNEL);
>>
>>The GFP_DMA tag indicates that we can't just use pci_alloc_consistent in 
>>the normal way, as we lose the GFP_DMA designator.
> 
> 
> Does it mean the usual pci_set_dma_mask() cooking or something more elaborate ?


Reading dma_alloc_coherent() in arch/i386/kernel/pci-dma.c, it does 
appear that would be sufficient...

	Jeff



