Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130368AbRAAU3v>; Mon, 1 Jan 2001 15:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130663AbRAAU3l>; Mon, 1 Jan 2001 15:29:41 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:41476 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130368AbRAAU33>; Mon, 1 Jan 2001 15:29:29 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: test13-pre5
Date: 1 Jan 2001 11:58:39 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <92qnhf$va2$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.10.10012281459150.995-100000@penguin.transmeta.com> <Pine.LNX.4.10.10012301422310.581-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.10.10012301422310.581-100000@cassiopeia.home>
By author:    Geert Uytterhoeven <geert@linux-m68k.org>
In newsgroup: linux.dev.kernel
> 
> What about defining new types for this? Like e.g. `x8', being `u8' on platforms
> were that's OK, and `u32' on platforms where that's more efficient?
> 

You may just want to look at how C99 handles this using <stdint.h>;
stdint.h defines types of the following format:

	 int, uint		... signed/unsigned

	 <size>			... exact size
	 _least<size>		... no smaller than
	 _fast<size>		... no smaller than, and efficient

	 _t

E.g. uint32_t, int_least64_t, uint_fast8_t (the latter could easily be
a 32-bit type, for eaxmple.)

In addition, constructor macros are defined, as well as (u)intmax_t
and (u)intptr_t; which are defined as the largest
possible integer and an integer large enough to hold a (void *),
respectively.

In other words:

	(void *)(uintptr_t)(void *)foo == (void *)foo

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
