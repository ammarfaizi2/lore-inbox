Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268867AbRHYLWD>; Sat, 25 Aug 2001 07:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268861AbRHYLVy>; Sat, 25 Aug 2001 07:21:54 -0400
Received: from web10903.mail.yahoo.com ([216.136.131.39]:38930 "HELO
	web10903.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S268702AbRHYLVn>; Sat, 25 Aug 2001 07:21:43 -0400
Message-ID: <20010825112159.45074.qmail@web10903.mail.yahoo.com>
Date: Sat, 25 Aug 2001 04:21:59 -0700 (PDT)
From: Brad Chapman <kakadu_croc@yahoo.com>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0108242055410.19796-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Alexander Viro <viro@math.psu.edu> wrote:
> 
> 
> On Fri, 24 Aug 2001, Brad Chapman wrote:
> 
> > 	OK. The existing API is wrong and the new min()/max() macros are the
> > right way to properly compare values. However, we could always add a config 
> > option to enable a compatibility macro, which would use typeof() on one of the 
> > two variables and then call the real min()/max(). Something like this (just an
> > example):
> > 
> > #ifdef CONFIG_ALLOW_COMPAT_MINMAX
> > #define proper_min(t, a, b)	((t)(a) < (t)(b) ? (a) : (b))
> > #define proper_max(t, a, b)	((t)(a) > (t)(b) ? (a) : (b))
> > #define min(a, b)		proper_min(typeof(a), a, b)
> > #define max(a, b)		proper_max(typeof(a), a, b)
> 
> _THAT_ _IS_ _WRONG_.  Who the fuck said that we always want type of _first_
> argument?  Mind you, IMNSHO Dave had been on a seriously bad trip when he
> had added that "type" argument - separate names would be cleaner.  And yes,
> it'd be better in prepatch instead of 2.4.9-final.

	I never said we had to use the _first_ argument. We could always do
the _second_. Or we could scrap the whole idea of compatibility with any of the old,
"broken" type-unsafe code and make everybody use the new macros. Period.

> 
> However, no matter which variant you pick, old code with min/max
> was broken.  Unless you are carefully giving right types (preferanly -
> with casts) it works only by accidents (if it works at all).
> 
> "Compatibility option" is exactly the worst thing in such cases.
> It's either changing the whole codebase or not bothering at all.
>

	Ack. Seems like the best way to fix this is to either make everybody
use the new macros, or wait for Linus to show up ;-)

Brad 


=====
Brad Chapman

Permanent e-mail: kakadu_croc@yahoo.com
Current e-mail: kakadu@adelphia.net
Alternate e-mail: kakadu@netscape.net

__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
