Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268011AbTCFLmR>; Thu, 6 Mar 2003 06:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268012AbTCFLmR>; Thu, 6 Mar 2003 06:42:17 -0500
Received: from ns.suse.de ([213.95.15.193]:47377 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S268011AbTCFLmQ>;
	Thu, 6 Mar 2003 06:42:16 -0500
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] work around gcc-3.x inlining bugs
References: <20030306032208.03f1b5e2.akpm@digeo.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 06 Mar 2003 12:52:48 +0100
In-Reply-To: Andrew Morton's message of "6 Mar 2003 12:27:25 +0100"
Message-ID: <p73fzq067an.fsf@amdsimf.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> writes:

> This patch:
[...]

I submitted a similar patch (using -include) it to Linus some time ago.
It's even required to work around gcc 3.3 inlining bugs.
Unfortunately he didn't like it and prefered __force_inline
to be added to the places that really rely on inline.

I experimented with -finline-limit=<huge number> to get it to obey inline, 
but that doesn't fully work. The only way to get it to work in 3.2 and 3.3 
is to specify various long and weird --param arguments. In 3.0 the only
way is to change the values in the compiler source and recompile.

So doing it with always_inline is much less ugly and also less compiler
version dependent.

I always add them currently by hand to linux/brlock.h to get 2.5
to compile with gcc 3.3 on x86-64.

I think it is the right thing to do. In kernel land when we say inline
we mean inline. Don't expect the compiler to second guess that,
especially since it doesn't seem to be very good at that.

There was also talk on the gcc mailing list to add an
-fobey-inline switch, but nothing got out of it.  And it would be 3.3+
only anwyays.

I didn't see a 64K shrink however on x86-64, but I guess that's
because it has a much cleaner uaccess.h ;) For i386 it is a nice bonus.

-Andi

