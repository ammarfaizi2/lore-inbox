Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315439AbSGMUNW>; Sat, 13 Jul 2002 16:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315420AbSGMUNV>; Sat, 13 Jul 2002 16:13:21 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:43790 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S315430AbSGMUNQ>;
	Sat, 13 Jul 2002 16:13:16 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200207132015.g6DKFsH103416@saturn.cs.uml.edu>
Subject: Re: What is supposed to replace clock_t?
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sat, 13 Jul 2002 16:15:54 -0400 (EDT)
Cc: tim@physik3.uni-rostock.de (Tim Schmielau),
       linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <Pine.LNX.4.44.0207131103410.16670-100000@home.transmeta.com> from "Linus Torvalds" at Jul 13, 2002 11:15:28 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> The only sane interface is a seconds-based one, either like /proc/uptime
> (ie ASCII floating point representation) or a mixed integer representation
> like timeval/timespec where you have seconds and micro/nanoseconds
> separately.

Anything wrong with 64-bit nanoseconds? It's easy to work with,
being an integer type, and it survives the year 2038.

> That's something we should strive for, but I also think we should avoid
> using the clock_t format at all, and give alternate representations (for
> example, leave the broken clock_t representation in /proc/<pid>/stat
> alone, and just add a _sane_ seconds-based thing in the much more readable
> and parseable /proc/<pid>/status file.

Other than the parentheses issue, /proc/<pid>/stat can
be handled with sscanf. Nobody dinks with the format.

People "correct" the spelling and formatting in the
fancy /proc files. Is it "SigCgt" or "SigCat"? That
depends on the kernel version; somebody "fixed" the
spelling.

There isn't any BNF for any /proc file. The raw files
are easy to handle, but one can only guess at what
others will assume about the format of a fancy one.

Take /proc/cpuinfo for example. Long ago, it was like
this:

foo   some value
bar   1 2 3 4 5
baz   8000:0

Then it turned into this:

foo   : some value
bar   : 1 2 3 4 5
baz   : 8000:0
uh oh : 69

Who could have guessed?

Stuff broke. Formatted files are too damn tempting
to muck with. People don't touch the ugly files.

