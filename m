Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277601AbRJHXLr>; Mon, 8 Oct 2001 19:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277600AbRJHXLh>; Mon, 8 Oct 2001 19:11:37 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:33555 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277598AbRJHXLX>; Mon, 8 Oct 2001 19:11:23 -0400
Subject: Re: [PATCH] change name of rep_nop
To: davem@redhat.com (David S. Miller)
Date: Tue, 9 Oct 2001 00:16:27 +0100 (BST)
Cc: dwmw2@infradead.org, frival@zk3.dec.com, paulus@samba.org,
        Martin.Bligh@us.ibm.com, alan@lxorguk.ukuu.org.uk,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        jay.estabrook@compaq.com, rth@twiddle.net
In-Reply-To: <20011008.154650.48796051.davem@redhat.com> from "David S. Miller" at Oct 08, 2001 03:46:50 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15qjdL-0002FT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The mtrr stuff, if it really does need the flush, should probably
> make it's own macro/inline with a huge comment about it explaining
> why the flush is actually needed.

The wbinvd in the mtrr handling is basically cpu specific deep magic from
the chip documentation.

> with all sorts of other cache details, for those we have the PCI DMA
> interfaces, flush_dcache_page etc.

We need to work out how to fix the pci dma interfaces on the PC. The PPro
has an interesting errata where writes to combining memory can pass writes
to uncached memory. That means to fix it I have to lob in a locked store
or other workaround. That costs clocks - and isnt needed on pre ppro boxes,
ditto the spin_unlock using xchg fix isnt needed except on ppro.

That raises the question of whether x86 should seperate the "386" "486" ..
kernels by adding "Generic" for building a kernel that has all the work
arounds for everyones randomly buggy processors
