Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266069AbSLITjV>; Mon, 9 Dec 2002 14:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266078AbSLITjV>; Mon, 9 Dec 2002 14:39:21 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:20998 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266069AbSLITjU>; Mon, 9 Dec 2002 14:39:20 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Intel P6 vs P7 system call performance
Date: 9 Dec 2002 11:46:47 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <at2rv7$fkr$1@cesium.transmeta.com>
References: <200212090830.gB98USW05593@flux.loup.net> <at2l1t$g5n$1@penguin.transmeta.com> <20021209193649.GC10316@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20021209193649.GC10316@suse.de>
By author:    Dave Jones <davej@codemonkey.org.uk>
In newsgroup: linux.dev.kernel
>
> On Mon, Dec 09, 2002 at 05:48:45PM +0000, Linus Torvalds wrote:
> 
>  > P4's really suck at system calls.  A 2.8GHz P4 does a simple system call
>  > a lot _slower_ than a 500MHz PIII. 
>  > 
>  > The P4 has problems with some other things too, but the "int + iret"
>  > instruction combination is absolutely the worst I've seen.  A 1.2GHz
>  > Athlon will be 5-10 times faster than the fastest P4 on system call
>  > overhead. 
> 
> Time to look into an alternative like SYSCALL perhaps ?
> 

SYSCALL is AMD.  SYSENTER is Intel, and is likely to be significantly
faster.  Unfortunately SYSENTER is also extremely braindamaged, in
that it destroys *both* the EIP and the ESP beyond recovery, and
because it's allowed in V86 and 16-bit modes (where it will cause
permanent data loss) which means that it needs to be able to be turned
off for things like DOSEMU and WINE to work correctly.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
