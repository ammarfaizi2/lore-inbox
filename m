Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288987AbSAZCSh>; Fri, 25 Jan 2002 21:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288990AbSAZCRL>; Fri, 25 Jan 2002 21:17:11 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:22789 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S288987AbSAZCQn>; Fri, 25 Jan 2002 21:16:43 -0500
Message-ID: <3C521003.991A690B@zip.com.au>
Date: Fri, 25 Jan 2002 18:10:12 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] syscall latency improvement #1
In-Reply-To: <p73y9il7vlr.fsf@oldwotan.suse.de> <Pine.LNX.4.33.0201251741430.16917-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> It should be eminently testable. Just remove the cli from the standard
> kernel, and do before-and-after tests.
> 

#include <unistd.h>

main()
{
        int i = 100 * 1000 * 1000;

        while (i--)
                getpid();
}

With cli:
	./a.out  22.05s user 15.31s system 99% cpu 37.361 total

without cli: 
	./a.out  18.29s user 17.42s system 99% cpu 35.731 total


That's 4.6%.  Intel P3.

It's also 306 cycles per iteration.  So the cli added 14 cycles.

-
