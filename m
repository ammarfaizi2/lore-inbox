Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267399AbTAGO2k>; Tue, 7 Jan 2003 09:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267401AbTAGO2k>; Tue, 7 Jan 2003 09:28:40 -0500
Received: from nimbus19.internetters.co.uk ([209.61.216.65]:1965 "HELO
	nimbus19.internetters.co.uk") by vger.kernel.org with SMTP
	id <S267399AbTAGO2j>; Tue, 7 Jan 2003 09:28:39 -0500
Subject: Re: Why do some net drivers require __OPTIMIZE__?
From: Alex Bennee <alex@braddahead.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1041867367.17472.40.camel@irongate.swansea.linux.org.uk>
References: <1041863609.21044.11.camel@cambridge.braddahead> 
	<1041867367.17472.40.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8-3mdk 
Date: 07 Jan 2003 14:33:07 +0000
Message-Id: <1041949988.21044.37.camel@cambridge.braddahead>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-06 at 15:36, Alan Cox wrote:
> > Does anybody know the history behind those lines? Do they serve any
> > purpose now or in the past? Should I be nervous about compiling the
> > kernel at a *lower* than normal optimization level? After all
> > optimizations are generally processor specific and shouldn't affect the
> > meaning of the C.
> 
> Some of our inline and asm blocks assume things like optimisation. Killing
> that check and adding -finline-functions ought to be enough to get what
> you expect.

It appears to go deeper than a few network drivers. Droping to -O0
breaks a host of other sections (ipc, sockets etc.) for less than
obvious reasons. The only source files that seem to depend on the
__OPTIMIZE__ define are a few of the other drivers and the byteswap
macros.

I'll investigate the gcc pages to see if there is anyway to allow
optimisation without the out-of-order stuff that makes tracing the start
up so hard. *sigh*

I assume I can't drop the -fomit-frame-pointer for the same reason
(inline and asm blocks assuming register assigment?).

On a related note should enabling -g on the kernel CFLAGS be ok? For
some reason vmlinux kernels compiled with -g (even after being stripped)
seem to break the bootmem allocator on my setup. I'm trying to track
down if this is due to some linker weirdness due to the symbol table
being bigger than physical memory even though its not actually being
loaded into the system.

-- 
Alex Bennee
Senior Hacker, Braddahead Ltd
The above is probably my personal opinion and may not be that of my
employer

