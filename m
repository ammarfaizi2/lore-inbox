Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272378AbRHYBPw>; Fri, 24 Aug 2001 21:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272379AbRHYBPm>; Fri, 24 Aug 2001 21:15:42 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:23804 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S272378AbRHYBP2>;
	Fri, 24 Aug 2001 21:15:28 -0400
Date: Fri, 24 Aug 2001 21:15:43 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Brad Chapman <kakadu_croc@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <20010825005302.34876.qmail@web10901.mail.yahoo.com>
Message-ID: <Pine.GSO.4.21.0108242055410.19796-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 24 Aug 2001, Brad Chapman wrote:

> 	OK. The existing API is wrong and the new min()/max() macros are the
> right way to properly compare values. However, we could always add a config 
> option to enable a compatibility macro, which would use typeof() on one of the 
> two variables and then call the real min()/max(). Something like this (just an
> example):
> 
> #ifdef CONFIG_ALLOW_COMPAT_MINMAX
> #define proper_min(t, a, b)	((t)(a) < (t)(b) ? (a) : (b))
> #define proper_max(t, a, b)	((t)(a) > (t)(b) ? (a) : (b))
> #define min(a, b)		proper_min(typeof(a), a, b)
> #define max(a, b)		proper_max(typeof(a), a, b)

_THAT_ _IS_ _WRONG_.  Who the fuck said that we always want type of _first_
argument?  Mind you, IMNSHO Dave had been on a seriously bad trip when he
had added that "type" argument - separate names would be cleaner.  And yes,
it'd be better in prepatch instead of 2.4.9-final.

However, no matter which variant you pick, old code with min/max
was broken.  Unless you are carefully giving right types (preferanly -
with casts) it works only by accidents (if it works at all).

"Compatibility option" is exactly the worst thing in such cases.
It's either changing the whole codebase or not bothering at all.

