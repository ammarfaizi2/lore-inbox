Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310806AbSCSXjh>; Tue, 19 Mar 2002 18:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310816AbSCSXjQ>; Tue, 19 Mar 2002 18:39:16 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:60081 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S310806AbSCSXjI>; Tue, 19 Mar 2002 18:39:08 -0500
Date: Tue, 19 Mar 2002 23:40:22 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Arjan van de Ven <arjan@fenrus.demon.nl>
cc: Hugh Dickins <hugh@lrel.veritas.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Tigran Aivazian <Tigran.Aivazian@veritas.com>, kraxel@bytesex.org,
        marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [patch] vmalloc_to_page() backport for 2.4
In-Reply-To: <20020319163041.B17735@fenrus.demon.nl>
Message-ID: <Pine.LNX.4.21.0203192257030.1557-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2002, Arjan van de Ven wrote:
> On Thu, Mar 14, 2002 at 02:46:39PM +0000, Hugh Dickins wrote:
> > 
> > Few modules take an interest in ptes, that's as it should be, and so
> > few modules build to different binaries with CONFIG_X86_PAE off or on
> > (modulo module versions).
> 
> Well dma_addr_t and some others also change size..... struct page also
> changes quite a bit

I believe it's CONFIG_HIGHMEM you're thinking of there: dma_addr_t
and struct page do depend on CONFIG_NOHIGHMEM/CONFIG_HIGHMEM in recent
kernels, but not on CONFIG_HIGHMEM4G/CONFIG_HIGHMEM64G(CONFIG_X86_PAE).

I don't know why it's CONFIG_HIGHMEM rather than CONFIG_HIGHMEM64G
that decides the u64-ness dma_addr_t.  There is a dmaaddr_high_t
which behaves more expectedly, but it's not so widely used.

Hugh

