Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290445AbSBFLaQ>; Wed, 6 Feb 2002 06:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290433AbSBFLaG>; Wed, 6 Feb 2002 06:30:06 -0500
Received: from Morgoth.esiway.net ([193.194.16.157]:58122 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S290445AbSBFL35>; Wed, 6 Feb 2002 06:29:57 -0500
Date: Wed, 6 Feb 2002 12:29:54 +0100 (CET)
From: Marco Colombo <marco@esi.it>
To: Andries.Brouwer@cwi.nl
cc: hpa@zytor.com, <linux-kernel@vger.kernel.org>
Subject: Re: How to check the kernel compile options ?
In-Reply-To: <UTC200202052356.g15Nu1w00794.aeb@apps.cwi.nl>
Message-ID: <Pine.LNX.4.44.0202061158180.1381-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Feb 2002 Andries.Brouwer@cwi.nl wrote:

>     > I would be surprised if there is anyone on this list
>     > who has not lost at some point either the .config, the
>     > ksyms, or something similar associated with at least
>     > one build they've made.
> 
>     Sure.  And people have lost their root filesystems due to "rm -rf /".
>     That doesn't mean we build the entire (real) root filesystem into
>     the kernel.
> 
> 	-hpa
> 
> Peter, in my eyes this is an unreasonable answer.
> 
> For debugging and other purposes it is good to have some
> information. One may wish to know about a certain kernel image
> what Linux kernel version that was, with what patches, compiled
> with what options, by which compiler. Or one may want to know
> such things about the currently running kernel. Even user-space
> programs (like mount) may want to know (what NFS version? do we
> have CONFIG_JOLIET?).

No, applications already can (should) recover from a "missing feature"
error, after executing some syscall. Even if your .config says you've
compile the scsi tape driver into the running kernel, it doesn't mean
there is a scsi tape attached somewhere. And if your kernel is modular,
how can an application tell if some module is avalable? .config may
say that feature was compliled as a module, but has no knowledge of the
binary module being accessible or not.

> Today we supply a little of this information.
> For example, /proc/version supplies information on version
> and compiler and date. Why? One might as well keep this compiler
> info in a separate file. What a waste of unswappable kernel memory!

You have a point here, IMHO.

$ cat /proc/version
Linux version 2.4.9-21 (bhcompile@stripples.devel.redhat.com) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)) #1 Thu Jan 17 13:35:37 EST 2002

email addresses, compiler versions, distro release strings, build dates,
all belongs to the same place of .config.  And all are retrievable 
performing rpm -qi. And overall less useful than .config.

Uh, but wait, that's RH bloat... B-)

> You see - this is not a matter of absolutes.
> In the good old days, when an operating system had to fit in 4k
> and a device driver in 128 words, putting a 100-char text like
> the one found in /proc/version into the system would be ridiculous.
> Today nobody worries about a hundred bytes paid for some useful info.
> 
> So, the question is: how useful is the information, and how expensive
> is it to store it. Consider the config options. How much space do they
> take? Typically 1-5 kB (compressed). If this is stored at the end of
> a kernel image file, and not loaded into memory, then the kernel memory
> cost is zero. If this is made part of the kernel itself, say accessible
> via /proc, then the cost is 1-5 kB.

No, the question is why you need to bury this info into the kernel.
The information *is* available, unless you delete it (or forget to save
it, or use the wrong tool to install the kernel, and so on).

> So, you should ponder whether it is worthwhile to pay this cost of zero,
> and ponder whether it is worthwhile to pay this cost of 5 kB.

To gain what? To recover it if someone deletes 
/lib/modules/`uname -r`/config.gz (or /boot/config-`uname -r`.gz)?

> Andries

.TM.

