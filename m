Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315616AbSFJR6w>; Mon, 10 Jun 2002 13:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315611AbSFJR6u>; Mon, 10 Jun 2002 13:58:50 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:51723 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315619AbSFJR6F>; Mon, 10 Jun 2002 13:58:05 -0400
Date: Mon, 10 Jun 2002 18:57:55 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Oliver Neukum <oliver@neukum.name>
Cc: Tom Rini <trini@kernel.crashing.org>, Roland Dreier <roland@topspin.com>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
Message-ID: <20020610185755.A20585@flint.arm.linux.org.uk>
In-Reply-To: <52d6v19r9n.fsf@topspin.com> <523cvv9laj.fsf@topspin.com> <20020610170309.GC14252@opus.bloom.county> <200206101922.26985.oliver@neukum.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2002 at 07:22:26PM +0200, Oliver Neukum wrote:
> Definitely we should call it something different so we can limit it to 
> architectures that need it.

DMA_ALIGN, DMA_ALIGN_BYTES or DMA_CACHE_BYTES.

Hmm, thinking about this some more (and just rambling).  On some ARMs
(maybe other CPUs as well) each cache line has two dirty bits - one
for each half.  If only half the cache line is dirty, it will only
write out the dirty half when evicting it.  In this case, we'd want:

#define L1_CACHE_BYTES	32
#define DMA_CACHE_BYTES	16

which will probably work as long as we handle stuff carefully in the
architecture specific layer.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

