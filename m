Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266688AbRHFE2a>; Mon, 6 Aug 2001 00:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266706AbRHFE2V>; Mon, 6 Aug 2001 00:28:21 -0400
Received: from [63.209.4.196] ([63.209.4.196]:21252 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266688AbRHFE2C>; Mon, 6 Aug 2001 00:28:02 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: /proc/<n>/maps getting _VERY_ long
Date: Mon, 6 Aug 2001 04:26:50 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9kl6aa$87l$1@penguin.transmeta.com>
In-Reply-To: <20010805171202.A20716@weta.f00f.org> <20010805204143.A18899@alcove.wittsend.com> <9kkq9k$829$1@penguin.transmeta.com> <9kkr7r$mov$1@cesium.transmeta.com>
X-Trace: palladium.transmeta.com 997072062 31404 127.0.0.1 (6 Aug 2001 04:27:42 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 6 Aug 2001 04:27:42 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <9kkr7r$mov$1@cesium.transmeta.com>,
H. Peter Anvin <hpa@zytor.com> wrote:
>
>Do you count applications which selectively mprotect()'s memory (to
>trap SIGSEGV and maintain coherency with on-disk data structures) as
>"broken applications"?
>
>Such applications *can* use large amounts of mprotect()'s.

Note that such applications tend to not get any advantage from merging -
it does in fact only slow things down (because then the next mprotect
just has to split the thing again).

No, they aren't broken, but they should know that the use of lots of
small memory segments (even if it is a design goal) can and will slow
down page faulting, and use more memory for MM management for example. 

Linux does have a log(n) vma lookup, so the slowdown isn't huge.

		Linus

