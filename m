Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265656AbSKAEa3>; Thu, 31 Oct 2002 23:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265654AbSKAEa2>; Thu, 31 Oct 2002 23:30:28 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60175 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265656AbSKAEa1>; Thu, 31 Oct 2002 23:30:27 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [BK][PATCH] Reiser4, will double Linux FS performance, pleaseapply
Date: Fri, 1 Nov 2002 04:36:12 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <apt0bs$3sg$1@penguin.transmeta.com>
References: <3DC19F61.5040007@namesys.com> <3DC1D63A.CCAD78EF@digeo.com> <3DC1D885.6030902@namesys.com> <3DC1D9D0.684326AC@digeo.com>
X-Trace: palladium.transmeta.com 1036125387 502 127.0.0.1 (1 Nov 2002 04:36:27 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 1 Nov 2002 04:36:27 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3DC1D9D0.684326AC@digeo.com>,
Andrew Morton  <akpm@digeo.com> wrote:
>
>But it should be done based on "feature equivalency".  By default,
>ext3 uses ordered data writes.  Data is written to disk before
>the metadata to which that data refers is committed to journal.

Andrew, that's not necessarily a _good_ feature. 

Journaling is _not_ a great idea.  There are other approaches to
handling atomicity than journaling, like phase trees, that give
equivalent atomicity guarantees without having to write out extra stuff,
or even impose a very strict ordering between data and meta-data.

I didn't read the reiser papers yet, but from Hans' description it
sounds like reiser4 gives all the guarantees ext3 does with ordered
writes, _and_ they get good performance. 

(In fact, from the description it sounds like it gives _more_ guarantees
than even ext3 with ordered writes, in that it gives transactional
behaviour for arbitrary writes. Maybe I should read the paper).

		Linus
