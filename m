Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264785AbSLBEQr>; Sun, 1 Dec 2002 23:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264786AbSLBEQr>; Sun, 1 Dec 2002 23:16:47 -0500
Received: from rth.ninka.net ([216.101.162.244]:50104 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S264785AbSLBEQq>;
	Sun, 1 Dec 2002 23:16:46 -0500
Subject: Re: [PATCH] Start of compat32.h (again)
From: "David S. Miller" <davem@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, anton@samba.org,
       ak@muc.de, davidm@hpl.hp.com, schwidefsky@de.ibm.com, ralf@gnu.org,
       willy@debian.org
In-Reply-To: <Pine.LNX.4.44.0212011047440.12964-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0212011047440.12964-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 01 Dec 2002 20:46:40 -0800
Message-Id: <1038804400.4411.4.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-12-01 at 10:54, Linus Torvalds wrote:
> But if the file is in kernel/xxxx, it 
> will be noticed - at least as well as it would be if it was uglifying 
> regular files with #ifdef's.

Ok, this I accept.

> Face it, the "compat" stuff is _secondary_. If it breaks, it breaks.

Secondary for x86, sure.

But for Sparc64 and PPC64, the 32-bit userland is currently still
the primary one, so when compat32 breaks the whole system hits the
toilet.

That isn't going to change.  The 32-bit apps are a) smaller and b)
run much faster.  So for simple things like the basic userland apps
like 'ls', the shell, etc. it simply makes no sense to compile them
64-bit.  It just results in big huge 64-bit binaries when 32-bit
ones would suffice just fine.

Sparc64 and PPC64 are different from ia64 in that the apps truly
run on the processor at full speed, no in some compat logic soldered
onto the cpu like the ia64 x86 support seems to be :-)

X86_64 on the other hand seems to run x86 binaries in a similar
fashion.  I don't know how people currently doing this port intend
to do the useland, but I bet it would benefit from a mostly 32-bit
userland just like sparc64/ppc64 does, both in space and performance.

