Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbWBXIus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbWBXIus (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 03:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWBXIur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 03:50:47 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:6588 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932111AbWBXIuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 03:50:46 -0500
Subject: Re: Areca RAID driver remaining items?
From: Arjan van de Ven <arjan@infradead.org>
To: erich <erich@areca.com.tw>
Cc: "\"\"\"Christoph Hellwig\"\"\"" <hch@infradead.org>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       billion.wu@areca.com.tw, alan@lxorguk.ukuu.org.uk, akpm@osdl.org,
       oliver@neukum.org
In-Reply-To: <004701c638e7$31d9dc80$b100a8c0@erich2003>
References: <1140458552.3495.26.camel@mentorng.gurulabs.com>
	 <20060220182045.GA1634@infradead.org>
	 <001401c63779$12e49aa0$b100a8c0@erich2003>
	 <20060222145733.GC16269@infradead.org>
	 <00dc01c63842$381f9a30$b100a8c0@erich2003>
	 <1140683157.2972.6.camel@laptopd505.fenrus.org>
	 <001901c6385e$9aee7d40$b100a8c0@erich2003>
	 <1140688569.4672.24.camel@laptopd505.fenrus.org>
	 <005a01c6386f$84b30d50$b100a8c0@erich2003>
	 <1140696452.4672.43.camel@laptopd505.fenrus.org>
	 <004701c638e7$31d9dc80$b100a8c0@erich2003>
Content-Type: text/plain
Date: Fri, 24 Feb 2006 09:50:41 +0100
Message-Id: <1140771042.2874.10.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-24 at 10:08 +0800, erich wrote:
> Dear Arjan van de Ven,
> 
> I would keep dma_alloc_coherent usage.
> 
> > [Exception is that you can say that you are ok with a bigger mask for
> > this type of memory, but just don't do that if you're not]
> 
> Should I remove "pci_set_dma_mask(pci_device, DMA_64BIT_MASK)" for this 
> case?

no what you have is correct; the function to change this behavior is
called 
pci_set_consistent_dma_mask()

pci_set_dma_mask() sets the mask for the "data" (eg dynamic mappings via
pci_map_single and pci_map_page and such). pci_set_consistent_dma_mask()
sets the mask for all the "consistent" allocators.

so again your code is fine as is. If you want to explicitly set that
mask to DMA_32BIT_MASK as documentation that you REALLY want it to be 32
bit, that is probably fine too, but not really needed.

Greetings,
   Arjan van de Ven

