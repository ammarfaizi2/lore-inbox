Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266163AbUAGJjR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 04:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266164AbUAGJjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 04:39:17 -0500
Received: from gizmo07bw.bigpond.com ([144.140.70.17]:2225 "HELO
	gizmo07bw.bigpond.com") by vger.kernel.org with SMTP
	id S266163AbUAGJjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 04:39:14 -0500
Message-ID: <3FFBD3BE.F2584F7C@eyal.emu.id.au>
Date: Wed, 07 Jan 2004 20:39:10 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.25-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pawel Kot <pkot@linuxnews.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.24 asm/timex.h
References: <Pine.LNX.4.33.0401070027540.13426-100000@urtica.linuxnews.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pawel Kot wrote:
> 
> On Wed, 7 Jan 2004, Eyal Lebedinsky wrote:
> 
> > Building valgrind, it includes <linux/timex.h> and then tries
> > to use the adjtimex syscall. This ends up with an undefined
> > error for 'cpu_has_tsc'. This did not happen with earlier
> > kernels.
> >
> > In file included from /usr/include/linux/timex.h:152,
> >                  from vg_unsafe.h:66,
> >                  from vg_syscalls.c:35:
> > /usr/include/asm/timex.h: In function `get_cycles':
> > /usr/include/asm/timex.h:44: `cpu_has_tsc' undeclared (first use in this
> > function)
> 
> cpu_has_tsc is defined in cpufeature.h, so probably adding:
> #include <asm/cpufeature.h>
> to the include/asm-i386/timex.h would help.

Not really, I already tried a few such fixes.

gcc -DHAVE_CONFIG_H -I. -I. -I..  -I./demangle -I../include -I./x86
-DVG_LIBDIR="\"/usr/local/lib/valgrind"\"   -Winline -Wall -Wshadow -O
-fno-omit-frame-pointer -mpreferred-stack-boundary=2 -g -DELFSZ=32  -c
`test -f vg_syscalls.c || echo './'`vg_syscalls.c
In file included from /usr/include/linux/timex.h:152,
                 from vg_unsafe.h:68,
                 from vg_syscalls.c:35:
/usr/include/asm/timex.h: In function `get_cycles':
/usr/include/asm/timex.h:44: warning: implicit declaration of function
`test_bit'
/usr/include/asm/timex.h:44: `boot_cpu_data' undeclared (first use in
this function)
/usr/include/asm/timex.h:44: (Each undeclared identifier is reported
only once
/usr/include/asm/timex.h:44: for each function it appears in.)
make[4]: *** [vg_syscalls.o] Error 1
make[4]: Leaving directory `/data2/download/valgrind/valgrind/coregrind'

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
