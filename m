Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265773AbUIEBIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265773AbUIEBIp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 21:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265161AbUIEBIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 21:08:45 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:15789 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265773AbUIEBFu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 21:05:50 -0400
Date: Sat, 4 Sep 2004 18:05:48 -0700
From: Paul Jackson <pj@sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: ak@muc.de, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix argument checking in sched_setaffinity
Message-Id: <20040904180548.2dcdd488.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.58.0409041717230.4735@ppc970.osdl.org>
References: <m3zn4bidlx.fsf@averell.firstfloor.org>
	<20040831183655.58d784a3.pj@sgi.com>
	<20040904133701.GE33964@muc.de>
	<20040904171417.67649169.pj@sgi.com>
	<Pine.LNX.4.58.0409041717230.4735@ppc970.osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus wrote:
> It's not. If anything, we should probably remove even more.
>
> I don't see what the problem was with just requiring the right damn size.  
> User mode can trivially get the size by asking for it

I'll second that motion.  Match size, or return -EINVAL.

My understanding of "asking for it" requires at present a user code
loop, to probe for the size that works.  But my user code already does
that, and the first thing for which I audit any changes to this kernel
code is not breaking my sizing loop code in user space.

I'd mildly prefer adding a kernel/user API for explicitly providing the
two values:

	sizeof(cpumask_t)
	sizeof(nodemask_t)

This might help reduce the unending confusions in the user and library
code sitting on top of us.

We could two phase this:
 1) add an obvious way to size these masks, and then
 2) six months later, require sizes to match in all these calls.

I for one could live with a full and sudden change over, no phasing.
But apparently my field exposure is more limited than Andi's is, at
this time.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
