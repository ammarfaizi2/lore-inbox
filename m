Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269206AbRHBWrF>; Thu, 2 Aug 2001 18:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269203AbRHBWqq>; Thu, 2 Aug 2001 18:46:46 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:20428 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S269193AbRHBWqn>;
	Thu, 2 Aug 2001 18:46:43 -0400
Date: Thu, 2 Aug 2001 18:46:51 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: linux-kernel@vger.kernel.org
cc: Linus Torvalds <torvalds@transmeta.com>, linux-fsdevel@vger.kernel.org
Subject: [CFT] initramfs patch (2.4.8-pre3)
In-Reply-To: <Pine.GSO.4.21.0107300137550.16140-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0108021825460.1494-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


New version on ftp.math.psu.edu/pub/viro, namespaces-a-S8-pre3 and
initramfs-a-S8-pre3 (the latter is against 3.4.8-pre3 + namespaces).

News:

* arm glue added (kudos to rmk). It doesn't guarantee that thing
  _builds_ on arm - there may be differences in unistd.h that might
  be a problem. I don't have arm cross-compilers, so folks who do are
  welcome to try.

* /init now starts with unlinking itself, so when it finally does exec()
  the memory will be freed.

Please, help with testing. It's supposed to be a drop-in replacement -
apply patches, build and boot. If it boots - fine, if it doesn't - it
will panic before it could do any harm.

Still wanted: equivalents of arch/{i386,arm}/kernel/start.S for other
platforms. This stuff is basically a minimal crt1.o - pick the
argc/argv/envp from the stack (where execve(2) had left them) and
pass them to main().

Another thing is init/libc.h - due to differences between the set of
syscalls (e.g. socketcall() vs. socket()/sendto()/etc.) we may (==
most likely will) need more platform-specific stuff there. IMO it
should end up in include/asm-*. Right now it's known to do the
right thing on i386. Notice that it's not just syscalls - e.g.
memcpy() is a problem on K7, since it brings mmx_memcpy() in. There
may be other things of that kind.

Also wanted: less crude RPC (init/nfsroot.c) and userland variant of
net/ipv4/ipconfig.c. Unless I'm seriously mistaken, we need AF_PACKET
to do RARP from userland...


