Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266173AbUAUXG0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 18:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266174AbUAUXG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 18:06:26 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:13299 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S266173AbUAUXGT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 18:06:19 -0500
Message-ID: <400F05D2.4010607@mvista.com>
Date: Wed, 21 Jan 2004 15:05:54 -0800
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
References: <20040120172708.GN13454@stop.crashing.org> <200401211946.17969.amitkale@emsyssoft.com> <20040121153019.GR13454@stop.crashing.org> <200401212223.13347.amitkale@emsyssoft.com> <20040121184217.GU13454@stop.crashing.org>
In-Reply-To: <20040121184217.GU13454@stop.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> On Wed, Jan 21, 2004 at 10:23:12PM +0530, Amit S. Kale wrote:
> 
> 
>>Hi,
>>
>>Here it is: ppc kgdb from timesys kernel is available at
>>http://kgdb.sourceforge.net/kgdb-2/linux-2.6.1-kgdb-2.1.0.tar.bz2
>>
>>This is my attempt at extracting kgdb from TimeSys kernel. It works well in 
>>TimeSys kernel, so blame me if above patch doesn't work.
> 
> 
> Okay, here's my first patch against this.
> ===== kernel/kgdbstub.c 1.1 vs edited =====
> --- 1.1/kernel/kgdbstub.c	Wed Jan 21 10:13:17 2004
> +++ edited/kernel/kgdbstub.c	Wed Jan 21 10:53:38 2004
> @@ -1058,9 +1058,6 @@
>  	kgdb_serial->write_char('+');
>  
>  	linux_debug_hook = kgdb_handle_exception;
> -	
> -	if (kgdb_ops->kgdb_init)
> -		kgdb_ops->kgdb_init();
>  
>  	/* We can't do much if this fails */
>  	register_module_notifier(&kgdb_module_load_nb);
> @@ -1104,6 +1101,11 @@
>  	if (!kgdb_enter) {
>  		return;
>  	}
> +
> +	/* Let the arch do any initalization it needs to */
> +	if (kgdb_ops->kgdb_init)
> +		kgdb_ops->kgdb_init();
> +
>  	if (!kgdb_serial) {
>  		printk("KGDB: no gdb interface available.\n"
>  		       "kgdb can't be enabled\n");
> 
> I'm not sure why you were calling the arch-specific init so late in the
> process, but since it's a nop on both i386 and x86_64 (so perhaps it
> should be removed for both of these?), this change doesn't matter to
> them.  But it does make the PPC code cleaner, IMHO.

I agree.  Lets dump all the init calls/code.  I have not seen anything yet that 
can not be done as a side effect of the first call, or better yet, at compile time.

I am willing to be shown a valid case, however.  Remember, I want to be able to 
do a breakpoint() as the first line of C code in the kernel.  (works with the mm 
kgdb).
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

