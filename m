Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265573AbUAPP61 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 10:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265579AbUAPP61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 10:58:27 -0500
Received: from fed1mtao03.cox.net ([68.6.19.242]:16554 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP id S265573AbUAPP5t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 10:57:49 -0500
Date: Fri, 16 Jan 2004 08:57:42 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       George Anzinger <george@mvista.com>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>, jim.houston@comcast.net,
       Powerpc Linux <linuxppc-dev@lists.linuxppc.org>
Subject: Re: setjmp/longjmp hooks for kgdb 2.0.2
Message-ID: <20040116155742.GK983@stop.crashing.org>
References: <20040114165034.GB17509@stop.crashing.org> <200401151052.30740.amitkale@emsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401151052.30740.amitkale@emsyssoft.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 15, 2004 at 10:52:30AM +0530, Amit S. Kale wrote:

> Hi Tom,
> 
> It's nice to see someone working on integrating powerpc kgdb with mainline 
> kgdb. There are a lot of features (like thread lists, gdb deatch-reattach, 
> automodule loading) powerpc kgdb will inherit automatically from common core.
> 
> setjmp, longjmp isn't required. search_exception_tables take care of invalid 
> memory accesses by kgdb.
> 
> In arch/ppc/mm/fault.c:do_page_fault, call bad_page_fault if 
> debugger_memerr_expected is non-zero instead of holding mmap_sem. 
> 
> bad_page_fault calls search_exception_tables at the begining. It takes care of 
> invalid memory addresses by kgdb as kgdb uses get_user, put_user to access 
> memory when the access can fail.

OK, thanks.

> For powerpc arch specific code (like entry.S) look at 
> http://kgdb.sourceforge.net/linux-2.4.23-kgdb-1.9.patch
> It contains powerpc arch specific code for kgdb. I was never able to test this 
> code, so I don't know whether it works.

It might work on some subset of machines, but the serial driver is still
broken for SERIAL_IO_MEM machines (which there are a lot of) nor is the
ppc 8xx (which is what I would assume TimeSys used) serial driver
patched up.

> If you modify kgdb core as well as arch specific files, please try to send 
> separate patches. Single patch will require me to do more work when I merge 
> it against separate patches.

OK.  I _hope_ to get you a patch for the serial stuff shortly.

-- 
Tom Rini
http://gate.crashing.org/~trini/
