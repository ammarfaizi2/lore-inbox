Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263027AbRFDX3q>; Mon, 4 Jun 2001 19:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263023AbRFDX3g>; Mon, 4 Jun 2001 19:29:36 -0400
Received: from t2.redhat.com ([199.183.24.243]:26607 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S263025AbRFDX30>; Mon, 4 Jun 2001 19:29:26 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3B1C1872.8D8F1529@mandrakesoft.com> 
In-Reply-To: <3B1C1872.8D8F1529@mandrakesoft.com>  <13942.991696607@redhat.com> 
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: bjornw@axis.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: Missing cache flush. 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 05 Jun 2001 00:29:22 +0100
Message-ID: <14147.991697362@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jgarzik@mandrakesoft.com said:
> > I was pointed at Documentation/DMA-mapping.txt but that doesn't seem
> > very helpful - it's very PCI-specific, and a quick perusal of
> > pci_dma_sync() on i386 shows that it doesn't do what's required anyway.

> What should it do on i386?  mb()? 

For it to have any use in the situation I described, it would need to 
writeback and invalidate the dcache for the affected range. It doesn't seem 
to do so, so it seems that it isn't what I require.

The situation is simple - I have a paged RAM setup and I need it cached. 
All I want to do is flush and invalidate the cache when I'm about to waggle 
whatever I/O ports I waggle to change pages. 

There are other situations in which I need the cache flushed, but the above 
is one of the simplest.

Even flush_page_to_ram() doesn't seem to do what its name implies, on most 
architectures.

--
dwmw2


