Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbUCUX7F (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 18:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbUCUX7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 18:59:05 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:39954 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261516AbUCUX7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 18:59:02 -0500
Date: Sun, 21 Mar 2004 23:58:54 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, David Woodhouse <dwmw2@infradead.org>,
       Christoph Hellwig <hch@infradead.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040321235854.H26708@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
	linux-kernel@vger.kernel.org
References: <1079901914.17681.317.camel@imladris.demon.co.uk> <20040321204931.A11519@infradead.org> <1079902670.17681.324.camel@imladris.demon.co.uk> <Pine.LNX.4.58.0403211349340.1106@ppc970.osdl.org> <20040321222327.D26708@flint.arm.linux.org.uk> <405E1859.5030906@pobox.com> <20040321225117.F26708@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403211504550.1106@ppc970.osdl.org> <405E23A5.7080903@pobox.com> <Pine.LNX.4.58.0403211542051.1106@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0403211542051.1106@ppc970.osdl.org>; from torvalds@osdl.org on Sun, Mar 21, 2004 at 03:51:31PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2004 at 03:51:31PM -0800, Linus Torvalds wrote:
> That might be the minimal fix, since it would basically involve:
>  - change whatever offensive "virt_to_page()" calls into 
>    "dma_map_to_page()".
>  - implement "dma_map_to_page()" for all architectures.
> 
> Would that make people happy?

Unfortunately this doesn't make dwmw2 happy - he claims to have machines
which implement dma_alloc_coherent using RAM which doesn't have any
struct page associated with it.

I've already got the interface you suggest above for ARM, and I'd have
taken this further had dwmw2 not chimed in.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
