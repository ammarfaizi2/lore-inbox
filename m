Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265804AbSKAWu5>; Fri, 1 Nov 2002 17:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265808AbSKAWu5>; Fri, 1 Nov 2002 17:50:57 -0500
Received: from pasky.ji.cz ([62.44.12.54]:7675 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S265804AbSKAWux>;
	Fri, 1 Nov 2002 17:50:53 -0500
Date: Fri, 1 Nov 2002 23:57:21 +0100
From: Petr Baudis <pasky@pasky.ji.cz>
To: user-mode-linux-user@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: UML doesn't build in 2.5.45
Message-ID: <20021101225721.GP2659@pasky.ji.cz>
Mail-Followup-To: user-mode-linux-user@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  when tried to build UML with 2.5.45, I got into problems relatively quickly:

  # make mrproper ARCH=um
..went ok..
  # make oldconfig ARCH=um
..went ok..
  # make dep ARCH=um
  gcc -Wp,-MD,arch/um/sys-i386/util/.mk_thread_kern.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -U__i386__ -Ui386   -D__arch_um__ -DSUBARCH=\"i386\" -D_LARGEFILE64_SOURCE -I/opt/src/opt/uml/linux-2.5.30/arch/um/include -Derrno=kernel_errno -nostdinc -iwithprefix include    -DKBUILD_BASENAME=mk_thread_kern   -c -o arch/um/sys-i386/util/mk_thread_kern.o arch/um/sys-i386/util/mk_thread_kern.c
In file included from include/linux/posix_types.h:46,
                 from include/linux/types.h:11,
                 from include/linux/capability.h:16,
                 from include/linux/sched.h:9,
                 from arch/um/sys-i386/util/mk_thread_kern.c:2:
include/asm/posix_types.h:4: asm/arch/posix_types.h: No such file or directory
In file included from include/linux/types.h:12,
                 from include/linux/capability.h:16,
                 from include/linux/sched.h:9,
                 from arch/um/sys-i386/util/mk_thread_kern.c:2:
include/asm/types.h:4: asm/arch/types.h: No such file or directory
In file included from include/linux/bitops.h:3,
                 from include/linux/thread_info.h:10,
                 from include/linux/spinlock.h:12,
                 from include/linux/capability.h:44,
                 from include/linux/sched.h:9,
                 from arch/um/sys-i386/util/mk_thread_kern.c:2:
include/asm/bitops.h:4: asm/arch/bitops.h: No such file or directory
In file included from include/linux/thread_info.h:11,
                 from include/linux/spinlock.h:12,
                 from include/linux/capability.h:44,
                 from include/linux/sched.h:9,
                 from arch/um/sys-i386/util/mk_thread_kern.c:2:
include/asm/thread_info.h:11: asm/processor.h: No such file or directory
In file included from include/linux/kernel.h:15,
                 from include/linux/spinlock.h:13,
                 from include/linux/capability.h:44,
                 from include/linux/sched.h:9,
                 from arch/um/sys-i386/util/mk_thread_kern.c:2:
include/asm/byteorder.h:4: asm/arch/byteorder.h: No such file or directory
In file included from include/linux/spinlock.h:13,
                 from include/linux/capability.h:44,
                 from include/linux/sched.h:9,
                 from arch/um/sys-i386/util/mk_thread_kern.c:2:
include/linux/kernel.h:138: #error "Please fix asm/byteorder.h"
In file included from include/linux/capability.h:44,
                 from include/linux/sched.h:9,
                 from arch/um/sys-i386/util/mk_thread_kern.c:2:
include/linux/spinlock.h:16: asm/system.h: No such file or directory
In file included from arch/um/sys-i386/util/mk_thread_kern.c:2:
include/linux/sched.h:18: asm/system.h: No such file or directory
In file included from include/linux/sched.h:19,
                 from arch/um/sys-i386/util/mk_thread_kern.c:2:
include/asm/semaphore.h:4: asm/arch/semaphore.h: No such file or directory
..snip..
In file included from include/linux/msg.h:32,
                 from include/linux/security.h:34,
                 from include/linux/sched.h:586,
                 from arch/um/sys-i386/util/mk_thread_kern.c:2:
include/asm/msgbuf.h:4: asm/arch/msgbuf.h: No such file or directory
make[1]: *** [arch/um/sys-i386/util/mk_thread_kern.o] Error 1
make: *** [arch/um/sys-i386/util] Error 2

  include/asm/arch doesn't exist at all (I guess that it should be symlink to
include/asm-i386/ ..?), when setting it up manually and then copying around
some missing files ("just in case it would help"), I still got burnt from
archparam.h, which wasn't found anywhere.

  Kind regards,

-- 
 
				Petr "Pasky" Baudis
 
* ELinks maintainer                * IPv6 guy (XS26 co-coordinator)
* IRCnet operator                  * FreeCiv AI occassional hacker
.
This host is a black hole at HTTP wavelengths. GETs go in, and nothing
comes out, not even Hawking radiation.
                -- Graaagh the Mighty on rec.games.roguelike.angband
.
Public PGP key && geekcode && homepage: http://pasky.ji.cz/~pasky/
