Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261486AbSLHU56>; Sun, 8 Dec 2002 15:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261527AbSLHU55>; Sun, 8 Dec 2002 15:57:57 -0500
Received: from mail.redswitch.com ([206.14.68.143]:6032 "EHLO redswitch.com")
	by vger.kernel.org with ESMTP id <S261486AbSLHU54>;
	Sun, 8 Dec 2002 15:57:56 -0500
Message-ID: <3DF3B40C.6060000@redswitch.com>
Date: Sun, 08 Dec 2002 13:05:16 -0800
From: Xiaogeng Jin <xjin@redswitch.com>
Organization: RedSwitch Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Cross-compile 2.4.20 (released on 11/28/2002) failed.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a problem when cross compiling linux-2.4.20 for a ppc-8xx 
system on a RedHat-7.3 x86 host using gcc-2.95.4. It complained that 
stdarg.h couldn't be found when sched.c is compiled. I compared the 
Makefile of 2.4.20 with the one of linuxppc_2_4_devel and found that it 
was caused by the different definition of kbuild_2_4_nostdinc.

2.4.20 Makefile defines kbuild_2_4_nostdinc as the following:
     kbuild_2_4_nostdinc   := -nostdinc -iwithprefix include
It doesn't work.
linuxppc_2_4_devel Makefile defines kbuild_2_4_nostdinc as the following:
     kbuild_2_4_nostdinc   := -nostdinc $(shell $(CC) -print-search-dirs 
| sed -ne 's/install: \(.*\)/-I \1include/gp')
It works for me.

Please CC replies to me. Thanks.

- Shawn.

Here is the compilatin error message.

make[2]: Entering directory `/home/xjin/code/linux-2.4.20/kernel'
ppc_8xx-gcc -D__KERNEL__ -I/home/xjin/code/linux-2.4.20/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -I/home/xjin/code/linux-2.4.20/arch/ppc 
-fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized 
-mmultiple -mstring -mcpu=860   -nostdinc -iwithprefix include 
-DKBUILD_BASENAME=sched  -fno-omit-frame-pointer -c -o sched.o sched.c
In file included from /home/xjin/code/linux-2.4.20/include/linux/wait.h:13,
                  from /home/xjin/code/linux-2.4.20/include/linux/fs.h:12,
                  from 
/home/xjin/code/linux-2.4.20/include/linux/capability.h:17,
                  from 
/home/xjin/code/linux-2.4.20/include/linux/binfmts.h:5,
                  from /home/xjin/code/linux-2.4.20/include/linux/sched.h:9,
                  from /home/xjin/code/linux-2.4.20/include/linux/mm.h:4,
                  from sched.c:23:
/home/xjin/code/linux-2.4.20/include/linux/kernel.h:10: stdarg.h: No 
such file or directory
In file included from /home/xjin/code/linux-2.4.20/include/linux/wait.h:13,
                  from /home/xjin/code/linux-2.4.20/include/linux/fs.h:12,
                  from 
/home/xjin/code/linux-2.4.20/include/linux/capability.h:17,
                  from 
/home/xjin/code/linux-2.4.20/include/linux/binfmts.h:5,
                  from /home/xjin/code/linux-2.4.20/include/linux/sched.h:9,
                  from /home/xjin/code/linux-2.4.20/include/linux/mm.h:4,
                  from sched.c:23:
/home/xjin/code/linux-2.4.20/include/linux/kernel.h:74: parse error 
before `va_list'
/home/xjin/code/linux-2.4.20/include/linux/kernel.h:74: warning: 
function declaration isn't a prototype
/home/xjin/code/linux-2.4.20/include/linux/kernel.h:77: parse error 
before `va_list'
/home/xjin/code/linux-2.4.20/include/linux/kernel.h:77: warning: 
function declaration isn't a prototype
/home/xjin/code/linux-2.4.20/include/linux/kernel.h:81: parse error 
before `va_list'
/home/xjin/code/linux-2.4.20/include/linux/kernel.h:81: warning: 
function declaration isn't a prototype
make[2]: *** [sched.o] Error 1
make[2]: Leaving directory `/home/xjin/code/linux-2.4.20/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/home/xjin/code/linux-2.4.20/kernel'
make: *** [_dir_kernel] Error 2

