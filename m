Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265670AbSLBIGb>; Mon, 2 Dec 2002 03:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265677AbSLBIGb>; Mon, 2 Dec 2002 03:06:31 -0500
Received: from ns.suse.de ([213.95.15.193]:30470 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265670AbSLBIGa>;
	Mon, 2 Dec 2002 03:06:30 -0500
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Start of compat32.h (again)
References: <Pine.LNX.4.44.0212011047440.12964-100000@home.transmeta.com.suse.lists.linux.kernel> <1038804400.4411.4.camel@rth.ninka.net.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 02 Dec 2002 09:13:58 +0100
In-Reply-To: "David S. Miller"'s message of "2 Dec 2002 05:29:07 +0100"
Message-ID: <p737kesu9bt.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

> X86_64 on the other hand seems to run x86 binaries in a similar
> fashion.  I don't know how people currently doing this port intend

Yes it does.

> to do the useland, but I bet it would benefit from a mostly 32-bit
> userland just like sparc64/ppc64 does, both in space and performance.

Apart from a few unfortunate exceptions[1] the code size growth from
ia32 to x86-64 is very moderate. The binaries appear a bit bigger
because they have an .ehframe linked in by default, but .text growth
is not that bad (normally 5-10%, in some cases it even gets smaller)

Random sample (with .ehframe stripped):

64bit ls:
-rwxr-xr-x    1 root     root        76672 Oct 25 05:59 /bin/ls
  text    data     bss     dec     hex filename
  64847    7752    1136   73735   12007 /bin/ls

32bit ls: 
-rwxr-xr-x    1 root     root        68524 2002-09-09 22:56 /bin/ls
  text    data     bss     dec     hex filename
  65353    1112     872   67337   10709 /bin/ls

[< 1K .text growth, some .data growth due to 64bit pointers]

Performance is good too and gcc is a lot happier with 16 general purpose 
integer registers than with 8.

The current x86-64 distributions I'm aware of have a full 64bit userland.
That said you can run a 32bit distribution with a 64bit kernel just fine,
with the exception of modutils, but that should be fixed now with the 2.5
in kernel module loader. Good 32bit emulation is a goal for the port.

So you can run what you want - 32bit or 64bit - but the default is 64bit.

-Andi

[1] emacs is twice as big because its fundamental lisp word grows
from 32bit to 64bit. 
