Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263710AbUC3PO1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 10:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263713AbUC3PO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 10:14:26 -0500
Received: from chaos.analogic.com ([204.178.40.224]:31363 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263710AbUC3POE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 10:14:04 -0500
Date: Tue, 30 Mar 2004 10:15:55 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: DervishD <raul@pleyades.net>
cc: Matthew Reppert <repp0017@tc.umn.edu>, Lev Lvovsky <lists1@sonous.com>,
       linux-kernel@vger.kernel.org
Subject: Re: older kernels + new glibc?
In-Reply-To: <20040330145013.GD8304@DervishD>
Message-ID: <Pine.LNX.4.53.0403301001090.6371@chaos>
References: <5516F046-81C1-11D8-A0A8-000A959DCC8C@sonous.com>
 <Pine.LNX.4.53.0403291602340.2893@chaos> <20040329222710.GA8204@DervishD>
 <1080604519.32741.8.camel@minerva> <20040330145013.GD8304@DervishD>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2004, DervishD wrote:

>     Hi Matthew :)
>
>  * Matthew Reppert <repp0017@tc.umn.edu> dixit:
> > >     Mmm, I'm confused. As far as I knew, you *should* use symlinks to
> > > your current (running) kernel includes for /usr/include/asm and
> > > /usr/include/linux. I've been doing this for years (in fact I
> > > compiled my libc back in the 2.2 days IIRC), without problems. Why it
> > > should be avoided and what kind of problems may arise if someone
> > > (like me) has those symlinks?
> > See http://www.kernelnewbies.org/faq/index.php3#headers
>
>     Thanks a lot for the information, it's been quite useful :)))
>
>     I find the explanation extremely sensible, but the problem I see
> is that some user-space tools that are very coupled with the kernel
> (for example, hdparm) assume that the kernel headers can be accessed
> throuhg a system standard include directory (like /usr/include). What
> I mean is that all these tools just #include <linux/whatever.h>,
> without making assumptions about where are they.
>

If you have any user-mode 'kernel' utilities, you need to be
extremely careful because you can build code that doesn't work.

That's why you should use an 'include' search path on the
compiler command line when you are compiling these. The search
path should point to the kernel headers of the version you
intend to use. The kernel tries to remain compatible, but
when you access internal structures, compatibility may be lost.

>     If I've understood correctly, these tools (like hdparm) should
> *not* use current (running) kernel headers, but those that were in
> use when glibc was built, am I right? Which, BTW, is a big problem
> because I don't have the slightest idea about which kernel was in use
> when I built my glibc.
>

Yes. One can usually 'trust' a distribution and use whatever they
shipped.

>     But putting under /usr/include/linux and /usr/include/asm the
> headers in use when glibc is built can lead to a problem, too.
> Imagine that at some point in the future, the contents of the asm or
> linux dirs depends on which facilities the kernel has configured
> e.g. no scsi.h if no scsi support is present in the configured
> kernel. That way, you don't have scsi.h under your
> /usr/include/linux, but you may need it if you add an SCSI card with
> your running kernel and want to compile some 'scsiutils' or whatever
> like that.
>

No. User-mode programs must never, never, never, ever include
kernel headers directly. Instead, if they are for kernel utilities,
the include search-path must be explicitly set.

>     I confess that this is a very weird scenario, very difficult to
> appear but... Just wondering.
>
> > The correct place, I've read, to get the headers for the current running
> > kernel is /lib/modules/$(uname -r)/build/include
>

This is one of the newer places that's been defined. It's probably
worthless because it's just another sim-link! And, it's a sim-link
to some kernel source that probably doesn't exist anymore. You
need to explicitly define where you want the include-search-path
to include when you compile kernel-specific things. In other words,
when compiling things that interface with the kernel or with
kernel internals, there is no free lunch. You need to know exactly
what you are doing.

>     Please correct me if I'm wrong: only external kernel modules
> should use current (running, again) kernel headers, no?
>

Kernel modules must use the headers for the kernel version you
wish to run. That is not necessarily the kernel that is running
now. That's why you need to define the search-path for the
'include' files.

> > Basically, the potential problem as I understand it is binary
> > incompatibility with the currently installed glibc.
>

Yes. You need to keep user-space and kernel space seperate.

>     That has never happened to me, but reading Linus' explanation,
> that can bite me in the future (if some interface I use in userspace
> changes in the kernel).
>

Correct.

>     Raúl Núñez de Arenas Coronado
>
> --
> Linux Registered User 88736
> http://www.pleyades.net & http://raul.pleyades.net/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


