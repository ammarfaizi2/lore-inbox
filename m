Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129792AbRALS0n>; Fri, 12 Jan 2001 13:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129811AbRALS0e>; Fri, 12 Jan 2001 13:26:34 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:37680 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129792AbRALS0a>; Fri, 12 Jan 2001 13:26:30 -0500
Date: Fri, 12 Jan 2001 19:24:39 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Richard A Nelson <cowboy@vnet.ibm.com>,
        "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>,
        Andi Kleen <ak@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1-pre1 breaks XFree 4.0.2 and "w"
Message-ID: <20010112192439.U2766@athlon.random>
In-Reply-To: <20010112180556.J2766@athlon.random> <Pine.LNX.4.10.10101120931520.1806-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10101120931520.1806-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Jan 12, 2001 at 09:35:14AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2001 at 09:35:14AM -0800, Linus Torvalds wrote:
> 
> 
> On Fri, 12 Jan 2001, Andrea Arcangeli wrote:
> 
> > On Fri, Jan 12, 2001 at 11:42:32AM -0500, Richard A Nelson wrote:
> > > 
> > > Its fine either way on current x86 and many other platforms, but falls
> > > on its face in the presence of asymetric MP.
> > 
> > Point taken, feel free to have a can_I_use per-cpu instead of global but don't
> > overwrite the cpu_has with it. 
> 
> Andrea, the whole POINT of "cpu_has_xxx" is for the kernel to test for
> features like this.

I'm only concerned about the semantics of fxsr and xmm in /proc/cpuinfo, _not_
about the kernel implementation and self contained #defines (that
I'd preferred if they really meant cpu_has and not can_I_use too, but
that's an our internal thing not visible from userspace).

fxsr and xmm in /proc/cpuinfo in 2.4.0, 2.4.1-pre[12], and 2.2.* means
"cpu_has" and _not_ "can_I_use".

So anybody using the fxsr and xmm in the "flags" row of /proc/cpuinfo as the
"can_I_use" will break in any kernel before 2.4.1-pre3.

Anybody reading fxsr and xmm as "cpu_has" will break in any kernel after
2.4.1-pre2.

This all I meant when I said that 2.4.1-pre3 broke /proc/cpuinfo.

I'd prefer if /proc/cpuinfo wasn't broken. That's all.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
