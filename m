Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264546AbUAVPH2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 10:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264568AbUAVPH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 10:07:28 -0500
Received: from fed1mtao07.cox.net ([68.6.19.124]:2725 "EHLO fed1mtao07.cox.net")
	by vger.kernel.org with ESMTP id S264546AbUAVPHY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 10:07:24 -0500
Date: Thu, 22 Jan 2004 08:07:13 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: George Anzinger <george@mvista.com>
Cc: "Amit S. Kale" <amitkale@emsyssoft.com>,
       Powerpc Linux <linuxppc-dev@lists.linuxppc.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>
Subject: Re: PPC KGDB changes and some help?
Message-ID: <20040122150713.GC15271@stop.crashing.org>
References: <20040120172708.GN13454@stop.crashing.org> <200401211946.17969.amitkale@emsyssoft.com> <20040121153019.GR13454@stop.crashing.org> <200401212223.13347.amitkale@emsyssoft.com> <20040121184217.GU13454@stop.crashing.org> <20040121192128.GV13454@stop.crashing.org> <400F0759.5070309@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <400F0759.5070309@mvista.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 21, 2004 at 03:12:25PM -0800, George Anzinger wrote:
> Tom Rini wrote:
> >On Wed, Jan 21, 2004 at 11:42:17AM -0700, Tom Rini wrote:
> >
> >>On Wed, Jan 21, 2004 at 10:23:12PM +0530, Amit S. Kale wrote:
> >>
> >>
> >>>Hi,
> >>>
> >>>Here it is: ppc kgdb from timesys kernel is available at
> >>>http://kgdb.sourceforge.net/kgdb-2/linux-2.6.1-kgdb-2.1.0.tar.bz2
> >>>
> >>>This is my attempt at extracting kgdb from TimeSys kernel. It works well 
> >>>in TimeSys kernel, so blame me if above patch doesn't work.
> >>
> >>Okay, here's my first patch against this.
> >
> >
> >And dependant upon this is a patch to fixup the rest of the common PPC
> >code, as follows:
> >- Add FRAME_POINTER
> >- Put the bits of kgdbppc_init into ppc_kgdb_init.
> >- None of the gen550 stuffs depend on CONFIG_8250_SERIAL directly,
> >  remove that constraint.
> >- Add missing bits like debuggerinfo, BREAKPOINT, etc.
> >- Add a kgdb_map_scc machdep pointer.
> >
> >--- 1.48/arch/ppc/Kconfig	Wed Jan 21 10:13:13 2004
> >+++ edited/arch/ppc/Kconfig	Wed Jan 21 12:18:32 2004
> >@@ -1405,6 +1405,14 @@
> > 	  Say Y here only if you plan to use some sort of debugger to
> > 	  debug the kernel.
> > 	  If you don't debug the kernel, you can say N.
> >+
> >+config FRAME_POINTER
> >+	bool "Compile the kernel with frame pointers"
> >+	help
> >+	  If you say Y here the resulting kernel image will be slightly 
> >larger
> >+	  and slower, but it will give very useful debugging information.
> >+	  If you don't debug the kernel, you can say N, but we may not be 
> >able
> >+	  to solve problems without frame pointers.
> 
> This is fast becoming old hat.  If you compile with dwarf debug info, you 
> not only get more reliable frame info, but you do not need frame pointers.  
> Gdb is almost there.  The languages have already arrived.

My guess would be the miniumum toolchain requirements for i386/ppc (I
don't know x86_64) aren't all that new, so while gcc-3.3 probably gives
everything you describe, gcc-3.0 (which is valid for PPC, iirc) probably
doesn't.

> A question I have been meaning to ask:  Why is the arch/common connection 
> via a structure of addresses instead of just calls?  I seems to me that 
> just calling is a far cleaner way to do things here.  All the struct seems 
> to offer is a way to change the backend on the fly.  I don't thing we ever 
> want to do that.  Am I missing something?

I imagine it's a style thing.  I don't have a preference either way.

-- 
Tom Rini
http://gate.crashing.org/~trini/
