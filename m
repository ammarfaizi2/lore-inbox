Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262603AbUBZCFp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 21:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262602AbUBZCFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 21:05:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:43141 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262603AbUBZCFk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 21:05:40 -0500
Date: Wed, 25 Feb 2004 18:06:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: torvalds@osdl.org, willy@debian.org, jes@wildopensource.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] move dma_consistent_dma_mask to the generic device
Message-Id: <20040225180600.273bbf55.akpm@osdl.org>
In-Reply-To: <1077759287.14081.24.camel@mulgrave>
References: <1077759287.14081.24.camel@mulgrave>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@SteelEye.com> wrote:
>
> pci_dev.consistent_dma_mask was introduced to get around problems in the
>  IA64 Altix machine. 
> 
>  Now, we have a use for it in x86: the aacraid needs coherent memory in a
>  31 bit address range (2GB).  Unfortunately, x86 is converted to the dma
>  model, so it can't see the pci_dev by the time coherent memory is
>  allocated. 
> 
>  The solution to all of this is to move pci_dev.consistent_dma_mask to
>  dev.coherent_dma_mask and make x86 use it in the dma_alloc_coherent()
>  calls. 

A bit more grepping is needed.

sound/core/memalloc.c: In function `snd_pci_hack_alloc_consistent':
sound/core/memalloc.c:103: structure has no member named `consistent_dma_mask'

