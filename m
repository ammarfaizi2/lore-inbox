Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289834AbSA2T27>; Tue, 29 Jan 2002 14:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289836AbSA2T2s>; Tue, 29 Jan 2002 14:28:48 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12806 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289834AbSA2T2i>; Tue, 29 Jan 2002 14:28:38 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
Date: Tue, 29 Jan 2002 19:27:43 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <a36t3f$oh8$1@penguin.transmeta.com>
In-Reply-To: <20020129165444.A26626@caldera.de>
X-Trace: palladium.transmeta.com 1012332495 25022 127.0.0.1 (29 Jan 2002 19:28:15 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 29 Jan 2002 19:28:15 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020129165444.A26626@caldera.de>,
Christoph Hellwig  <hch@caldera.de> wrote:
>I've ported my hacked up version of Momchil Velikov's radix tree
>radix tree pagecache to 2.5.3-pre{5,6}.
>
>The changes over the 2.4.17 version are:
>
>  o use mempool to avoid OOM situation involving radix nodes.
>  o remove add_to_page_cache_locked, it was unused in the 2.4.17 patch.
>  o unify add_to_page and add_to_page_unique
>
>It gives nice scalability improvements on big machines and drops the
>memory usage on small ones (if you consider my 64MB Athlon small :)).

Looks good. 

In fact, this looks a _lot_ more palatable than the "scalable page
cache" approach with the hashed locks.

Can you post the numbers on scalability (I can see the locking
improvement, but if you have numbers I'd be even happier) and any
benchmarks you have?

The only real complaint I have is that I'd rather see "radix_root" than
"rat_root". Maybe it is just me, but the latter makes me wonder about
the sex-lives of small furry mammals. Which is not what I really want to
be thinking about.

It looks straigthforward enough, so if you feel it is stable (and
cleaned up), I'd suggest just submitting it for real.

		Linus
