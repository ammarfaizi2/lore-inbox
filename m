Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267222AbSKPFoj>; Sat, 16 Nov 2002 00:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267223AbSKPFoi>; Sat, 16 Nov 2002 00:44:38 -0500
Received: from dp.samba.org ([66.70.73.150]:19845 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267222AbSKPFoh>;
	Sat, 16 Nov 2002 00:44:37 -0500
Date: Sat, 16 Nov 2002 16:47:55 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Richard Henderson <rth@twiddle.net>
Cc: linux-kernel@vger.kernel.org, paulus@samba.org
Subject: Re: in-kernel linking issues
Message-Id: <20021116164755.59575f21.rusty@rustcorp.com.au>
In-Reply-To: <20021114143701.A30355@twiddle.net>
References: <20021114143701.A30355@twiddle.net>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Nov 2002 14:37:01 -0800
Richard Henderson <rth@twiddle.net> wrote:

> So you said you had a userland test harness?

Yes, which is fine for testing basic relocs, but misses some subtle issues.
[ Sorry for the delayed reply, I only got this mail via kernel.org: did you
  get a bounce from rusty@rustcorp.com.au? ]

> Some problems I've seen browsing the code:

Thanks for this.  It adds even more weight to your ET_DYN argument as well.
I'll need to play with that linker script some more (on PPC, binfmt_misc.o
is 13000 bytes, binfmt_misc.so becomes 156128 bytes 8)

There's still the issue of PPC and PPC64 which can only jump 24-bits away,
and so currently insert trampolines which have to be allocated with the
module, but that should be no uglier than currently.  (They could use a
special allocator, too, but with only 16M, they have to ensure noone else
uses those addresses).

PPC64 also frobs the TOC ptr (r2) in the trampolines: I don't have a
ppc64 box in front of me, but I imagine -shared will do the right thing
there too.

Thanks!
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
