Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263623AbUC3MPx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 07:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263624AbUC3MPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 07:15:53 -0500
Received: from chaos.analogic.com ([204.178.40.224]:7811 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263623AbUC3MPv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 07:15:51 -0500
Date: Tue, 30 Mar 2004 07:16:52 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: DervishD <raul@pleyades.net>
cc: Lev Lvovsky <lists1@sonous.com>, linux-kernel@vger.kernel.org
Subject: Re: older kernels + new glibc?
In-Reply-To: <20040329222710.GA8204@DervishD>
Message-ID: <Pine.LNX.4.53.0403300706500.5144@chaos>
References: <5516F046-81C1-11D8-A0A8-000A959DCC8C@sonous.com>
 <Pine.LNX.4.53.0403291602340.2893@chaos> <20040329222710.GA8204@DervishD>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2004, DervishD wrote:

>     Hi Richard :)
>
>  * Richard B. Johnson <root@chaos.analogic.com> dixit:
> > For glibc compatibility you need to get rid of the sym-link(s)
> > /usr/include/asm and /usr/include/linux in older distributions.
> > You need to replace those with headers copied from the kernel
> > in use when the C runtime library was compiled. If you can't find
> > those, you can either upgrade your C runtime library, or copy
> > headers from some older kernel that was known to work.
> > In any event, you need to remove the sym-link that ends up
> > pointing to your 'latest and greatest' kernel.
>
>     Mmm, I'm confused. As far as I knew, you *should* use symlinks to
> your current (running) kernel includes for /usr/include/asm and
> /usr/include/linux. I've been doing this for years (in fact I
> compiled my libc back in the 2.2 days IIRC), without problems. Why it
> should be avoided and what kind of problems may arise if someone
> (like me) has those symlinks?
>

The libc headers end up including kernel headers via the sym-links.
They must *only* use the headers with which libc was built. Therefore,
any sym-links should be removed and replaced with a copy of the
appropriate headers.


>     User space programs should not use kernel headers, so this
> shouldn't be a problem, and kernel related tools should use the
> headers from the current (running) kernel or a similar version (here
> 'similar' as a broad meaning, I think, let's say that it means 'same
> series as the running kernel, but newer), but I'm afraid I'm missing
> something...
>
>     Thanks in advance :)

Again, the C-library was built to work with certain structures
(for instance) that existed at the time it was built. Let's say
I use /usr/include/sys/stat.h to get the structure members of
'struct stat'. If I use the headers that existed at the time the
C library was built, all is fine. If I use the kernel headers
that exist now, the offsets may be incorrect because there have
may have been members added to that structure.

This comes about because the C library used kernel headers,
which it shouldn't have done in the first place.

FYI, you __never__ include C library headers when building
any kernel modules.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


