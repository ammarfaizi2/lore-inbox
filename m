Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315198AbSFYLky>; Tue, 25 Jun 2002 07:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315213AbSFYLkx>; Tue, 25 Jun 2002 07:40:53 -0400
Received: from chaos.analogic.com ([204.178.40.224]:13959 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S315198AbSFYLkw>; Tue, 25 Jun 2002 07:40:52 -0400
Date: Tue, 25 Jun 2002 07:42:16 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Frank van de Pol <fvdpol@home.nl>
cc: "Salvatore D'Angelo" <dangelo.sasaman@tiscalinet.it>,
       Chris McDonald <chris@cs.uwa.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: gettimeofday problem
In-Reply-To: <20020624233406.GA18854@idefix.fvdpol.home.nl>
Message-ID: <Pine.LNX.3.95.1020625073649.18426A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jun 2002, Frank van de Pol wrote:

> 
> 
> Richard,
> 
> I gave your test program a try, and the problem is reproducably triggered:
> 
> 
> frank@idefix:~/projects$ ./tod
> Failed after 2008
> a = 1024961239107823, b = 1024961238254652
> frank@idefix:~/projects$ ./tod
> Failed after 1394
> a = 1024961252215231, b = 1024961239964379
> frank@idefix:~/projects$ ./tod
> Failed after 110179
> a = 1024961241574880, b = 1024961241573638
> frank@idefix:~/projects$ ./tod
> Failed after 4891
> a = 1024961242145265, b = 1024961242144027
> frank@idefix:~/projects$ ./tod
> Failed after 45008
> a = 1024961243210834, b = 1024961242943904
> frank@idefix:~/projects$ ./tod
> Failed after 6695
> a = 1024961243405068, b = 1024961243403828
> frank@idefix:~/projects$ ./tod
> Failed after 1487
> a = 1024961244216903, b = 1024961244093738
> frank@idefix:~/projects$ ./tod
> Failed after 3275
> a = 1024961245674712, b = 1024961245673487
> frank@idefix:~/projects$ ./tod
> Failed after 42122
> a = 1024961259065626, b = 1024961246333377
> frank@idefix:~/projects$ ./tod
> Failed after 425
> a = 1024961253600435, b = 1024961252652402
> frank@idefix:~/projects$
> 
> 
> Possibly it might have to do with the fact that my machine is an SMP box
> (dual pentium II)
> 
> $ uname -a
> 
> Linux idefix 2.4.18 #3 SMP Sat Apr 20 14:35:58 CEST 2002 i686 unknown
> 
> In fact it is almost symmetrical (one CPU seems to be faster than the other,
> eventhough they are running at the same clock speed).
> 
> $ cat /proc/cpuinfo
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 3
> model name      : Pentium II (Klamath)
> stepping        : 4
> cpu MHz         : 333.225
> cache size      : 512 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov mmx
> bogomips        : 665.19
> 
> processor       : 1
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 5
> model name      : Pentium II (Deschutes)
> stepping        : 2
> cpu MHz         : 333.225
> cache size      : 512 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx
> bogomips        : 748.74
> 
> 

Well, I have a dual Pentium also, but I didn't mix two different
CPUs as you have done. I'm supprised that your combination even
works!  It could be a good 'checker' for hard-to-make race conditions.

Linux chaos 2.4.18 #14 SMP Mon Jun 17 15:31:13 EDT 2002 i686

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 5
model name	: Pentium II (Deschutes)
stepping	: 1
cpu MHz		: 399.570
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips	: 797.90

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 5
model name	: Pentium II (Deschutes)
stepping	: 1
cpu MHz		: 399.570
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips	: 797.90


I ran my program all night on another machine and it's still running.
Neither of these machines are trying to sync with NIST. Machines that
are running timing daemons that attempt to sync their clocks could, of
course, have problems with time-jumps.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

