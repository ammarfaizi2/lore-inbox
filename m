Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312146AbSDDN2G>; Thu, 4 Apr 2002 08:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313088AbSDDN1z>; Thu, 4 Apr 2002 08:27:55 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:2435 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S312146AbSDDN1q>; Thu, 4 Apr 2002 08:27:46 -0500
Date: Thu, 4 Apr 2002 08:26:50 -0500 (EST)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Keith Owens <kaos@ocs.com.au>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrea Arcangeli <andrea@suse.de>,
        Arjan van de Ven <arjanv@redhat.com>, Hugh Dickins <hugh@veritas.com>,
        Stelian Pop <stelian.pop@fr.alcove.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
In-Reply-To: <Pine.LNX.4.33.0204041245340.1475-100000@einstein.homenet>
Message-ID: <Pine.LNX.4.44.0204040747260.25330-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 4 Apr 2002, Tigran Aivazian wrote:

> [...] Namely, in the sense that it is inconsistent with the similar
> situation in the case of libraries or even system calls. I don't see why
> exporting kernel symbols should be so radically different and extremely
> sensitive to the nature of the consumer's license for some symbols but
> not for others...

Tigran, the difference is very very fundamental, please think about it,
and please try to ignore the fact that you are working for Veritas.
Internal modules of the GPL kernel are just a technical modularization of
a complete and unified GPL-ed work. We want it to stay consistent, we want
*our* work to be fully and completely debuggable, supportable and we want
to be able to understand and develop any part of it. This is our intent.

the moment you start to argue 'but why cannot we just add this set of
EXPORTs and put our binary-only modules here and there' you are in essence
questioning our freedom to specify the license of our work. You are
abusing the internal modularization mechanizm to put in code that we
cannot debug, cannot read and cannot develop and cannot support in any
reasonable way. It's like exchanging kernel/sched.o with your binary-only
implementation and not publishing the source code of it. If you want to
play such games then you have to implement the other 4 million lines as
well, nobody prevents you to do that.

system calls are a published, honored, maintained interface. User-space
applications are indpendent works not derived from the GPL-ed kernel in
any way. Hence the exception.

historically we have also chosen to to provide a different type of API
towards more or less clearly separate works, like independently developed,
non-GPL hardware drivers. Let yourself not be confused by the fact that
the same technical mechanizm is also used to demand-link separate smaller
parts of the kernel work as well.

The impact of binary-only modules on the kernel's development architecture
is not zero but not overly significant either, so most of us are pretty
pragmatic about that, as long as binary-only module vendors are not
abusing this mechanizm to impact the integrity of the kernel and create
clearly derived works without obeying the rules of the GPL. And it's clear
that internal symbols are just that: internal, still part of the kernel
work. [and directly resulting from that, they obey the GPL.]

I consider 'abuse' for example a kernel derivative with a 'modified'
scheduler. The day it will be possible to put a binary-only sched.o into
the kernel i'll stop doing Linux. I am not here to develop some 'lite'
version of the OS, where all the interesting stuff happens behind closed
doors. I'm not here either to see the quality of the OS degrade due to
sloppy programming in widely used binary-only modules, without being able
to fix it.

The GPL right now protects our work from being abused in such a way - it's
illegal to provide a binary-only sched.o and compile a kernel product from
that, because the resulting kernel is still one work and the whole work
must still be under the GPL. It's equally illegal to recover the location
of sched.o in the final kernel image and runtime relink it with a
binary-only sched.o. It's equally illegal to accomplish the same over the
internal module interface.

Think about it, every separate .o in the Linux kernel can be equivalently
expressed in terms of a EXPORT-ed module interface, GPL-ed header files
and a closed-source module. There is a good reason why the GPL forbids
such freely defined 'module interfaces' to be added. Think of the GPL as
the price you pay for being able to use the Linux kernel's source code or
being allowed to link to it - you are not forced in any way to do that.

and no, you have no *right* to link a binary-only sched.o to the Linux
kernel - even if you develop a sched.c 'separately' - and intuitively feel
that it's somehow a separate work, the end result is still a derivative of
the kernel. And this violation of the license is illegal in most
countries, it's even a crime in some countries.

	Ingo

