Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267803AbTCFFXg>; Thu, 6 Mar 2003 00:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267806AbTCFFXg>; Thu, 6 Mar 2003 00:23:36 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34823 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267803AbTCFFXe>; Thu, 6 Mar 2003 00:23:34 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Better CLONE_SETTLS support for Hammer
Date: 5 Mar 2003 21:33:44 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b46mjo$2lt$1@cesium.transmeta.com>
References: <3E664836.7040405@redhat.com> <20030305190622.GA5400@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030305190622.GA5400@wotan.suse.de>
By author:    Andi Kleen <ak@suse.de>
In newsgroup: linux.dev.kernel
> > 
> > But as it turns out the kernel already has support for handling %fs in a
> > different way, to support prctl(ARCH_SET_FS).  So let's just use the
> > same mechanism.  clone() will simply take an 64-bit address and use it
> > as if prctl() was called.
> 
> The problem is that the context switch is much more expensive with
> that (wrmsr is quite expensive compared to the memcpy or index
> reload). The kernel optimizes it away when not needed, but with
> glibc using them for everything all processes will switch slower.
> 

This is almost certainly the biggest brainfuck in the x86-64
architecture.  It should have been supported to set the segment
registers via "movq rm64,%fs|gs" (i.e. REX64 MOV sr,r/m64).  Barring
that, it would have been better if *all* setting of the segment
registers from userspace had been completely outlawed, so the kernel
at least could have tracked the usage.  The combination is in so many
ways worse than ever.

IMNSHO we should assume in the ABI that this will be fixed at some
point, and therefore we shouldn't work too hard to create kluges that
are based on warts in the first x86-64 generation (K8) only, that
later can't be fixed.

There is plenty of reason to believe the x86-64 architecture will be
around for a long time to come.  It is more important to create sane
ABIs than it is for those ABIs to be microoptimized to the first
generation of x86-64 processors.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
