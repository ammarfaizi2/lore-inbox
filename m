Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265148AbUASPJV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 10:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265153AbUASPJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 10:09:20 -0500
Received: from fed1mtao02.cox.net ([68.6.19.243]:37084 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP id S265148AbUASPJS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 10:09:18 -0500
Date: Mon, 19 Jan 2004 08:09:16 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       George Anzinger <george@mvista.com>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>, jim.houston@comcast.net,
       Powerpc Linux <linuxppc-dev@lists.linuxppc.org>
Subject: Re: setjmp/longjmp hooks for kgdb 2.0.2
Message-ID: <20040119150916.GC13454@stop.crashing.org>
References: <20040114165034.GB17509@stop.crashing.org> <200401151052.30740.amitkale@emsyssoft.com> <20040116155742.GK983@stop.crashing.org> <200401171207.54506.amitkale@emsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401171207.54506.amitkale@emsyssoft.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 17, 2004 at 12:07:54PM +0530, Amit S. Kale wrote:

> On Friday 16 Jan 2004 9:27 pm, Tom Rini wrote:
> > On Thu, Jan 15, 2004 at 10:52:30AM +0530, Amit S. Kale wrote:
> > > Hi Tom,
> > >
> > > It's nice to see someone working on integrating powerpc kgdb with
> > > mainline kgdb. There are a lot of features (like thread lists, gdb
> > > deatch-reattach, automodule loading) powerpc kgdb will inherit
> > > automatically from common core.
> > >
> > > setjmp, longjmp isn't required. search_exception_tables take care of
> > > invalid memory accesses by kgdb.
> > >
> > > In arch/ppc/mm/fault.c:do_page_fault, call bad_page_fault if
> > > debugger_memerr_expected is non-zero instead of holding mmap_sem.
> > >
> > > bad_page_fault calls search_exception_tables at the begining. It takes
> > > care of invalid memory addresses by kgdb as kgdb uses get_user, put_user
> > > to access memory when the access can fail.
> >
> > OK, thanks.
> >
> > > For powerpc arch specific code (like entry.S) look at
> > > http://kgdb.sourceforge.net/linux-2.4.23-kgdb-1.9.patch
> > > It contains powerpc arch specific code for kgdb. I was never able to test
> > > this code, so I don't know whether it works.
> >
> > It might work on some subset of machines, but the serial driver is still
> > broken for SERIAL_IO_MEM machines (which there are a lot of) nor is the
> > ppc 8xx (which is what I would assume TimeSys used) serial driver
> > patched up.
> 
> Yes. There is a lot of #ifdef CONFIG_KGDB code in their 
> arch/ppc/8260_io/uart.c If your ppc machine uses the same uart, please let me 
> know and I'll send you this file.

Ah, that explains it.

> Which test machine do you have?

What I've got locally are a Motorola LoPEC and Motorola Sandpoint (both
with ns1655x UARTs) and an Embedded Planet RPXLite (MPC8xx with a
similar UART to the 8260 variant).  But I'm doing this with my
MontaVista hat on, so in the end I'm going to try and test it on
everything that's not a powermac/chrp (more or less).

-- 
Tom Rini
http://gate.crashing.org/~trini/
