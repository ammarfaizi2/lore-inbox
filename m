Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281814AbRKQT7F>; Sat, 17 Nov 2001 14:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281815AbRKQT6z>; Sat, 17 Nov 2001 14:58:55 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45325 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281814AbRKQT6u>; Sat, 17 Nov 2001 14:58:50 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: i386 flags register clober in inline assembly
Date: 17 Nov 2001 11:58:25 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9t6fh1$len$1@cesium.transmeta.com>
In-Reply-To: <87y9l58pb5.fsf@fadata.bg> <200111171920.fAHJKjJ01550@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200111171920.fAHJKjJ01550@penguin.transmeta.com>
By author:    Linus Torvalds <torvalds@transmeta.com>
In newsgroup: linux.dev.kernel
>
> In article <20011117161436.B23331@atrey.karlin.mff.cuni.cz> you write:
> >
> >They don't need to be. On i386, the flags are (partly for historical reasons) clobbered
> >by default.
> 
> However, this is one area where I would just be tickled pink if gcc were
> to allow asm's to return status in eflags, even if that means that we
> need to fix all our existing asms.
> 
> We have some really _horrid_ code where we use operations that
> intrinsically set the flag bits, and we actually want to use them.
> Using things like cmpxchg, and atomic decrement-and-test-with-zero have
> these horrid asm statements that have to move the eflags value (usually
> just one bit) into a register, so that we can tell gcc where it is.
> 

The clean way to do that would be for gcc to implement _Bool, the C99
boolean data type, and add a new kind of register for the flags, i.e.

_Bool c;

asm volatile(LOCK "subl %2,%0"
    : "=m" (v->counter), "=zf" (c)
    : "ir" (i), "0" (v->counter) : "memory", "cc");

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
