Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265931AbUAQGii (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 01:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265996AbUAQGig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 01:38:36 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:47254 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S265931AbUAQGic
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 01:38:32 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: setjmp/longjmp hooks for kgdb 2.0.2
Date: Sat, 17 Jan 2004 12:07:54 +0530
User-Agent: KMail/1.5
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       George Anzinger <george@mvista.com>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>, jim.houston@comcast.net,
       Powerpc Linux <linuxppc-dev@lists.linuxppc.org>
References: <20040114165034.GB17509@stop.crashing.org> <200401151052.30740.amitkale@emsyssoft.com> <20040116155742.GK983@stop.crashing.org>
In-Reply-To: <20040116155742.GK983@stop.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401171207.54506.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 16 Jan 2004 9:27 pm, Tom Rini wrote:
> On Thu, Jan 15, 2004 at 10:52:30AM +0530, Amit S. Kale wrote:
> > Hi Tom,
> >
> > It's nice to see someone working on integrating powerpc kgdb with
> > mainline kgdb. There are a lot of features (like thread lists, gdb
> > deatch-reattach, automodule loading) powerpc kgdb will inherit
> > automatically from common core.
> >
> > setjmp, longjmp isn't required. search_exception_tables take care of
> > invalid memory accesses by kgdb.
> >
> > In arch/ppc/mm/fault.c:do_page_fault, call bad_page_fault if
> > debugger_memerr_expected is non-zero instead of holding mmap_sem.
> >
> > bad_page_fault calls search_exception_tables at the begining. It takes
> > care of invalid memory addresses by kgdb as kgdb uses get_user, put_user
> > to access memory when the access can fail.
>
> OK, thanks.
>
> > For powerpc arch specific code (like entry.S) look at
> > http://kgdb.sourceforge.net/linux-2.4.23-kgdb-1.9.patch
> > It contains powerpc arch specific code for kgdb. I was never able to test
> > this code, so I don't know whether it works.
>
> It might work on some subset of machines, but the serial driver is still
> broken for SERIAL_IO_MEM machines (which there are a lot of) nor is the
> ppc 8xx (which is what I would assume TimeSys used) serial driver
> patched up.

Yes. There is a lot of #ifdef CONFIG_KGDB code in their 
arch/ppc/8260_io/uart.c If your ppc machine uses the same uart, please let me 
know and I'll send you this file.

Which test machine do you have?

> > If you modify kgdb core as well as arch specific files, please try to
> > send separate patches. Single patch will require me to do more work when
> > I merge it against separate patches.
>
> OK.  I _hope_ to get you a patch for the serial stuff shortly.

-- 
Amit Kale
EmSysSoft (http://www.emsyssoft.com)
KGDB: Linux Kernel Source Level Debugger (http://kgdb.sourceforge.net)

