Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136446AbRD3GSU>; Mon, 30 Apr 2001 02:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136452AbRD3GSD>; Mon, 30 Apr 2001 02:18:03 -0400
Received: from shell.aros.net ([207.173.16.19]:4 "EHLO shell.aros.net")
	by vger.kernel.org with ESMTP id <S136451AbRD3GRz>;
	Mon, 30 Apr 2001 02:17:55 -0400
Date: Mon, 30 Apr 2001 00:17:54 -0600
From: Lawrence Gold <gold@shell.aros.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Oopses under 2.4.4pre8 with Tbird 1.2GHz/Epox 8kta3
Message-ID: <20010430001754.A96437@shell.aros.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe I've narrowed down the cause of my oopses/panics:

If I build with CONFIG_MK7 but comment out

	   define_bool CONFIG_X86_USE_3DNOW y

in the MK7 part of arch/i386/config.in, the 2.4.4 kernel appears to run
perfectly.

On a side note, if I leave arch/i386/config.h untouched but force the use
of the generic MMX implementations of fast_clear_page() and
fast_copy_page() in arch/i386/lib/mmx.c, then I get some odd behavior but
nothing as bad as I had been getting before.  (For example, running awk
always produces the message "awk: cmd. line: 1: (FILENAME- FNR=1) fatal:
attempt to access field -2147483648".)

Could this be a sign of a faulty 3DNOW! core in my CPU?  If so, do you
know of any utilities I could run that test these instructions?  (For
Linux or Windows.)

The CPU is a 1.2GHz Athlon Thunderbird with a 266MHz frontside bus.  In
case it's helpful, I've attached the contents of /proc/cpuinfo.

Thanks in advance to anyone who can help!

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1202.774
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2398.61

