Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279847AbRJ3EN7>; Mon, 29 Oct 2001 23:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279852AbRJ3ENj>; Mon, 29 Oct 2001 23:13:39 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:41230 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S279847AbRJ3ENa>; Mon, 29 Oct 2001 23:13:30 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: i/o stalls on 2.4.14-pre3 with ext3
Date: Tue, 30 Oct 2001 04:12:00 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9rl9ag$7su$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.21.0110292120340.16895-100000@admin> <3BDE161A.D8289730@zip.com.au>
X-Trace: palladium.transmeta.com 1004415240 20760 127.0.0.1 (30 Oct 2001 04:14:00 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 30 Oct 2001 04:14:00 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3BDE161A.D8289730@zip.com.au>,
Andrew Morton  <akpm@zip.com.au> wrote:
>
>ext3's problem is that it is unable to react to VM pressure 
>for metadata (buffercache) pages.  Once upon a time it did
>do this, but we backed it out because it involved mauling
>core kernel code.  So at present we only react to VM pressure
>for data pages.

Note that the new VM has some support in place for the low-level
filesystem reacting to VM pressure. In particular, one thing the fs can
do is to look at the PG_launder bit (for pages) and PG_launder bit (for
buffers), to figure out if the IO is due to memory pressure.

A "sync" will not have the launder bit set, while something started due
to VM pressure will have the bits set.

>Then again, maybe something got broken in the buffer writeout
>code or something.

There are two really silly request bugs in 2.4.14-pre3. I'd suggest
trying pre5 which cleans up other things too, but even more notably
should fix the request queue thinkos.

		Linus
