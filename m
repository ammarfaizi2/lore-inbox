Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291776AbSBHTvQ>; Fri, 8 Feb 2002 14:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291775AbSBHTvG>; Fri, 8 Feb 2002 14:51:06 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:31251 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S291776AbSBHTuy>; Fri, 8 Feb 2002 14:50:54 -0500
Date: Fri, 8 Feb 2002 13:36:27 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Alexander Viro <viro@math.psu.edu>, Andrew Morton <akpm@zip.com.au>,
        Martin Wirth <Martin.Wirth@dlr.de>, Robert Love <rml@tech9.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        haveblue <haveblue@us.ibm.com>
Subject: Re: [RFC] New locking primitive for 2.5
In-Reply-To: <Pine.LNX.4.33.0202082221500.17064-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0202081328060.1095-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Feb 2002, Ingo Molnar wrote:
>
> and regarding the reintroduction of BKL, *please* do not just use a global
> locks around such pieces of code, lock bouncing sucks on SMP, even if
> there is no overhead.

I'd suggest not having a lock at all, but instead add two functions: one
to read a 64-bit value atomically, the other to write it atomically (and
they'd be atomic only wrt each other, no memory barriers etc implied).

On 64-bit architectures that's just a direct dereference, and even on x86
it's just a "cmpxchg8b".

		Linus

