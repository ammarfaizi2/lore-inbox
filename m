Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129989AbQKIBkW>; Wed, 8 Nov 2000 20:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129988AbQKIBkM>; Wed, 8 Nov 2000 20:40:12 -0500
Received: from jalon.able.es ([212.97.163.2]:9419 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129044AbQKIBj5>;
	Wed, 8 Nov 2000 20:39:57 -0500
Date: Thu, 9 Nov 2000 02:39:50 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Errors in 2.4-test11 build
Message-ID: <20001109023950.A4777@werewolf.able.es>
Reply-To: jamagallon@able.es
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.0.pre2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to build 2.4.0-test11-pre1 I get the following:

make[1]: Entering directory `/usr/src/linux-2.4.0-test11/arch/i386/kernel'
kgcc -D__ASSEMBLY__ -D__KERNEL__ -I/usr/src/linux/include -traditional -c
trampoline.S -o trampoline.o
gcc: installation problem, cannot exec `tradcpp0': No such file or directory
make[1]: *** [trampoline.o] Error 1

My egcs does not have a -traditional cpp (Mandrake 7.2, packages egcs and
egcs-cpp).

Is mandatory the -traditional flag in linux/arch/i386/kernel/Makefile ?

If I symlink /usr/lib/gcc-lib/i586-mandrake-linux/egcs-2.91.66/tradcpp0 -> cpp0,
or
remove -traditional:

kgcc -D__ASSEMBLY__ -D__KERNEL__ -I/usr/src/linux/include -c trampoline.S -o
trampoline.o
trampoline.S:47: unterminated character constant

Code is:
    movl    $0xA5A5A5A5, trampoline_data - r_base
 >>>>>          # write marker for master knows we're running

well, remove the comment. Then:

kgcc -D__ASSEMBLY__ -D__KERNEL__ -I/usr/src/linux/include -c trampoline.S -o
trampoline.o
/tmp/ccg9ZEBO.s: Assembler messages:
/tmp/ccg9ZEBO.s:806: Error: can't handle non absolute segment in `ljmp'

What's going on ??? Build works ok with 2.95.2.
Any idea ?

Thanks for reading...

-- 
Juan Antonio Magallon Lacarta                                 #> cd /pub
mailto:jamagallon@able.es                                     #> more beer

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
