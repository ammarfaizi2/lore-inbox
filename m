Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316766AbSFKEjb>; Tue, 11 Jun 2002 00:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316768AbSFKEja>; Tue, 11 Jun 2002 00:39:30 -0400
Received: from [209.237.59.50] ([209.237.59.50]:41579 "EHLO
	zinfandel.topspincom.com") by vger.kernel.org with ESMTP
	id <S316766AbSFKEja>; Tue, 11 Jun 2002 00:39:30 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: wjhun@ayrnetworks.com, paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
In-Reply-To: <20020610110740.B30336@ayrnetworks.com>
	<20020610.201033.66168406.davem@redhat.com>
	<52lm9m7969.fsf@topspin.com>
	<20020610.212135.129520403.davem@redhat.com>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 10 Jun 2002 21:39:27 -0700
Message-ID: <52d6uy77k0.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   	struct something {
   	        int field1;
   	        char dma_buffer[SMALLER_THAN_CACHE_LINE];
   	        int field2;
   	};
   
   	struct something *dev = kmalloc(sizeof *dev, GFP_KERNEL);
   
    David> How about allocating struct something using pci_pool?

The problem is the driver can't safely touch field1 or field2 near the
DMA (it might pull the cache line back in too soon, or dirty the cache
line and have it written back on top of DMA'ed data)

Best,
  Roland

