Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbRCWEeE>; Thu, 22 Mar 2001 23:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129524AbRCWEdy>; Thu, 22 Mar 2001 23:33:54 -0500
Received: from mozart.stat.wisc.edu ([128.105.5.24]:22279 "EHLO
	mozart.stat.wisc.edu") by vger.kernel.org with ESMTP
	id <S129511AbRCWEdh> convert rfc822-to-8bit; Thu, 22 Mar 2001 23:33:37 -0500
To: Jakob Østergaard <jakob@unthought.net>,
        Linus Torvalds <torvalds@transmeta.com>
Cc: Serge Orlov <sorlov@con.mcst.ru>, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@redhat.com>
Subject: Re: Linux 2.4.2 fails to merge mmap areas, 700% slowdown.
In-Reply-To: <Pine.LNX.4.31.0103201042360.1990-100000@penguin.transmeta.com>
	<vba1yrr7w9v.fsf@mozart.stat.wisc.edu>
	<15032.1585.623431.370770@pizda.ninka.net>
	<vbay9ty50zi.fsf@mozart.stat.wisc.edu>
	<vbaelvp3bos.fsf@mozart.stat.wisc.edu>
	<20010322193549.D6690@unthought.net>
From: buhr@stat.wisc.edu (Kevin Buhr)
In-Reply-To: Jakob Østergaard's message of "Thu, 22 Mar 2001 19:35:49 +0100"
Date: 22 Mar 2001 22:32:51 -0600
Message-ID: <vbawv9hyuj0.fsf@mozart.stat.wisc.edu>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakob Østergaard <jakob@unthought.net> writes:
>
> Try compiling something like Qt/KDE/gtk-- which are really heavy on
> templates (with all the benefits and drawbacks of that).

Okay, I just compiled gtk-- 1.0.3 (with CFLAGS = "-O2 -g") under three
versions of GCC (Debian 2.95.3, RedHat 2.96, and a CVS pull of the
"gcc-3_0-branch") on the same Debian machine running kernel 2.4.2.

In all cases, the "cc1plus" processes appeared to max out around 25M
total size.  The "maps" pseudofiles for the 2.95.3 and and 3.0
compiles never grew past 250 lines, but the "maps" pseudofiles for the
RedHat 2.96 compile were gigantic, jumping to 3000 or 5000 lines at
times.

The results speak for themselves:

    CVS gcc 3.0:          Debian gcc 2.95.3:   RedHat gcc 2.96:
                      
    real    16m8.423s     real    8m2.417s     real    12m24.939s
    user    15m23.710s    user    7m22.200s    user    10m14.420s
    sys     0m48.730s     sys     0m41.040s    sys     2m13.910s 
maps:    <250 lines           <250 lines          >3000 lines

Obviously, the *real* problem is RedHat GCC 2.96.  If Linus bothers to
write this patch (he probably already has), its only proven benefit so
far is that it improves the performance of a RedHat-specific, orphaned
G++ development snapshot that everyone (the people of RedHat most of
all) will be glad to be rid of as soon as possible.

The numbers above suggest that the patch is unlikely to have a
positive impact on the performance of either officially released GCC
versions or the upcoming 3.0 release.

Drifting off topic...

> Mozilla uses C++ mainly as "extended C" - due to compatibility concerns.

This statement is potentially misleading.

I think most people will believe you to mean "using C++ as a better C"
in the sense of Stroustrup: using the small, conventional-language
subset of C++ that looks like C but has stronger type checking,
function and operator overloading, default arguments, "//" style
comments, reference types, and other syntactic and semantic sugar.

Mozilla does not use C++ as "extended C" in this sense.  While it does
use a *subset* of C++ for compatibility reasons, the subset includes
extensive use of class lattices and polymorphism as well as extensive
(albeit simple and carefully constructed) uses of templates for its
utility classes, including string and component-autoreferencing
template classes and functions that are used throughout the source.
The only major C++ facilities that are not used are the standard
library, RTTI, namespaces, and exception handling, but other than that
it's a good, real-world C++ test case.

Kevin <buhr@stat.wisc.edu>
