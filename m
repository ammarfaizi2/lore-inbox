Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280843AbRKBVYC>; Fri, 2 Nov 2001 16:24:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280841AbRKBVXw>; Fri, 2 Nov 2001 16:23:52 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19468 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280843AbRKBVXf>; Fri, 2 Nov 2001 16:23:35 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Google's mm problem - not reproduced on 2.4.13
Date: Fri, 2 Nov 2001 21:20:44 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9rv2nc$kgi$1@penguin.transmeta.com>
In-Reply-To: <E15yzlQ-00021P-00@starship.berlin> <20011102181758Z16039-4784+420@humbolt.nl.linux.org> <9ruvkd$jh1$1@penguin.transmeta.com> <3BE30B3D.1080505@google.com>
X-Trace: palladium.transmeta.com 1004736194 27011 127.0.0.1 (2 Nov 2001 21:23:14 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 2 Nov 2001 21:23:14 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3BE30B3D.1080505@google.com>, Ben Smith  <ben@google.com> wrote:
>
>For 2.2 we were have a patch that increases this to 90% or 60M, but we 
>don't use this patch on 2.4 yet.

Well, you'll also deadlock your machine if you happen to lock down the
lowmemory area on x86. Sounds like a _bad_ idea.

Anyway, I posted a suggested patch that should fix the behaviour, but it
doesn't fix the fundamental problem with locking the wrong kinds of
pages (ie you're definitely on your own if you happen to lock down most
of the low 1GB of an intel machine).

>Latency. We know exactly what data should remain in memory, so we're 
>trying to prevent the vm from paging out the wrong data. It makes a huge 
>difference in performance.

It would be interesting to hear whether that is equally true in the new
VM that doesn't necessarily page stuff out unless it can show that the
memory pressure is actually from VM mappings.

How big is your mlock area during real load? Still the "max the kernel
will allow"? Or is that just a benchmark/test kind of thing?

		Linus
