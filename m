Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129248AbQLEByu>; Mon, 4 Dec 2000 20:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130252AbQLEByk>; Mon, 4 Dec 2000 20:54:40 -0500
Received: from portraits.wsisiz.edu.pl ([195.205.208.34]:13599 "EHLO
	portraits.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id <S129248AbQLEByg>; Mon, 4 Dec 2000 20:54:36 -0500
Date: Tue, 5 Dec 2000 02:19:55 +0100 (CET)
From: Lukasz Trabinski <lukasz@lt.wsisiz.edu.pl>
To: <linux-kernel@vger.kernel.org>
cc: <jakub@redhat.com>
Subject: Problems with Athlon CPU
Message-ID: <Pine.LNX.4.30.0012050205570.2065-100000@lt.wsisiz.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

There is probably not a kernel bug, but bug in gcc, but... :)

[root@beer linux]# make bzImage

[snip]

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -fno-strict-aliasing -pipe
-mpreferred-stack-boundary=2 -march=i686    -DEXPORT_SYMTAB -c selection.c
In file included from /usr/src/linux/include/asm/smp.h:21,
                 from /usr/src/linux/include/linux/smp.h:14,
                 from /usr/src/linux/include/linux/sched.h:22,
                 from selection.c:16:
/usr/src/linux/include/asm/apic.h:13:29: warning: nothing can be pasted
after this token
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -fno-strict-aliasing -pipe
-mpreferred-stack-boundary=2 -march=i686    -DEXPORT_SYMTAB -c serial.c
In file included from /usr/src/linux/include/asm/smp.h:21,
                 from /usr/src/linux/include/linux/smp.h:14,
                 from /usr/src/linux/include/linux/sched.h:22,
                 from serial.c:183:
/usr/src/linux/include/asm/apic.h:13:29: warning: nothing can be pasted
after this token
serial.c: In function `line_info':
serial.c:3241: Internal error: Segmentation fault.
Please submit a full bug report.
See <URL:http://www.gnu.org/software/gcc/bugs.html> for instructions.
make[3]: *** [serial.o] Error 2
make[3]: Leaving directory `/usr/src/linux/drivers/char'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux/drivers/char'
make[1]: *** [_subdir_char] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_dir_drivers] Error 2

I have tried compiled it on AMD Athlon Processor with glibc 2.2.
I have tried to compile kernels: 2.2.17, 2.2.18pre-24, 2.4.0-test11 and
always I have got this message. With glibc 2.1.94 I had not any problems
with compilation!


[lukasz@beer lukasz]$ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 3
model name      : AMD Athlon(tm) Processor
stepping        : 0
cpu MHz         : 600.043
cache size      : 1 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr 6 mce cx8 sep mtrr pge 14 cmov
fcmov 17 psn 22 mmx 24 30 3dnow
bogomips        : 1196.03

[lukasz@beer lukasz]$ gcc -v
Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
gcc version 2.96 20000731 (Red Hat Linux 7.0)

[lukasz@beer lukasz]$ rpm -q glibc
glibc-2.2-5

Any sugestions? On others machines with AMD-K6 or Petnium-III/II and
with the same version of glibc and gcc that problems does not exists!

ps
sorry for my broken english. :(



-- 
*[ £ukasz Tr±biñski ]*
SysAdmin @wsisiz.edu.pl

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
