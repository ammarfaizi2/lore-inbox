Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316113AbSFJUU3>; Mon, 10 Jun 2002 16:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316158AbSFJUU2>; Mon, 10 Jun 2002 16:20:28 -0400
Received: from loewe.cosy.sbg.ac.at ([141.201.2.12]:2255 "EHLO
	loewe.cosy.sbg.ac.at") by vger.kernel.org with ESMTP
	id <S316113AbSFJUTo>; Mon, 10 Jun 2002 16:19:44 -0400
Date: Mon, 10 Jun 2002 22:18:21 +0200 (MET DST)
From: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
To: Tom Rini <trini@kernel.crashing.org>
cc: Andrew Morton <akpm@zip.com.au>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 kill warnings 4/19
In-Reply-To: <20020610200552.GM14252@opus.bloom.county>
Message-ID: <Pine.GSO.4.05.10206102214140.17299-100000@mausmaki.cosy.sbg.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--snip/snip
> > to kill the 3.x warning?
> 
> Well, the warning (at least from what I've seen) is when you do:
> "In " __FUNCTION__ " something bad happened\n", which __func__ just
> won't do.  Doing:
> "In %s something bad happened\n", __FUNCTION__
> Is OK[1].

from gcc3/Function-Names:
--------------
Note that these semantics are deprecated, and that GCC 3.2 will handle __FUNCTION__ and __PRETTY_FUNCTION__ the same way as __func__. 

__func__ is defined by the ISO standard C99:

The identifier __func__ is implicitly declared by the translator
as if, immediately following the opening brace of each function
definition, the declaration

static const char __func__[] = "function-name";

appeared, where function-name is the name of the lexically-enclosing
function.  This name is the unadorned name of the function.

By this definition, __func__ is a variable, not a string literal. In particular, __func__ does not catenate with other string literals. 
--------------

which means, __FUNCTION__ will still be supported (gcc3.2), you just cannot
catenate it as it was the case before.

so Toms snipplet above should be ok for all versions of gcc which are
recommended today, and will also work with gcc3.2

	tm

-- 
in some way i do, and in some way i don't.

