Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129103AbQJaSMD>; Tue, 31 Oct 2000 13:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129413AbQJaSLx>; Tue, 31 Oct 2000 13:11:53 -0500
Received: from atol.icm.edu.pl ([212.87.0.35]:40973 "EHLO atol.icm.edu.pl")
	by vger.kernel.org with ESMTP id <S129103AbQJaSLj>;
	Tue, 31 Oct 2000 13:11:39 -0500
Date: Tue, 31 Oct 2000 19:11:23 +0100
From: Rafal Maszkowski <rzm@icm.edu.pl>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: test10-pre7 on Sparc
Message-ID: <20001031191123.A9831@burza.icm.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to run 2.4 kernel to have up to date ATM on SPARCstation 10,
possibly with 2 CPUs. Did not succeed to boot neither Linus nor CVS version
recently.  Compilation of 2.4.0.10.7:

binfmt_elf.c: In function `create_elf_tables':
binfmt_elf.c:166: `CLOCKS_PER_SEC' undeclared (first use in this function)
binfmt_elf.c:166: (Each undeclared identifier is reported only once
binfmt_elf.c:166: for each function it appears in.)
make[2]: *** [binfmt_elf.o] Error 1

missing

#ifdef __KERNEL__
# define CLOCKS_PER_SEC 100     /* frequency at which times() counts */
#endif

in include/asm-sparc/param.h


gcc -D__KERNEL__ -I/usr/src/6/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -m32 -pipe -
mno-fpu -fcall-used-g5 -fcall-used-g7    -c -o ip_forward.o ip_forward.c
ip_forward.c: In function `ip_forward':
ip_forward.c:139: `NET_RX_BAD' undeclared (first use in this function)
ip_forward.c:139: (Each undeclared identifier is reported only once
ip_forward.c:139: for each function it appears in.)
make[3]: *** [ip_forward.o] Error 1

I changed it to -EINVAL, should not disturb booting even if it is wrong


Booting non-SMP version on single CPU, more less:

bootmem_init...
free_...
reserve_...
Booting Linux

Watchdog Reset

ok _


I can collect the messages thru a serial console if the details are important.

R.
-- 
W iskier krzesaniu ¿ywem/Materia³ to rzecz g³ówna
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
