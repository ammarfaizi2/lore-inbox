Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135689AbREDBw0>; Thu, 3 May 2001 21:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135723AbREDBwR>; Thu, 3 May 2001 21:52:17 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:42502 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S135689AbREDBv6>;
	Thu, 3 May 2001 21:51:58 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200105040151.f441pUw113980@saturn.cs.uml.edu>
Subject: Re: iso9660 endianness cleanup patch
To: pavel@suse.cz (Pavel Machek)
Date: Thu, 3 May 2001 21:51:30 -0400 (EDT)
Cc: hpa@transmeta.com (H. Peter Anvin),
        torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        Andries.Brouwer@cwi.nl (Andries Brouwer),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <20010501202139.B32@(none)> from "Pavel Machek" at May 01, 2001 08:21:40 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek writes:

> It  should ot break anything. gcc decides its bad to inline it, so it
> does not inline it. Small code growth at worst. Compiler has right to
> make your code bigger or slower, if it decides to do so.

Oh come on. The logical way:

inline          Compiler must inline (only!) or report an error.
extern inline   This is a contradiction. Report an error.
static inline   This is a contradiction. Report an error.

Anything else is obvious crap. It isn't OK for the compiler
to ever ignore me; inline recursive functions are just wrong.
Taking the address of an inline function is just wrong too.

Of course the above is not what we are given. We get crap.
The old gcc behavior was crap, and I guess the C99 behavior
is too. So the only sane thing is a #define that is set to
whatever makes the compiler behave as nicely as possible.
Then we use _INLINE everywhere, and get decent behavior out
of both old and new compilers.



