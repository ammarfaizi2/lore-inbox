Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbTEROFS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 10:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbTEROFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 10:05:18 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:62724 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262072AbTEROFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 10:05:17 -0400
Subject: Re: [patch] support 64 bit pci_alloc_consistent
From: James Bottomley <James.Bottomley@steeleye.com>
To: arjanv@redhat.com
Cc: Jes Sorensen <jes@wildopensource.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       "David S. Miller" <davem@redhat.com>,
       Grant Grundler <grundler@dsl2.external.hp.com>,
       Colin Ngam <cngam@sgi.com>, Jeremy Higdon <jeremy@sgi.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-ia64@linuxia64.org,
       wildos@sgi.com
In-Reply-To: <1053250142.1300.8.camel@laptop.fenrus.com>
References: <16071.1892.811622.257847@trained-monkey.org> 
	<1053250142.1300.8.camel@laptop.fenrus.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 18 May 2003 09:17:48 -0500
Message-Id: <1053267471.10811.28.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-05-18 at 04:29, Arjan van de Ven wrote:
> An interface like
> 
> #define PCI_DMA_64BIT 0xffffffffffffffffULL
> #define PCI_DMA_32BIT 0xffffffffULL

This we can add now.

> void pci_set_dma_capabilities(device, 
>                u64 streaming_mask, u64 persistent_mask);
> u64 pci_get_effective_streaming_mask(device);
> u64 pci_get_effective_persistent_mask(device);
> 

I see the value in this for weird mask devices, but I don't think it's a
"must fix" for 2.6 since the weird mask devices can advertise a lower
standard supported mask.

The aic driver, for instance, seems to have a 39 bit addressing range
(it uses 32 bit addr and 32 bit len descriptors, but reduces len to 24
bits to steal the extra byte for 7 bits extra addressing).  However, it
is forced to request the full 64 bit address mask---I've never worked
out what will happen to it on a machine with more than 512GB memory.

The lack of a coherent_mask is causing breakage on some platforms, so
putting it in is a 2.6 must fix thing.

James

