Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318970AbSICWST>; Tue, 3 Sep 2002 18:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318971AbSICWST>; Tue, 3 Sep 2002 18:18:19 -0400
Received: from node-c-067b.a2000.nl ([62.194.6.123]:48746 "HELO
	pipc.pipsels.pip") by vger.kernel.org with SMTP id <S318970AbSICWSR>;
	Tue, 3 Sep 2002 18:18:17 -0400
Date: Wed, 4 Sep 2002 00:22:43 +0200
From: Remco Post <r.post@sara.nl>
To: "Oliver Pitzeier" <o.pitzeier@uptime.at>
Cc: thunder@lightweight.ods.org, donaldlf@cs.rose-hulman.edu,
       axp-kernel-list@redhat.com, linux-kernel@vger.kernel.org,
       ink@jurassic.park.msu.ru
Subject: [PATCH] include/linux/ptrace.h Re: Kernel 2.5.33 compile errors (Re: Kernel 2.5.33 successfully compiled)
Message-Id: <20020904002243.7d3a4412.r.post@sara.nl>
In-Reply-To: <200209031827.16594.o.pitzeier@uptime.at>
References: <Pine.LNX.4.44.0209031006001.3373-100000@hawkeye.luckynet.adm>
	<200209031818.16140.o.pitzeier@uptime.at>
	<200209031827.16594.o.pitzeier@uptime.at>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Wed__4_Sep_2002_00:22:43_+0200_081fbe70"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Wed__4_Sep_2002_00:22:43_+0200_081fbe70
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

I now do have a successful compile, will try to boot it in a sec.... This is from the linuxppc-2.5 tree, will do the same patches on Linus' tree to see if that compiles as well. Ok, it sort of boots as well:

Kernel command line: console=ttyS0,9600 console=tty0 root=/dev/sda2
time_init: decrementer frequency = 16.666782 MHz
Calibrating delay loop... 266.24 BogoMIPS
Memory: 62280k available (1568k kernel code, 804k data, 100k init, 0k highmem)
Security Scaffold v1.0.0 initialized
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
PCI: Probing PCI hardware
Oops: kernel access of bad area, sig: 11
NIP: C000EFA0 LR: C00DF404 SP: C0363B50 REGS: c0363aa0 TRAP: 0301    Not taintedMSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00000000, DSISR: 42000000
TASK = c0360040[1] 'swapper' Last syscall: 120 
last math 00000000 last altivec 00000000
GPR00: C75C0080 C0363B50 C0360040 C03F94C0 00000000 0000000E 00000001 C0363B78 
GPR08: 00000000 00000000 C03F94CC C75C0000 64676500 
Call backtrace: 
C00DF404 C00E026C C00E036C C00E057C C020F130 C020C5F4 C020C638 
C00038E0 C0008A3C 
Kernel panic: Attempted to kill init!

Remember this is a prep board....

On Tue, 3 Sep 2002 18:27:16 +0200
"Oliver Pitzeier" <o.pitzeier@uptime.at> wrote:

> On Tuesday 03 September 2002 18:18, Oliver Pitzeier wrote:
> > On Tuesday 03 September 2002 18:14, Thunder from the hill wrote:
> [ ... ]
> > No. It seems simply missing. In 2.5.32 it is there. On the right place.
> > :o))))
> >
> > > > > process.c: In function `alpha_clone':
> > > > > process.c:268: too few arguments to function `do_fork'
> > > > > process.c: In function `alpha_vfork':
> > > > > process.c:277: too few arguments to function `do_fork'
> > > > > make[1]: *** [process.o] Error 1
> > > > > make[1]: Leaving directory
> > >
> > > Yes, the syntax changed.
> 
> OK, after calling do_fork with "NULL" as extra argument. It compiles.
> 
> (No, I do not want to make the kernel run fine [currently], but I want to 
> trace down the count of bugs to a countable value. :o) )
> 
> [ ... ]
> 
> OK. The next problem seems harded to me (Maybe Ivan can help a bit!?):
> 
Attached patch worked for _compiling_ on my powermac, it might help for you as well....

>   gcc -Wp,-MD,./.irq.o.d -D__KERNEL__ -I/usr/src/linux-2.5.33/include -Wall 
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
> -fno-strict-aliasing -fno-common -pipe -mno-fp-regs -ffixed-8 -msmall-data 
> -mcpu=ev5 -Wa,-mev6 -nostdinc -iwithprefix include    -DKBUILD_BASENAME=irq   
> -c -o irq.o irq.c
> In file included from irq.c:15:
> /usr/src/linux-2.5.33/include/linux/ptrace.h:28: warning: `struct task_struct' 
> declared inside parameter list
> /usr/src/linux-2.5.33/include/linux/ptrace.h:28: warning: its scope is only 
> this definition or declaration, which is probably not what you want
> /usr/src/linux-2.5.33/include/linux/ptrace.h:29: warning: `struct task_struct' 
> declared inside parameter list
> /usr/src/linux-2.5.33/include/linux/ptrace.h:30: warning: `struct task_struct' 
> declared inside parameter list
> /usr/src/linux-2.5.33/include/linux/ptrace.h:31: warning: `struct task_struct' 
> declared inside parameter list
> /usr/src/linux-2.5.33/include/linux/ptrace.h:32: warning: `struct task_struct' 
> declared inside parameter list
> /usr/src/linux-2.5.33/include/linux/ptrace.h:33: warning: `struct task_struct' 
> declared inside parameter list
> /usr/src/linux-2.5.33/include/linux/ptrace.h:35: warning: `struct task_struct' 
> declared inside parameter list
> /usr/src/linux-2.5.33/include/linux/ptrace.h:36: warning: `struct task_struct' 
> declared inside parameter list
> /usr/src/linux-2.5.33/include/linux/ptrace.h:39: warning: `struct task_struct' 
> declared inside parameter list
> /usr/src/linux-2.5.33/include/linux/ptrace.h: In function `ptrace_link':
> /usr/src/linux-2.5.33/include/linux/ptrace.h:41: dereferencing pointer to 
> incomplete type
> /usr/src/linux-2.5.33/include/linux/ptrace.h:42: warning: passing arg 1 of 
> `__ptrace_link' from incompatible pointer type
> /usr/src/linux-2.5.33/include/linux/ptrace.h:42: warning: passing arg 2 of 
> `__ptrace_link' from incompatible pointer type
> /usr/src/linux-2.5.33/include/linux/ptrace.h: At top level:
> /usr/src/linux-2.5.33/include/linux/ptrace.h:44: warning: `struct task_struct' 
> declared inside parameter list
> /usr/src/linux-2.5.33/include/linux/ptrace.h: In function `ptrace_unlink':
> /usr/src/linux-2.5.33/include/linux/ptrace.h:46: dereferencing pointer to 
> incomplete type
> /usr/src/linux-2.5.33/include/linux/ptrace.h:47: warning: passing arg 1 of 
> `__ptrace_unlink' from incompatible pointer type
> make[1]: *** [irq.o] Error 1
> make[1]: Leaving directory `/usr/src/linux-2.5.33/arch/alpha/kernel'
> make: *** [arch/alpha/kernel] Error 2
> 
> -- 
> Oliver Pitzeier
> UNIX Administrator
> -
> Linux 2.4.19 i686     Load: 0.32 0.25 0.27
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



--Multipart_Wed__4_Sep_2002_00:22:43_+0200_081fbe70
Content-Type: application/octet-stream;
 name="ptrace.patch"
Content-Disposition: attachment;
 filename="ptrace.patch"
Content-Transfer-Encoding: base64

KioqIHB0cmFjZS5oLm9yZwlUdWUgU2VwICAzIDE1OjE0OjM1IDIwMDIKLS0tIHB0cmFjZS5oCVR1
ZSBTZXAgIDMgMjA6MzE6MTMgMjAwMgoqKioqKioqKioqKioqKioKKioqIDI0LDI5ICoqKioKLS0t
IDI0LDMwIC0tLS0KICAjZGVmaW5lIFBUUkFDRV9TWVNDQUxMCQkgIDI0CiAgCiAgI2luY2x1ZGUg
PGFzbS9wdHJhY2UuaD4KKyAjaW5jbHVkZSA8bGludXgvc2NoZWQuaD4KICAKICBleHRlcm4gaW50
IHB0cmFjZV9yZWFkZGF0YShzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRzaywgdW5zaWduZWQgbG9uZyBz
cmMsIGNoYXIgKmRzdCwgaW50IGxlbik7CiAgZXh0ZXJuIGludCBwdHJhY2Vfd3JpdGVkYXRhKHN0
cnVjdCB0YXNrX3N0cnVjdCAqdHNrLCBjaGFyICogc3JjLCB1bnNpZ25lZCBsb25nIGRzdCwgaW50
IGxlbik7Cg==

--Multipart_Wed__4_Sep_2002_00:22:43_+0200_081fbe70--
