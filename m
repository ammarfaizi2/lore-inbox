Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265593AbSJXS3r>; Thu, 24 Oct 2002 14:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265596AbSJXS3q>; Thu, 24 Oct 2002 14:29:46 -0400
Received: from dc-mx10.cluster1.charter.net ([209.225.8.20]:46264 "EHLO
	dc-mx10.cluster1.charter.net") by vger.kernel.org with ESMTP
	id <S265593AbSJXS3m>; Thu, 24 Oct 2002 14:29:42 -0400
Date: Thu, 24 Oct 2002 14:35:47 -0400
To: linux-kernel@vger.kernel.org
Cc: Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [CFT] faster athlon/duron memory copy implementation
Message-ID: <20021024183547.GA2335@cy599856-a>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Manfred Spraul <manfred@colorfullife.com>
References: <3DB82ABF.8030706@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DB82ABF.8030706@colorfullife.com>
User-Agent: Mutt/1.4i
X-Editor: GNU Emacs 21.1
X-Operating-System: Debian GNU/Linux 2.4.20-pre7-ac3-rmap14b-preempt i686
X-Processor: Athlon XP 2000+
X-Uptime: 14:25:51 up 15 min,  3 users,  load average: 1.09, 1.06, 0.71
From: Josh McKinney <forming@charter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On approximately Thu, Oct 24, 2002 at 07:15:43PM +0200, Manfred Spraul wrote:

> Could you run it and report the results to me, together with cpu, 
> chipset and memory type?
> 

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 6
model name	: AMD Athlon(tm) XP 1800+
stepping	: 2
cpu MHz		: 1529.541
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips	: 3053.97

RAM is PC2100 DDR, Mobo/Chipset Soyo K7V Dragon+ VIA KT266A

$ gcc-3.2 -o athlon-memcpy -O3 -march=athlon-xp athlon.c

$ ./athlon-memcpy 
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 

copy_page() tests 
copy_page function 'warm up run'         took 16159 cycles per page
copy_page function '2.4 non MMX'         took 16867 cycles per page
copy_page function '2.4 MMX fallback'    took 16486 cycles per page
copy_page function '2.4 MMX version'     took 16116 cycles per page
copy_page function 'faster_copy'         took 9679 cycles per page
copy_page function 'even_faster'         took 9708 cycles per page
copy_page function 'no_prefetch'         took 6879 cycles per page

$ ./athlon-memcpy
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 

copy_page() tests 
copy_page function 'warm up run'         took 18627 cycles per page
copy_page function '2.4 non MMX'         took 21079 cycles per page
copy_page function '2.4 MMX fallback'    took 21081 cycles per page
copy_page function '2.4 MMX version'     took 18658 cycles per page
copy_page function 'faster_copy'         took 11334 cycles per page
copy_page function 'even_faster'         took 11606 cycles per page
copy_page function 'no_prefetch'         took 6925 cycles per page

$ ./athlon-memcpy 
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 

copy_page() tests 
copy_page function 'warm up run'         took 18631 cycles per page
copy_page function '2.4 non MMX'         took 21015 cycles per page
copy_page function '2.4 MMX fallback'    took 21085 cycles per page
copy_page function '2.4 MMX version'     took 18619 cycles per page
copy_page function 'faster_copy'         took 11388 cycles per page
copy_page function 'even_faster'         took 11478 cycles per page
copy_page function 'no_prefetch'         took 6961 cycles per page

$ ./athlon-memcpy 
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 

copy_page() tests 
copy_page function 'warm up run'         took 17246 cycles per page
copy_page function '2.4 non MMX'         took 18617 cycles per page
copy_page function '2.4 MMX fallback'    took 18319 cycles per page
copy_page function '2.4 MMX version'     took 17235 cycles per page
copy_page function 'faster_copy'         took 10356 cycles per page
copy_page function 'even_faster'         took 10462 cycles per page
copy_page function 'no_prefetch'         took 6889 cycles per page


