Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262956AbUEPD64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262956AbUEPD64 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 23:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbUEPD64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 23:58:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:50098 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262956AbUEPD6z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 23:58:55 -0400
Date: Sat, 15 May 2004 20:58:49 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Steven Cole <elenstev@mesatop.com>, adi@bitmover.com, scole@lanl.gov,
       support@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s &&
 s->tree' failed: The saga continues.)
In-Reply-To: <20040515202054.32bf06d5.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0405152050350.10718@ppc970.osdl.org>
References: <200405132232.01484.elenstev@mesatop.com>
 <5.1.0.14.2.20040515130250.00b84ff8@171.71.163.14> <20040514204153.0d747933.akpm@osdl.org>
 <200405151923.41353.elenstev@mesatop.com> <20040515202054.32bf06d5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 15 May 2004, Andrew Morton wrote:
> 
> Two hours so far here.
> 
> bix:/usr/src> ~/clone.sh 
> 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 
> 
> That's 2.6.6-mm2+, 2GB 4-way x86.

I think Steven's machine (according to an earlier 'dmesg') has something 
like 384MB of RAM and just one PIII-450 CPU.

With that setup, he's likely getting a lot of IO (and possibly even
swapping). The BK disk working set for the kernel archive is something
like half a gig per tree, I think.

In contrast, your nicer machine will do the whole stress-test basically
totally cached (well, BK will force writeback with fsync, but it will all
be pretty synchronous with nothing else going on).

So if it's IO-related or happens when swapping...

But again, neither of those should usually cause that kind of strange 
partial-page corruption. 

		Linus
