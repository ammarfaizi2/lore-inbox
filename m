Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266192AbUAUXNY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 18:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266195AbUAUXNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 18:13:24 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:28405 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S266192AbUAUXMu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 18:12:50 -0500
Message-ID: <400F0759.5070309@mvista.com>
Date: Wed, 21 Jan 2004 15:12:25 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: "Amit S. Kale" <amitkale@emsyssoft.com>,
       Powerpc Linux <linuxppc-dev@lists.linuxppc.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>
Subject: Re: PPC KGDB changes and some help?
References: <20040120172708.GN13454@stop.crashing.org> <200401211946.17969.amitkale@emsyssoft.com> <20040121153019.GR13454@stop.crashing.org> <200401212223.13347.amitkale@emsyssoft.com> <20040121184217.GU13454@stop.crashing.org> <20040121192128.GV13454@stop.crashing.org>
In-Reply-To: <20040121192128.GV13454@stop.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> On Wed, Jan 21, 2004 at 11:42:17AM -0700, Tom Rini wrote:
> 
>>On Wed, Jan 21, 2004 at 10:23:12PM +0530, Amit S. Kale wrote:
>>
>>
>>>Hi,
>>>
>>>Here it is: ppc kgdb from timesys kernel is available at
>>>http://kgdb.sourceforge.net/kgdb-2/linux-2.6.1-kgdb-2.1.0.tar.bz2
>>>
>>>This is my attempt at extracting kgdb from TimeSys kernel. It works well in 
>>>TimeSys kernel, so blame me if above patch doesn't work.
>>
>>Okay, here's my first patch against this.
> 
> 
> And dependant upon this is a patch to fixup the rest of the common PPC
> code, as follows:
> - Add FRAME_POINTER
> - Put the bits of kgdbppc_init into ppc_kgdb_init.
> - None of the gen550 stuffs depend on CONFIG_8250_SERIAL directly,
>   remove that constraint.
> - Add missing bits like debuggerinfo, BREAKPOINT, etc.
> - Add a kgdb_map_scc machdep pointer.
> 
> --- 1.48/arch/ppc/Kconfig	Wed Jan 21 10:13:13 2004
> +++ edited/arch/ppc/Kconfig	Wed Jan 21 12:18:32 2004
> @@ -1405,6 +1405,14 @@
>  	  Say Y here only if you plan to use some sort of debugger to
>  	  debug the kernel.
>  	  If you don't debug the kernel, you can say N.
> +
> +config FRAME_POINTER
> +	bool "Compile the kernel with frame pointers"
> +	help
> +	  If you say Y here the resulting kernel image will be slightly larger
> +	  and slower, but it will give very useful debugging information.
> +	  If you don't debug the kernel, you can say N, but we may not be able
> +	  to solve problems without frame pointers.

This is fast becoming old hat.  If you compile with dwarf debug info, you not 
only get more reliable frame info, but you do not need frame pointers.  Gdb is 
almost there.  The languages have already arrived.

A question I have been meaning to ask:  Why is the arch/common connection via a 
structure of addresses instead of just calls?  I seems to me that just calling 
is a far cleaner way to do things here.  All the struct seems to offer is a way 
to change the backend on the fly.  I don't thing we ever want to do that.  Am I 
missing something?

-g

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

