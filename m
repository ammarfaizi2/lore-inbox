Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269646AbRH0W7c>; Mon, 27 Aug 2001 18:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269693AbRH0W7W>; Mon, 27 Aug 2001 18:59:22 -0400
Received: from juicer02.bigpond.com ([139.134.6.78]:29169 "EHLO
	mailin5.bigpond.com") by vger.kernel.org with ESMTP
	id <S269646AbRH0W7R>; Mon, 27 Aug 2001 18:59:17 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war 
In-Reply-To: Your message of "Fri, 24 Aug 2001 21:15:43 EDT."
             <Pine.GSO.4.21.0108242055410.19796-100000@weyl.math.psu.edu> 
Date: Mon, 27 Aug 2001 10:02:40 +1000
Message-Id: <E15b9rU-0002vE-00@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.GSO.4.21.0108242055410.19796-100000@weyl.math.psu.edu> you wri
te:
> _THAT_ _IS_ _WRONG_.  Who the fuck said that we always want type of _first_
> argument?  Mind you, IMNSHO Dave had been on a seriously bad trip when he
> had added that "type" argument - separate names would be cleaner.  And yes,
> it'd be better in prepatch instead of 2.4.9-final.

We're going in circles.  Linus requested that the explicit type arg be
added.

IIUC Dave's original patch (and I just want to say that Dave is my
hero for pushing this) looked vaguely like the existing code in
include/linux/netfilter.h.  He's mentioned it before but noone
bothered to read it, so I'll quote for you:

/* From arch/i386/kernel/smp.c:
 *
 *	Why isn't this somewhere standard ??
 *
 * Maybe because this procedure is horribly buggy, and does
 * not deserve to live.  Think about signedness issues for five
 * seconds to see why.		- Linus
 */

/* Two signed, return a signed. */
#define SMAX(a,b) ((ssize_t)(a)>(ssize_t)(b) ? (ssize_t)(a) : (ssize_t)(b))
#define SMIN(a,b) ((ssize_t)(a)<(ssize_t)(b) ? (ssize_t)(a) : (ssize_t)(b))

/* Two unsigned, return an unsigned. */
#define UMAX(a,b) ((size_t)(a)>(size_t)(b) ? (size_t)(a) : (size_t)(b))
#define UMIN(a,b) ((size_t)(a)<(size_t)(b) ? (size_t)(a) : (size_t)(b))

/* Two unsigned, return a signed. */
#define SUMAX(a,b) ((size_t)(a)>(size_t)(b) ? (ssize_t)(a) : (ssize_t)(b))
#define SUMIN(a,b) ((size_t)(a)<(size_t)(b) ? (ssize_t)(a) : (ssize_t)(b))

Cheers,
Rusty.
--
Premature optmztion is rt of all evl. --DK
