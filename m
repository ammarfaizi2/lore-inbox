Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269202AbTCBNIO>; Sun, 2 Mar 2003 08:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269204AbTCBNIO>; Sun, 2 Mar 2003 08:08:14 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:48024
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S269202AbTCBNIN>; Sun, 2 Mar 2003 08:08:13 -0500
Subject: Re: 2.5.63: 'Debug: sleeping function called from illegal context
	at mm/slab.c:1617'
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1046607762.2019.107.camel@zion.wanadoo.fr>
References: <20030301210518.GA740@gallifrey>
	 <1046568414.24557.11.camel@irongate.swansea.linux.org.uk>
	 <1046598825.2030.101.camel@zion.wanadoo.fr>
	 <1046607762.2019.107.camel@zion.wanadoo.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046614895.2844.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 02 Mar 2003 14:21:36 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-02 at 12:22, Benjamin Herrenschmidt wrote:
> > Well... it's a bug in _all_ archs. They (almost) all call the proc
> > stuff from request_irq, and worse, on x86, I think, has the
> > kmalloc inside request_irq changed to GFP_ATOMIC.
> 
> I meant "Only" x86 does GFP_ATOMIC

The IDE layer needs to obtain the IRQ with interrupts disabled. It
isnt alone in that either. I can't guarantee to mask the IRQ
because not all supported hardware has working irq masking.
disable/enable_irq on unallocated interrupts is undefined, and
does not work on at least one supported platform at all.

Unfortunately ten years ago someone created 'register_and_activate_irq'
calling it 'register_irq', and it hasn't yet been fixed.

So its up to the arch maintainers to fix it, or they don't
get IDE support 8)

