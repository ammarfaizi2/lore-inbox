Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315720AbSFJSbq>; Mon, 10 Jun 2002 14:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315721AbSFJSbp>; Mon, 10 Jun 2002 14:31:45 -0400
Received: from 64-166-72-142.ayrnetworks.com ([64.166.72.142]:33676 "EHLO 
	ayrnetworks.com") by vger.kernel.org with ESMTP id <S315720AbSFJSbo>;
	Mon, 10 Jun 2002 14:31:44 -0400
Date: Mon, 10 Jun 2002 11:29:01 -0700
From: William Jhun <wjhun@ayrnetworks.com>
To: "David S. Miller" <davem@redhat.com>
Cc: paulus@samba.org, roland@topspin.com, linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
Message-ID: <20020610112901.C30336@ayrnetworks.com>
In-Reply-To: <52d6v19r9n.fsf@topspin.com> <20020608.222903.122223122.davem@redhat.com> <15619.9534.521209.93822@nanango.paulus.ozlabs.org> <20020609.212705.00004924.davem@redhat.com> <20020610110740.B30336@ayrnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2002 at 11:07:40AM -0700, William Jhun wrote:
> Perhaps provide macros in asm/pci.h that will:
> 
> - Take a buffer size and add an appropriate amount (one cache line for
>   alignment and the remainder to fill out the last cache line) to be
>   used for kmalloc(), etc, eg:

Err, I should say any case where the buffer may not be cache-aligned
(this would enable the use of DMA to stack...). For allocation routines
that give a cache-aligned buffer, this is obviously not needed (but
would just add one cacheline to the size).

> 
> #define DMA_SIZE_ROUNDUP(size) \
>    ((size + 2*SMP_CACHE_BYTES - 1) & ~(SMP_CACHE_BYTES - 1))
>
