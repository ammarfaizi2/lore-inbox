Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277900AbRJ1JFa>; Sun, 28 Oct 2001 04:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277904AbRJ1JFV>; Sun, 28 Oct 2001 04:05:21 -0500
Received: from pl038.nas921.ichikawa.nttpc.ne.jp ([210.165.234.38]:12599 "EHLO
	mbr.sphere.ne.jp") by vger.kernel.org with ESMTP id <S277900AbRJ1JFR>;
	Sun, 28 Oct 2001 04:05:17 -0500
Date: Sun, 28 Oct 2001 18:03:54 +0900
From: Bruce Harada <bruce@ask.ne.jp>
To: linux-kernel@vger.kernel.org
Subject: 2.2.20-pre11 compile error
Message-Id: <20011028180354.5b10bcd0.bruce@ask.ne.jp>
X-Mailer: Sylpheed version 0.4.66 (GTK+ 1.2.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When compiling 2.2.20-pre11, I get the following error:

-------
make[1]: Entering directory `/usr/src/linux-2.2.20/arch/i386/kernel'
cc -D__KERNEL__ -I/usr/src/linux-2.2.20/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer  -pipe -fno-strength-reduce -m486 -malign-loops=2
-malign-jumps=2 -malign-functions=2 -DCPU=586   -c -o process.o process.c
process.c: In function `sys_execve':
process.c:812: structure has no member named `ptrace'
process.c:812: `PT_DTRACE' undeclared (first use this function)
process.c:812: (Each undeclared identifier is reported only once
process.c:812: for each function it appears in.)
make[1]: *** [process.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.2.20/arch/i386/kernel'
make: *** [_dir_arch/i386/kernel] Error 2
-------

The cause appears to be the following change in arch/i386/kernel/process.c:

-------
@@ -808,7 +809,7 @@
                goto out;
        error = do_execve(filename, (char **) regs.ecx, (char **) regs.edx, &regs);
        if (error == 0)
-               current->flags &= ~PF_DTRACE;
+               current->ptrace &= ~PT_DTRACE;
        putname(filename);
 out:
        unlock_kernel();
-------

Any suggestions as to a fix? This is a libc5 system (5.4.46).


Bruce

