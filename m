Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262089AbSLBKLY>; Mon, 2 Dec 2002 05:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262314AbSLBKLV>; Mon, 2 Dec 2002 05:11:21 -0500
Received: from pizda.ninka.net ([216.101.162.242]:61376 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262089AbSLBKLT>;
	Mon, 2 Dec 2002 05:11:19 -0500
Date: Mon, 02 Dec 2002 02:16:29 -0800 (PST)
Message-Id: <20021202.021629.93360250.davem@redhat.com>
To: ak@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Start of compat32.h (again)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021202090756.GA26034@wotan.suse.de>
References: <p737kesu9bt.fsf@oldwotan.suse.de>
	<20021202.002815.58826951.davem@redhat.com>
	<20021202090756.GA26034@wotan.suse.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@suse.de>
   Date: Mon, 2 Dec 2002 10:07:56 +0100
   
   > BTW, I bet your dynamic relocation tables are a bit larger too.
   
   Somewhat, but does it matter?  They are not kept in memory anyways.

It's all about how much data a ld.so relocation has to touch.  But
preloading will help out here, even though that isn't in wide spread
use just yet.

And I was talking about user stack usage, not the kernel kind
:-)

Andi, do something very simple like run -m32 vs -m64 microbenchmarks,
I bet -m32 beats -m64 in all the lmbench lat_proc tests.  On sparc64
it's (on a 2-way SMP system):

-m32 fork+exit:		360.8328 microseconds
-m32 fork+execve:	1342.2213 microseconds
-m32 fork+/bin/sh:	5497.0149 microseconds

-m64 fork+exit:		553.9076 microseconds
-m64 fork+execve:	1904.6315 microseconds
-m64 fork+/bin/sh:	6268.6932 microseconds

NOTE: make sure you change /bin/sh to be 32-bit/64-bit as
      appropriate in the tests above.

So what is this on x86_64? :-) I think lat_proc is great becuase it
shows pure libc overhead in continually relocating the exit()
etc. symbols in the child for fork+exit, for example.

The reason I'm making such a stink about this is that I don't want
people believing that "the code generation improvements due to the
extra x86_64 registers available nullifies the bloat cost from
going to 64-bit"

To me, believe that is an utterly bogus claim and completely
misleading.
