Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267485AbTAGVuL>; Tue, 7 Jan 2003 16:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267499AbTAGVuL>; Tue, 7 Jan 2003 16:50:11 -0500
Received: from crack.them.org ([65.125.64.184]:27620 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S267485AbTAGVuD>;
	Tue, 7 Jan 2003 16:50:03 -0500
Date: Tue, 7 Jan 2003 16:58:38 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Alex Bennee <alex@braddahead.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why do some net drivers require __OPTIMIZE__?
Message-ID: <20030107215838.GA20046@nevyn.them.org>
Mail-Followup-To: Alex Bennee <alex@braddahead.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1041863609.21044.11.camel@cambridge.braddahead> <1041867367.17472.40.camel@irongate.swansea.linux.org.uk> <1041949988.21044.37.camel@cambridge.braddahead>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1041949988.21044.37.camel@cambridge.braddahead>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2003 at 02:33:07PM +0000, Alex Bennee wrote:
> On Mon, 2003-01-06 at 15:36, Alan Cox wrote:
> > > Does anybody know the history behind those lines? Do they serve any
> > > purpose now or in the past? Should I be nervous about compiling the
> > > kernel at a *lower* than normal optimization level? After all
> > > optimizations are generally processor specific and shouldn't affect the
> > > meaning of the C.
> > 
> > Some of our inline and asm blocks assume things like optimisation. Killing
> > that check and adding -finline-functions ought to be enough to get what
> > you expect.
> 
> It appears to go deeper than a few network drivers. Droping to -O0
> breaks a host of other sections (ipc, sockets etc.) for less than
> obvious reasons. The only source files that seem to depend on the
> __OPTIMIZE__ define are a few of the other drivers and the byteswap
> macros.
> 
> I'll investigate the gcc pages to see if there is anyway to allow
> optimisation without the out-of-order stuff that makes tracing the start
> up so hard. *sigh*

Try -O1; it's much better for debugging in general.

> I assume I can't drop the -fomit-frame-pointer for the same reason
> (inline and asm blocks assuming register assigment?).

Shouldn't matter.

> On a related note should enabling -g on the kernel CFLAGS be ok? For
> some reason vmlinux kernels compiled with -g (even after being stripped)
> seem to break the bootmem allocator on my setup. I'm trying to track
> down if this is due to some linker weirdness due to the symbol table
> being bigger than physical memory even though its not actually being
> loaded into the system.

It should be OK; it sounds like a problem with the loader you're using,
at a guess.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
