Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261653AbTCKWyP>; Tue, 11 Mar 2003 17:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261656AbTCKWyP>; Tue, 11 Mar 2003 17:54:15 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:49164 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261653AbTCKWyN>; Tue, 11 Mar 2003 17:54:13 -0500
Date: Tue, 11 Mar 2003 15:02:31 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@digeo.com>
cc: george anzinger <george@mvista.com>, <felipe_alfaro@linuxmail.org>,
       <cobra@compuserve.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Runaway cron task on 2.5.63/4 bk?
In-Reply-To: <20030311144448.4d9ee416.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0303111458390.1709-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Mar 2003, Andrew Morton wrote:
> 
> gcc will generate 64bit * 64bit multiplies without resorting to
> any library code

However, gcc is unable to do-the-right-thing and generate 32x32->64 
multiplies, or 32x64->64 multiplies, even though those are both a _lot_ 
faster than the full 64x64->64 case.

And in quite a _lot_ of cases, that's actually what you want. It might 
actually make sense to add a "do_mul()" thing to allow architectures to do 
these cases right, since gcc doesn't.

> and you can probably do the division with do_div().

Yes. This is the same issue - gcc will always promote a 64-bit divide to
be _fully_ 64-bit, even if the mixed-size 64/32 -> [64,32] case is much
faster and simpler. Which is why do_div() exists in the first place.

		Linus

