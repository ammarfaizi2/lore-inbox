Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbTIMTvy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 15:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbTIMTvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 15:51:54 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:52360 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262169AbTIMTvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 15:51:53 -0400
Date: Sat, 13 Sep 2003 21:51:38 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: Ricardo Bugalho <ricardo.b@zmail.pt>, insecure@mail.od.ua,
       linux-kernel@vger.kernel.org
Subject: Re: nasm over gas?
Message-ID: <20030913195138.GA8890@wohnheim.fh-wedel.de>
References: <20030904104245.GA1823@leto2.endorphin.org> <200309100034.58742.insecure@mail.od.ua> <pan.2003.09.11.11.06.59.523742@zmail.pt> <200309121826.22936.insecure@mail.od.ua> <1063387648.15891.26.camel@ezquiel.nara.homeip.net> <20030912221717.GB11952@wohnheim.fh-wedel.de> <20030913192539.GE7404@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030913192539.GE7404@mail.jlokier.co.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 September 2003 20:25:39 +0100, Jamie Lokier wrote:
> Jörn Engel wrote:
> > - Why has Alan measured faster kernels with -Os than with -O2?
> > 
> > Code size *does* matter.
> 
> That's not just i-cache pressure.  It is partly a GCC problem, and
> it's possible -Os would run faster than -O2 even with no i-cache.
> 
> I've observed -Os emitting exactly the same code as -O2 for some
> trivial functions, except that -O2 has a few extra redundant
> instructions.
> 
> Obvious the _intent_ of -O2 is to compile for speed, but it's clear
> that GCC often emits trivially redundant instructions (like stack
> adjustments) that don't serve to speed up the program at all.

I haven't collected too many numbers, but the few I did collect show
-O2 code actually being faster than -Os, as long as you stay in
userspace and the code is small and loopy.  It may get worse for large
run-once code, but I don't have numbers for that.

My explanation for Alans results is that nature of kernel code.
Usually, kernel code execution takes only a fraction of the cpu time,
so the user code run in between effectively flushes the cache.  Each
system call causes near 100% cache misses, so smaller code is almost
always faster.

So even if your observations were wrong and gcc would create perfect
code for both -O2 and -Os, I wouldn't expect -O2 to be faster for
kernel code.

Jörn

-- 
More computing sins are committed in the name of efficiency (without
necessarily achieving it) than for any other single reason - including
blind stupidity.
-- W. A. Wulf 
