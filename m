Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264570AbTI2T3D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 15:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264574AbTI2T3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 15:29:03 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:24337 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264570AbTI2T25
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 15:28:57 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Linux 2.6.0-test6
Date: 29 Sep 2003 19:19:30 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bla0k2$3bc$1@gatekeeper.tmr.com>
References: <Pine.LNX.4.44.0309281213240.4929-100000@callisto> <Pine.LNX.4.44.0309281035370.6307-100000@home.osdl.org>
X-Trace: gatekeeper.tmr.com 1064863170 3436 192.168.12.62 (29 Sep 2003 19:19:30 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.44.0309281035370.6307-100000@home.osdl.org>,
Linus Torvalds  <torvalds@osdl.org> wrote:

| Interesting. I'm pretty sure I did a "make allyesconfig" just before the
| test6 release, so apparently x86 includes it indirectly through some path, 
| and so it only shows up on m68k and arm?
| 
| This, btw, is a pretty common thing. I wonder what we could do to make 
| sure that different architectures wouldn't have so different include file 
| structures. It's happened _way_ too often.
| 
| Any ideas?

If CPU cycles are no object the include names and order can be picked
out of the preprocessor output, add "-E" to the gcc call, pick only the
lines starting with "1" and a header name, save in a text file. The
problem is that config option (including arch) change the output, so
it's only useful as a rough check.

It does run fast enough so that allyes, allno, and allmod configs take a
very short time, so it can be used for "find some of the problems."

Don't know if this is what you wanted, it does allow the comparison
between arch's. Oh, it also shows that some headers are used a lot more
than they need be, a few more ifdef's in the low level header files
could reduce filesystem thrashing during a build. Some folks have
machines which don't keep everything in memory :-(

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
