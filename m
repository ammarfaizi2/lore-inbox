Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262435AbSJAVEf>; Tue, 1 Oct 2002 17:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262505AbSJAVEe>; Tue, 1 Oct 2002 17:04:34 -0400
Received: from trained-monkey.org ([209.217.122.11]:54028 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP
	id <S262436AbSJAVEA>; Tue, 1 Oct 2002 17:04:00 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Workqueue Abstraction, 2.5.40-H7
References: <Pine.LNX.4.44.0210012219460.21087-100000@localhost.localdomain>
From: Jes Sorensen <jes@wildopensource.com>
Date: 01 Oct 2002 17:09:25 -0400
In-Reply-To: Ingo Molnar's message of "Tue, 1 Oct 2002 22:29:02 +0200 (CEST)"
Message-ID: <m3bs6dn9x6.fsf@trained-monkey.org>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Ingo" == Ingo Molnar <mingo@elte.hu> writes:

Ingo> but, at the danger of getting into another religious discussion.

I don't want to get into flame land, but I think there's a couple of
important points.

Ingo> Despite all the previous fuss about the problems of typedefs,
Ingo> i've never had *any* problem with using typedefs in various code
Ingo> i wrote. It only ever made things cleaner - to me. I had no
Ingo> problems with supposed declaration limitations of typedefs or
Ingo> anything either. I in fact consider it a feature that an unclean
Ingo> hiearchy of include files cannot be plastered with typedef
Ingo> predeclarations.

The point here is that it probably makes the code easier for you to
read, but it makes it harder for a lot of other people since it's
inconsistent with the standard. When analyzing someone else's code and
having to go through a pile of typedef's to figure whether you are
dealing with structs or just renamed integer types is a major and
unnecessary pain.

Ingo> what issue remains is purely the compactness and effectivity of
Ingo> the source code representation. It confuses the human eye (at
Ingo> least mine) to see 'struct ' all over again. (In fact 'unsigned
Ingo> int' is confusing as well, so i tend to use 'int' wherever
Ingo> possible safely.)

I guess thats a matter of taste, when I write code I want to know what
I deal with. Same reason I find C++'s operator overloading to be
absolutely sickening.

Ingo> I think writing out stuff makes sense only as long as it carries
Ingo> real, important and unique information that triggers the proper
Ingo> association in the human brain, without using up too much
Ingo> cognitive power (which is needed for other stuff like writing
Ingo> code).

I will claim here that the fact something is a struct is very
important information. When someone else is to use the type, it's
important they know the actual cost of writing thigs like *a = *b. I
have seen this done way too many times, not just in C.

[snip]

Ingo> Sure, we need to know what the type is, but more so do we need
Ingo> to know *which* specific type it is.

foo_t doesn't tell you anything there either, foo_list_t says a bit
more, but still nothing about the actual cost of copying the type
around.

Ingo> i've done a quick experiment, every .h and .c file from the
Ingo> 2.5.40 kernel in a single file:

Ingo>  -rw-rw-r-- 1 mingo mingo 133851995 Oct 1 21:55 all-struct.c

Ingo> and the same file, but this time all 165636 occurances of
Ingo> 'struct ' replaced with '_t':

Ingo>  -rw-rw-r-- 1 mingo mingo 132819955 Oct 1 21:57 all-t.c

I haven't done this experient on the whole kernel, but from what I
have seen from many drivers, then you are going to gain a lot more by
replacing all whitespate indentations with tabs. In certain extreme cases
I have seen it reduce file siszes by more than 10%.

Ingo> if we have to go with the 'struct' convention then rather
Ingo> 'struct work' and 'struct workqueue' and 'struct
Ingo> cpu_workqueue'. (neither of them collides with any other symbol
Ingo> in the existing namespace.)

This would be a useful thing to clean up, or we should start naming
things foo_int as well ;-)

Ingo> but, i'm trying to argue about taste, which is admittedly not an
Ingo> exact science. :)

Yup, we agree on that, however I think a key issue here is that having
a common standard benefits a lot in terms of maintainability when we
have a multi developer project like this.

Anyway, just my $0.02.

Cheers,
Jes
