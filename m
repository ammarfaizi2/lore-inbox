Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265656AbSJXUp0>; Thu, 24 Oct 2002 16:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265659AbSJXUp0>; Thu, 24 Oct 2002 16:45:26 -0400
Received: from paloma16.e0k.nbg-hannover.de ([62.181.130.16]:15784 "HELO
	paloma16.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S265656AbSJXUpW>; Thu, 24 Oct 2002 16:45:22 -0400
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [CFT] faster athlon/duron memory copy implementation
Date: Thu, 24 Oct 2002 22:51:26 +0200
User-Agent: KMail/1.4.7
Cc: Manfred Spraul <manfred@colorfullife.com>, Robert Love <rml@tech9.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_O1Fu9dqc/Z5/X8y"
Message-Id: <200210242251.26776.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_O1Fu9dqc/Z5/X8y
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Rober Love wrote:
> The majority of the program is inline assembly so I do not think
> compiler is playing a huge role here.

I think they are...

> Regardless, the numbers are all pretty uniform in saying the new no
> prefetch method is superior so its a mute point.

But all "your" numbers are slow.
Look at mine with the "right" (TM) flags ;-)

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) MP 1900+
stepping        : 2
cpu MHz         : 1600.377
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca=
=20
cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 3145.72

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) MP
stepping        : 2
cpu MHz         : 1600.377
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca=
=20
cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 3194.88


SuSE Linux 7.3

glibc-2.2.4
Addons: db db2 linuxthreads noversion
Build CFLAGS: -O -mcpu=3Dk6 -mpreferred-stack-boundary=3D2 -malign-function=
s=3D4=20
=2Dfschedule-insns2 -fexpensive-optimizations -g
Build CC: gcc
Compiler version: 2.95.3 20010315 (SuSE)

Linux 2.5.43-mm2
Kernel compiler FLAGS
HOSTCC          =3D gcc
HOSTCFLAGS      =3D -Wall -Wstrict-prototypes -O -fomit-frame-pointer -mcpu=
=3Dk6=20
=2Dmpreferred-stack-boundary=3D2 -malign-functions=3D4 -fschedule-insns2=20
=2Dfexpensive-optimizations

YES, I only use "-mcpu=3Dk6" and "-O" for ages (since 26. August 1999 ;-) o=
n my=20
Athlons.

nuetzel/Entwicklung> ./athlon ; ./athlon ; ./athlon
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $
clear_page() tests
clear_page function 'warm up run'        took 17409 cycles per page
clear_page function '2.4 non MMX'        took 12340 cycles per page
clear_page function '2.4 MMX fallback'   took 12429 cycles per page
clear_page function '2.4 MMX version'    took 9794 cycles per page
clear_page function 'faster_clear_page'  took 4639 cycles per page
clear_page function 'even_faster_clear'  took 4914 cycles per page

copy_page() tests
copy_page function 'warm up run'         took 16506 cycles per page
copy_page function '2.4 non MMX'         took 18412 cycles per page
copy_page function '2.4 MMX fallback'    took 18468 cycles per page
copy_page function '2.4 MMX version'     took 16550 cycles per page
copy_page function 'faster_copy'         took 10239 cycles per page
copy_page function 'even_faster'         took 10816 cycles per page


Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $
clear_page() tests
clear_page function 'warm up run'        took 17148 cycles per page
clear_page function '2.4 non MMX'        took 12426 cycles per page
clear_page function '2.4 MMX fallback'   took 12330 cycles per page
clear_page function '2.4 MMX version'    took 9776 cycles per page
clear_page function 'faster_clear_page'  took 4619 cycles per page
clear_page function 'even_faster_clear'  took 4938 cycles per page

copy_page() tests
copy_page function 'warm up run'         took 16640 cycles per page
copy_page function '2.4 non MMX'         took 18434 cycles per page
copy_page function '2.4 MMX fallback'    took 18454 cycles per page
copy_page function '2.4 MMX version'     took 16533 cycles per page
copy_page function 'faster_copy'         took 10418 cycles per page
copy_page function 'even_faster'         took 10707 cycles per page


Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $
clear_page() tests
clear_page function 'warm up run'        took 17475 cycles per page
clear_page function '2.4 non MMX'        took 12435 cycles per page
clear_page function '2.4 MMX fallback'   took 12379 cycles per page
clear_page function '2.4 MMX version'    took 9902 cycles per page
clear_page function 'faster_clear_page'  took 4665 cycles per page
clear_page function 'even_faster_clear'  took 4947 cycles per page

copy_page() tests
copy_page function 'warm up run'         took 16606 cycles per page
copy_page function '2.4 non MMX'         took 18439 cycles per page
copy_page function '2.4 MMX fallback'    took 18676 cycles per page
copy_page function '2.4 MMX version'     took 16560 cycles per page
copy_page function 'faster_copy'         took 10239 cycles per page
copy_page function 'even_faster'         took 10728 cycles per page

nuetzel/Entwicklung> ./athlon2 ; ./athlon2 ; ./athlon2
1600.061 MHz
clear_page by 'normal_clear_page'        took 12463 cycles (501.5 MB/s)
clear_page by 'slow_zero_page'           took 12461 cycles (501.6 MB/s)
clear_page by 'fast_clear_page'          took 9555 cycles (654.1 MB/s)
clear_page by 'faster_clear_page'        took 4436 cycles (1408.7 MB/s)

copy_page by 'normal_copy_page'  took 8992 cycles (695.0 MB/s)
copy_page by 'slow_copy_page'    took 9010 cycles (693.7 MB/s)
copy_page by 'fast_copy_page'    took 8134 cycles (768.3 MB/s)
copy_page by 'faster_copy'       took 5546 cycles (1126.8 MB/s)
copy_page by 'even_faster'       took 5616 cycles (1112.9 MB/s)


1600.057 MHz
clear_page by 'normal_clear_page'        took 12555 cycles (497.8 MB/s)
clear_page by 'slow_zero_page'           took 12740 cycles (490.6 MB/s)
clear_page by 'fast_clear_page'          took 9783 cycles (638.8 MB/s)
clear_page by 'faster_clear_page'        took 4459 cycles (1401.4 MB/s)

copy_page by 'normal_copy_page'  took 9123 cycles (685.0 MB/s)
copy_page by 'slow_copy_page'    took 9080 cycles (688.3 MB/s)
copy_page by 'fast_copy_page'    took 8232 cycles (759.3 MB/s)
copy_page by 'faster_copy'       took 5535 cycles (1129.1 MB/s)
copy_page by 'even_faster'       took 5565 cycles (1123.1 MB/s)


1600.060 MHz
clear_page by 'normal_clear_page'        took 12625 cycles (495.1 MB/s)
clear_page by 'slow_zero_page'           took 12541 cycles (498.3 MB/s)
clear_page by 'fast_clear_page'          took 9648 cycles (647.8 MB/s)
clear_page by 'faster_clear_page'        took 4463 cycles (1400.2 MB/s)

copy_page by 'normal_copy_page'  took 9178 cycles (680.9 MB/s)
copy_page by 'slow_copy_page'    took 9011 cycles (693.6 MB/s)
copy_page by 'fast_copy_page'    took 8138 cycles (768.0 MB/s)
copy_page by 'faster_copy'       took 5508 cycles (1134.7 MB/s)
copy_page by 'even_faster'       took 5552 cycles (1125.6 MB/s)

Regards,
	Dieter
=2D-=20
Dieter N=FCtzel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel at hamburg.de (replace at with @)

--Boundary-00=_O1Fu9dqc/Z5/X8y
Content-Type: application/x-bzip2;
  name="athlon2.c.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="athlon2.c.bz2"

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
H2qiVIA=

--Boundary-00=_O1Fu9dqc/Z5/X8y--

