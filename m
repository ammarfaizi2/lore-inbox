Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264927AbRFUIFF>; Thu, 21 Jun 2001 04:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264928AbRFUIEz>; Thu, 21 Jun 2001 04:04:55 -0400
Received: from fungus.teststation.com ([212.32.186.211]:14348 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S264927AbRFUIEm>; Thu, 21 Jun 2001 04:04:42 -0400
Date: Thu, 21 Jun 2001 10:04:37 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
To: <linux-kernel@vger.kernel.org>
Subject: cproto use in the kernel source tree?
Message-ID: <Pine.LNX.4.30.0106210834070.5747-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I would like to automate generating the prototype list for smbfs. The list
in include/linux/smb_fs.h is probably mostly correct ... or not.

Does anyone use this type of tool anywhere else in the kernel sources?
Any input on how to set it up right is appreciated.


Here is what I have right now. arch/i386/math-emu/Makefile has this rule

proto:
        cproto -e -DMAKING_PROTO *.c >fpu_proto.h


If I do that in the smbfs Makefile, and run it as:
$ make TOPDIR=`pwd` -C fs/smbfs proto

I get heaps of errors (some of which I also get for the math-emu rule and
fpu_proto.h is definitly hand edited, so I wonder if it is really used).


For one thing it goes digging in "/usr/include/asm/" which isn't exactly
what I want. I can improve it by changing the rule to:

proto:
        cproto -e -I$(TOPDIR)/include -D__KERNEL__ -DMAKING_PROTO *.c > proto.h

And that seems to sort of work.

The only thing is that I get wierd errors on some gcc header:

"/usr/lib/gcc-lib/i386-redhat-linux/2.96/include/stdarg.h", line 43: parse 
error at token '__builtin_va_list'
Expected: auto char define-name double extern inline register static ... 
union

$ gcc -v
Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
gcc version 2.96 20000731 (Red Hat Linux 7.0)
$ rpm -qf `which gcc`
gcc-2.96-69
$ rpm -qf `which cproto`
cproto-4.6-5

I know it stops working (it misses some functions and complains more :)
after I apply some of my non-released patches. But that is probably
something I do wrong.

Is cproto even a good tool for doing this in the kernel tree?

/Urban

