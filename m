Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262324AbSLASqp>; Sun, 1 Dec 2002 13:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262326AbSLASqp>; Sun, 1 Dec 2002 13:46:45 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:30989 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262324AbSLASqo>; Sun, 1 Dec 2002 13:46:44 -0500
Date: Sun, 1 Dec 2002 10:54:38 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: sfr@canb.auug.org.au, <linux-kernel@vger.kernel.org>, <anton@samba.org>,
       <ak@muc.de>, <davidm@hpl.hp.com>, <schwidefsky@de.ibm.com>,
       <ralf@gnu.org>, <willy@debian.org>
Subject: Re: [PATCH] Start of compat32.h (again)
In-Reply-To: <20021127.212638.35873260.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0212011047440.12964-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 27 Nov 2002, David S. Miller wrote:
> 
> I envisioned moving the compat stuff right next to the "normal"
> implementation.

Why?

> A problem currently, is that when people change VFS stuff up one has
> to pay attention to update all the compat syscall layers as well.

Doesn't matter. The thing is, you have two kinds of fixups for things like 
VFS changes:

 - compiler warning/error based fixups (in which case it doesn't _matter_ 
   where it is, since in neither case will it get compiled for x86

 - a simple "grep xxxx *.c" kind of approach.

Yes, the latter often misses out on architecture files, because people
just won't even look at hits in sparc/ppc64/xxx, either being too timid to
want to check, or just not caring. But if the file is in kernel/xxxx, it 
will be noticed - at least as well as it would be if it was uglifying 
regular files with #ifdef's.

> Now if we put the stuff next to the non-compat stuff, it likely won't
> get missed.

.. but it will have ugly #ifdef's inside the source file, something that I 
absolutely detest. 

Face it, the "compat" stuff is _secondary_. If it breaks, it breaks. It's
better to have the main code paths clean and unsullied, and take the risk
of occasionally breaking the compatibility stuff (that will break
occasionally anyway, see above).

Quite frankly, I want people to literally have the option to just ignore
the compat stuff, simply because it's not as important as the core kernel 
code. 

I see the compat32 patches as a convenience, and as a way to avoid 
duplicating bus over the system. I do NOT consider it to be core 
functionality, and I do _not_ think it should be a first-class citizen. 
Sorry, guys. Code cleanliness is _way_ more important to me.

		Linus

