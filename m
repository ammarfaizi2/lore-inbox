Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318873AbSICQ2a>; Tue, 3 Sep 2002 12:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318875AbSICQ2a>; Tue, 3 Sep 2002 12:28:30 -0400
Received: from vivi.uptime.at ([62.116.87.11]:63185 "EHLO mail.uptime.at")
	by vger.kernel.org with ESMTP id <S318873AbSICQ23> convert rfc822-to-8bit;
	Tue, 3 Sep 2002 12:28:29 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Pitzeier <o.pitzeier@uptime.at>
Organization: UPtime system solutions
To: Thunder from the hill <thunder@lightweight.ods.org>
Subject: Kernel 2.5.33 compile errors (Re: Kernel 2.5.33 successfully compiled)
Date: Tue, 3 Sep 2002 18:27:16 +0200
User-Agent: KMail/1.4.2
Cc: Leslie Donaldson <donaldlf@cs.rose-hulman.edu>,
       <axp-kernel-list@redhat.com>, <linux-kernel@vger.kernel.org>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>
References: <Pine.LNX.4.44.0209031006001.3373-100000@hawkeye.luckynet.adm> <200209031818.16140.o.pitzeier@uptime.at>
In-Reply-To: <200209031818.16140.o.pitzeier@uptime.at>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209031827.16594.o.pitzeier@uptime.at>
X-MailScanner: Nothing found, baby
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 September 2002 18:18, Oliver Pitzeier wrote:
> On Tuesday 03 September 2002 18:14, Thunder from the hill wrote:
[ ... ]
> No. It seems simply missing. In 2.5.32 it is there. On the right place.
> :o))))
>
> > > > process.c: In function `alpha_clone':
> > > > process.c:268: too few arguments to function `do_fork'
> > > > process.c: In function `alpha_vfork':
> > > > process.c:277: too few arguments to function `do_fork'
> > > > make[1]: *** [process.o] Error 1
> > > > make[1]: Leaving directory
> >
> > Yes, the syntax changed.

OK, after calling do_fork with "NULL" as extra argument. It compiles.

(No, I do not want to make the kernel run fine [currently], but I want to 
trace down the count of bugs to a countable value. :o) )

[ ... ]

OK. The next problem seems harded to me (Maybe Ivan can help a bit!?):

  gcc -Wp,-MD,./.irq.o.d -D__KERNEL__ -I/usr/src/linux-2.5.33/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mno-fp-regs -ffixed-8 -msmall-data 
-mcpu=ev5 -Wa,-mev6 -nostdinc -iwithprefix include    -DKBUILD_BASENAME=irq   
-c -o irq.o irq.c
In file included from irq.c:15:
/usr/src/linux-2.5.33/include/linux/ptrace.h:28: warning: `struct task_struct' 
declared inside parameter list
/usr/src/linux-2.5.33/include/linux/ptrace.h:28: warning: its scope is only 
this definition or declaration, which is probably not what you want
/usr/src/linux-2.5.33/include/linux/ptrace.h:29: warning: `struct task_struct' 
declared inside parameter list
/usr/src/linux-2.5.33/include/linux/ptrace.h:30: warning: `struct task_struct' 
declared inside parameter list
/usr/src/linux-2.5.33/include/linux/ptrace.h:31: warning: `struct task_struct' 
declared inside parameter list
/usr/src/linux-2.5.33/include/linux/ptrace.h:32: warning: `struct task_struct' 
declared inside parameter list
/usr/src/linux-2.5.33/include/linux/ptrace.h:33: warning: `struct task_struct' 
declared inside parameter list
/usr/src/linux-2.5.33/include/linux/ptrace.h:35: warning: `struct task_struct' 
declared inside parameter list
/usr/src/linux-2.5.33/include/linux/ptrace.h:36: warning: `struct task_struct' 
declared inside parameter list
/usr/src/linux-2.5.33/include/linux/ptrace.h:39: warning: `struct task_struct' 
declared inside parameter list
/usr/src/linux-2.5.33/include/linux/ptrace.h: In function `ptrace_link':
/usr/src/linux-2.5.33/include/linux/ptrace.h:41: dereferencing pointer to 
incomplete type
/usr/src/linux-2.5.33/include/linux/ptrace.h:42: warning: passing arg 1 of 
`__ptrace_link' from incompatible pointer type
/usr/src/linux-2.5.33/include/linux/ptrace.h:42: warning: passing arg 2 of 
`__ptrace_link' from incompatible pointer type
/usr/src/linux-2.5.33/include/linux/ptrace.h: At top level:
/usr/src/linux-2.5.33/include/linux/ptrace.h:44: warning: `struct task_struct' 
declared inside parameter list
/usr/src/linux-2.5.33/include/linux/ptrace.h: In function `ptrace_unlink':
/usr/src/linux-2.5.33/include/linux/ptrace.h:46: dereferencing pointer to 
incomplete type
/usr/src/linux-2.5.33/include/linux/ptrace.h:47: warning: passing arg 1 of 
`__ptrace_unlink' from incompatible pointer type
make[1]: *** [irq.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.5.33/arch/alpha/kernel'
make: *** [arch/alpha/kernel] Error 2

-- 
Oliver Pitzeier
UNIX Administrator
-
Linux 2.4.19 i686     Load: 0.32 0.25 0.27

