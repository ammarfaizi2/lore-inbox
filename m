Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265598AbSJXTFd>; Thu, 24 Oct 2002 15:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265601AbSJXTFd>; Thu, 24 Oct 2002 15:05:33 -0400
Received: from h88n2fls33o1108.telia.com ([217.211.126.88]:62921 "EHLO
	fofso.net") by vger.kernel.org with ESMTP id <S265598AbSJXTFc> convert rfc822-to-8bit;
	Thu, 24 Oct 2002 15:05:32 -0400
Subject: Re: [CFT] faster athlon/duron memory copy implementation
From: Marcus =?ISO-8859-1?Q?Lib=E4ck?= <marcus@fofso.net>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, arjanv@redhat.com
In-Reply-To: <3DB82ABF.8030706@colorfullife.com>
References: <3DB82ABF.8030706@colorfullife.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.7 
Date: 24 Oct 2002 21:11:05 +0200
Message-Id: <1035486665.292.2.camel@buffy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-24 at 19:15, Manfred Spraul wrote:
> AMD recommends to perform memory copies with backward read operations 
> instead of prefetch.
> 
> http://208.15.46.63/events/gdc2002.htm
> 
> Attached is a test app that compares several memory copy implementations.
> Could you run it and report the results to me, together with cpu, 
> chipset and memory type?
> 
> Please run 2 or 3 times.
> 
> --
>     Manfred
> ----
> 

[phuse@buffy:~/files]$ cat /proc/cpuinfo 
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) XP 1900+
stepping        : 2
cpu MHz         : 1601.986
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de tsc msr pae mce cx8 sep mtrr pge mca cmov
pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3198.15

[phuse@buffy:~/files]$ gcc athlon.c -o athlon-mem ; ./athlon-mem ;
../athlon-mem ; ./athlon-mem                                          
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 

copy_page() tests 
copy_page function 'warm up run'         took 21174 cycles per page
copy_page function '2.4 non MMX'         took 23369 cycles per page
copy_page function '2.4 MMX fallback'    took 23134 cycles per page
copy_page function '2.4 MMX version'     took 20586 cycles per page
copy_page function 'faster_copy'         took 12297 cycles per page
copy_page function 'even_faster'         took 11697 cycles per page
copy_page function 'no_prefetch'         took 8664 cycles per page
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 

copy_page() tests 
copy_page function 'warm up run'         took 20611 cycles per page
copy_page function '2.4 non MMX'         took 23508 cycles per page
copy_page function '2.4 MMX fallback'    took 23396 cycles per page
copy_page function '2.4 MMX version'     took 20350 cycles per page
copy_page function 'faster_copy'         took 12199 cycles per page
copy_page function 'even_faster'         took 11443 cycles per page
copy_page function 'no_prefetch'         took 8739 cycles per page
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 

copy_page() tests 
copy_page function 'warm up run'         took 20362 cycles per page
copy_page function '2.4 non MMX'         took 24304 cycles per page
copy_page function '2.4 MMX fallback'    took 23258 cycles per page
copy_page function '2.4 MMX version'     took 20307 cycles per page
copy_page function 'faster_copy'         took 11379 cycles per page
copy_page function 'even_faster'         took 11388 cycles per page
copy_page function 'no_prefetch'         took 8800 cycles per page


-- 
Regards / Med vänlig hälsning:
  Marcus Libäck <marcus@fofso.net>
