Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280384AbRJaSYm>; Wed, 31 Oct 2001 13:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280385AbRJaSYc>; Wed, 31 Oct 2001 13:24:32 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:38670 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280384AbRJaSY0>; Wed, 31 Oct 2001 13:24:26 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: new OOM heuristic failure  (was: Re: VM: qsbench)
Date: Wed, 31 Oct 2001 18:22:41 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9rpfhh$vs8$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0110310744070.32330-100000@penguin.transmeta.com> <Pine.LNX.4.33L.0110311403440.2963-100000@imladris.surriel.com> <20011031184256.6e541e43.skraw@ithnet.com>
X-Trace: palladium.transmeta.com 1004552693 13874 127.0.0.1 (31 Oct 2001 18:24:53 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 31 Oct 2001 18:24:53 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011031184256.6e541e43.skraw@ithnet.com>,
Stephan von Krawczynski  <skraw@ithnet.com> wrote:
>
>I took a deep look into this code and wonder how this benchmark manages to get
>killed. If I read that right this would imply that shrink_cache has run a
>hundred times through the _complete_ inactive_list finding no free-able pages,
>with one exception that I read across:

That's a red herring. The real reason it is killed is that the machine
really _is_ out of memory, but that, in turn, is because the swap space
is totally filled up - with pages we have in memory in the swap cache.

The swap cache is wonderful for many thing, but Linux has historically
had swap as "additional" memory, and the swap cache really really wants
to have backing store for the _whole_ working set, not just for the
pages we have to get rid of.

Thus the two-line patch elsewhere in this thread, which says "ok, if
we're low on swap space, let's start decimating the swap cache entries
for stuff we have in memory". 

		Linus
