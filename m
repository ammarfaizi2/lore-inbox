Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261902AbRE3Tla>; Wed, 30 May 2001 15:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261936AbRE3TlJ>; Wed, 30 May 2001 15:41:09 -0400
Received: from moline.gci.com ([205.140.80.106]:41989 "EHLO moline.gci.com")
	by vger.kernel.org with ESMTP id <S261902AbRE3TlA>;
	Wed, 30 May 2001 15:41:00 -0400
Message-ID: <BF9651D8732ED311A61D00105A9CA3150446E15A@berkeley.gci.com>
From: Leif Sawyer <lsawyer@gci.com>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: RE: 2.4.5 -ac series broken on Sparc64
Date: Wed, 30 May 2001 11:40:48 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox responded to:
> Leif Sawyer, who wrote:
>> include/linux/irq.h:61: asm/hw_irq.h: No such file or directory
>> *** [sched.o] Error 1
>> 
>> a find . -name 'hw_irq.h' shows appropriate versions
>> in i386, ia64, mips, mips64, alpha, ppc, parisc, um, and sh
>> 
> The sparc64 tree isnt very well integrated with -ac. What I 
> have I merge but where -ac varies from the Linus tree or the
> Linus tree  requires new files tends to break it.
> 
> It can probably be an empty file

This worked for me:

sed 's/_SH_/_SPARC64_/g' include/asm-sh/hw_irq.h >
include/asm-sparc64/hw_irq.h

make mrproper
cp ../.config .
make oldconfig
make dep && make

In file included from /usr/src/linux-2.4.5-ac4/include/linux/sched.h:9
/usr/src/linux-2.4.5-ac4/include/linux/binfmts.h:45: warning: `struct
mm_struct' declared inside parameter list
/usr/src/linux-2.4.5-ac4/include/linux/binfmts.h:45: warning: its scope is
only this definition or declaration,
/usr/src/linux-2.4.5-ac4/include/linux/binfmts.h:45: warning: which is
probably not what you want.

This warning is repeated for quite a good portion of the source files during
the make process, however the kernel seems to build correctly.  Haven't
tried a reboot though.. :-\
