Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272818AbRI0NCp>; Thu, 27 Sep 2001 09:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272836AbRI0NCe>; Thu, 27 Sep 2001 09:02:34 -0400
Received: from chiara.elte.hu ([157.181.150.200]:32781 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S272818AbRI0NC1>;
	Thu, 27 Sep 2001 09:02:27 -0400
Date: Thu, 27 Sep 2001 15:00:31 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Bernd Harries <mlbha@gmx.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: __get_free_pages(): is the MEM really mine?
In-Reply-To: <30756.1001585204@www46.gmx.net>
Message-ID: <Pine.LNX.4.33.0109271454560.5435-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Sep 2001, Bernd Harries wrote:

> > have you perpahs freed that page?
>
> Yes, as expected.

well - what did you expect to happen? A freed page is going to be reused
for other purposes. A big 2MB allocation can be reused in part, once
memory usage grows. So you should not expect the device to be able to DMA
into a page that got freed, unpunished. Perhaps i'm misunderstanding the
problem.

> But I tend to conclude from getting the same phys address again after
> some time that noone else uses much memory inbetween. Plus, the first
> page of the area stays Zero all the time while the higher pages seem
> to be used by someone. [...]

the buddy allocator allocates top down. Plus, if you allocate a 2MB
physically continuous chunk then the likelyhood is high that there were
fragmented pages skipped during the initial search for a 2MB block - so
you still have a fair likelyhood to reallocate it after some time, if
memory usage is light. But this likelyhood nears zero once RAM usage gets
near 100%.

	Ingo

