Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133029AbREIDPf>; Tue, 8 May 2001 23:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133088AbREIDP0>; Tue, 8 May 2001 23:15:26 -0400
Received: from iris.services.ou.edu ([129.15.2.125]:56022 "EHLO
	iris.services.ou.edu") by vger.kernel.org with ESMTP
	id <S133029AbREIDPK>; Tue, 8 May 2001 23:15:10 -0400
Date: Tue, 08 May 2001 22:17:35 -0500
From: Sean Jones <sjones@ossm.edu>
Subject: Re: SPARC include problem
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <3AF8B6CF.94EF38D@ossm.edu>
MIME-version: 1.0
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-ac5 i586)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: en
In-Reply-To: <3AF71B1F.56FFCA16@ossm.edu>
 <20010508120108.A1802@arthur.ubicom.tudelft.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The include error was in kernel/sched.c . Should I rewrite the includes
for this file to include include/asm/irq.h over include/linux/irq.h? I
temporarily bypassed this problem by creating a blank asm/hw_irq.h . 

I also ran into a compile problem in arch/sparc/kernel/sparc_ksyms.c .
The rw semaphores seem to be undeclared. Here are the warnings:

D__KERNEL__ -I/usr/src/linux-2.4.4/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -fno-strict-aliasing -m32 -pipe -mno-fpu
-fcall-used-g5 -fcall-used-g7    -DEXPORT_SYMTAB -c sparc_ksyms.c
In file included from /usr/src/linux-2.4.4/include/linux/sched.h:9,
                 from sparc_ksyms.c:17:
/usr/src/linux-2.4.4/include/linux/binfmts.h:45: warning: `struct
mm_struct' declared inside parameter list
/usr/src/linux-2.4.4/include/linux/binfmts.h:45: warning: its scope is
only this definition or declaration, which is probably not what you
want.
sparc_ksyms.c:121: `___down_read' undeclared here (not in a function)
sparc_ksyms.c:121: initializer element is not constant
sparc_ksyms.c:121: (near initialization for
`__ksymtab____down_read.value')
sparc_ksyms.c:122: `___down_write' undeclared here (not in a function)
sparc_ksyms.c:122: initializer element is not constant
sparc_ksyms.c:122: (near initialization for
`__ksymtab____down_write.value')
sparc_ksyms.c:123: `___up_read' undeclared here (not in a function)
sparc_ksyms.c:123: initializer element is not constant
sparc_ksyms.c:123: (near initialization for
`__ksymtab____up_read.value')
sparc_ksyms.c:124: `___up_write' undeclared here (not in a function)
sparc_ksyms.c:124: initializer element is not constant
sparc_ksyms.c:124: (near initialization for
`__ksymtab____up_write.value')
make[1]: *** [sparc_ksyms.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.4/arch/sparc/kernel'
make: *** [_dir_arch/sparc/kernel] Error 2

Thank you,

Sean


Erik Mouw wrote:
> 
> On Mon, May 07, 2001 at 05:01:03PM -0500, Sean Jones wrote:
> > In compiling 2.4.4-ac5 for my SPARCStation 20, I had an error in the
> > compile resulting from the inability to find a hw_irq.h in the
> > include/asm directory. Do you know where I may be able to find such a
> > file?
> 
> You don't. I discussed this last week with Russell King: the ARM port
> also doesn't have the file hw_irq.h in include/asm-arm. According to
> Russell it is only needed in the arch dependent subdirectories, and not
> in the drivers.
> 
> Any driver that includes linux/irq.h is not written to be portable. The
> only generic driver that includes it is driver/pcmcia/hd64465_ss.c, but
> on second glance it's a Hitachi HD64465 specific driver anyway.
> 
> Erik
> 
> --
> J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
> of Electrical Engineering, Faculty of Information Technology and Systems,
> Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
> Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
> WWW: http://www-ict.its.tudelft.nl/~erik/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
