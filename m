Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280785AbRKGHV3>; Wed, 7 Nov 2001 02:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280786AbRKGHVT>; Wed, 7 Nov 2001 02:21:19 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:56589 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S280785AbRKGHVD>;
	Wed, 7 Nov 2001 02:21:03 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200111070720.fA77KZB486967@saturn.cs.uml.edu>
Subject: Re: PROPOSAL: /proc standards (was dot-proc interface [was: /proc
To: linux-kernel@alex.org.uk
Date: Wed, 7 Nov 2001 02:20:35 -0500 (EST)
Cc: viro@math.psu.edu (Alexander Viro), jfbeam@bluetopia.net (Ricky Beam),
        roy@karlsbakk.net (Roy Sigurd Karlsbakk),
        linux-kernel@vger.kernel.org (Linux Kernel Mail List)
In-Reply-To: <812030885.1005093219@[195.224.237.69]> from "Alex Bligh - linux-kernel" at Nov 07, 2001 12:33:40 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Bligh - linux writes:

> What amuses me about those arguing for binary structures as a long term
> solution for communicating, on a flexible but long lived basis, is that the
> entire OS Genre they appear to be advocating (UNIX et al.) has been doing
> this, on an app to app (as opposed to kernel to app) basis, for far longer
> than most of them can remember, in situations where performance is far more
> relevant, and pitted against far more 3l33t 5tud3nt2 than we we shake a
> stick at, but /still/ they persist.

quotas, process accounting, wtmp, utmp, Tux web server logs...

> Through minor local idiocy, I had trashed my local lilo partition,
> and had to try and boot with a Debian CD-Rom with a 2.2 kernel. I
> forgot to ask for single user more. Not only did it boot first time,
> it booted fully, apart from two minor things: no iptables, and
> (shock horror) the sound card didn't work it wasn't compatible.
> Similarly, I've loaded 2.4 kernels with no problems onto 2.2 systems.
>
> This "dreadful" /proc interface everyone talks about has been
> *STAGGERINGLY GOOD* in terms of forward and backward compatibility.
...
> has worked well just because kernel developers and maintainers
> have showed themselves unwilling to break existing userspace
> tools, and vice versa.

I can see that you are unfamiliar with the /proc filesystem.

You can change kernels because app developers work hard to
be tolerant of stupid /proc changes. Some of the crap that
I've stumbled across, mostly while doing procps work:

/proc/*/stat signal info was changed from decimal to hex for
a while. I changed it back, but too late: the evil hex had
already leaked out into the world, and I had to modify libproc.
Quick, is 16785472 in decimal or hex? So use the "friendly" new
/proc/*/status file instead, but...

The "SigCgt" in /proc/*/status wasn't always spelled that way.
It wasn't always in the same location either, so what to do?
That calls for another hack: assume signal values follow each other.

Kernel threads don't have memory info. Somebody added "kB" on the
end of most lines in /proc/meminfo. /proc/stat has changed in ways
that I'm glad to have forgotten. /proc/interrupts has been through
a flood of horrid changes: the PIC type going from "" to "XT PIC"
to "XT-PIC", the last column getting spaces (consider "XT PIC"!),
a new header (just waiting for extra info) and a variable number
of per-CPU columns in the middle to replace what was once a total.
Maybe /proc/cpuinfo is the worst... I hear SPARC is pretty smelly,
but hey, every arch screws app developers in some unique way.

