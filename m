Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313130AbSDDKh0>; Thu, 4 Apr 2002 05:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313131AbSDDKhE>; Thu, 4 Apr 2002 05:37:04 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:27234 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S313130AbSDDKg7>; Thu, 4 Apr 2002 05:36:59 -0500
Date: Thu, 4 Apr 2002 05:35:59 -0500
From: Arjan van de Ven <arjanv@redhat.com>
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrea Arcangeli <andrea@suse.de>,
        Arjan van de Ven <arjanv@redhat.com>, Hugh Dickins <hugh@veritas.com>,
        Ingo Molnar <mingo@redhat.com>,
        Stelian Pop <stelian.pop@fr.alcove.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
Message-ID: <20020404053559.A20827@devserv.devel.redhat.com>
In-Reply-To: <22511.1017902599@kao2.melbourne.sgi.com> <Pine.LNX.4.33.0204041041530.1475-100000@einstein.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2002 at 11:22:15AM +0100, Tigran Aivazian wrote:
> On Thu, 4 Apr 2002, Keith Owens wrote:
> > When the flamers and lawyers agree on what they really mean by
> > EXPORT_SYMBOL_GPL or its replacement and everybody agrees on what the
> > keyword should be, let me know and I will roll a new modutils.
> > Otherwise, leave me out of this flamewar.
> 
> Let's look at the possible design for 2.5 first, then 2.4.
> 
> The meaning of EXPORT_SYMBOL_INTERNAL is that it can be used to export
> symbols by base kernel subsystems (static or modular) to other base kernel
> subsystems which can be compiled as a module. So, if the symbol is thus
> exported by what is thought of as "base kernel" then only modules that
> claim to be "base kernel" should use it. Similarly, if it is exported by a
> driver, then only modules closely associated with that driver (for drivers
> split in multiple modules) should be able to use it.
> 
> In other words, exporting symbols should not be based on the consumer's
> license because that is technically inappropriate criterion.
> 
> As for implementation, perhaps EXPORT_SYMBOL_INTERNAL could look like:
> 
> EXPORT_SYMBOL_INTERNAL(runqueue_lock, "scheduler");
> 
> and the corresponding module that implements a "scheduler" can claim its
> rights by:
> 
> MODULE_CLASS("scheduler");


I sort of get the impression that this is overdesign. Either you're a
"core subsystem" or a "external driver". I don't see much of a point
of protecting core subsystems from eachother; they are (assumed to be) part
of the upstream kernel source anyway so they are subject to peer review by
the subsystem maintainers... Since such core subsystems use very initimate
knowledge of "bzImage internals" I can even see the point in using a
rather strict "modversions like" system to make 100% sure that the
core subsystem modules and the base kernel match (random cookie that is
generated for each build and not available outside the build environment
??).
 
I say "external driver" even though the source can be in the
kernel tree; for this that doesn't make much of a difference,
most "drivers" don't need to know about core internal things and can
be compiled outside the tree already; they're in tree for convenience (and
for easing doing mass API changes etc etc etc).

Greetings,
   Arjan van de Ven
