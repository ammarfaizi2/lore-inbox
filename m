Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129121AbQKHNpB>; Wed, 8 Nov 2000 08:45:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129385AbQKHNov>; Wed, 8 Nov 2000 08:44:51 -0500
Received: from mirrors.planetinternet.be ([194.119.238.163]:2829 "EHLO
	mirrors.planetinternet.be") by vger.kernel.org with ESMTP
	id <S129379AbQKHNon>; Wed, 8 Nov 2000 08:44:43 -0500
Date: Wed, 8 Nov 2000 14:42:53 +0100
From: Kurt Roeckx <Q@ping.be>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: _stext and _etext in 2.2.18pre20
Message-ID: <20001108144252.A6071@ping.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I once complained about the s390 port not compiling because
_stext had conflicting types.

You seem to have changed include/asm/irq.h then, adding [] to it,
like it is in kernel/ksyms.c.

I just did a little grepping, And saw this:
./init/main.c:extern char _stext, _etext;
./kernel/ksyms.c:extern char _stext[], _etext[];
./include/asm-s390/irq.h:extern char _stext[];
./arch/i386/kernel/irq.h:extern char _stext, _etext;
./arch/alpha/kernel/traps.c:            extern unsigned long
_stext, _etext;
./arch/alpha/kernel/irq.h:extern char _stext;
./arch/sparc/kernel/sun4d_smp.c:                extern int
_stext;
./arch/sparc/kernel/sun4m_smp.c:                extern int
_stext;
./arch/sparc/mm/btfixup.c:extern unsigned int _stext[], _end[],
__start___ksymtab[], __stop___ksymtab[];
./arch/sparc/ap1000/timer.c:    extern int _stext;
./arch/mips/kernel/traps.c:     extern char _stext, _etext;
./arch/mips/kernel/time.c:                      extern int
_stext;
./arch/ppc/mm/init.c:extern char etext[], _stext[];
./arch/m68k/kernel/time.c:              extern int _stext;
./arch/sparc64/kernel/smp.c:            extern int _stext;
./arch/arm/kernel/setup.c:extern int _stext, _text, _etext,
_edata, _end;
./arch/arm/kernel/time.c:               extern int _stext;
./arch/arm/mm/init.c:extern char _etext, _stext, _edata,
__bss_start, _end;


As you can see, most of them don't have the [], but some do.
Others are (still?) signed or unsigned, int or long's.

I think all of them should be pointers, it doesn't make much
sense for them to be a char, altho most are just chars.

Doing the same in 2.4.0-test10, shows about the same.


What should be done with this?


Kurt

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
