Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292938AbSB0VdR>; Wed, 27 Feb 2002 16:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292934AbSB0Vck>; Wed, 27 Feb 2002 16:32:40 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:54026 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S292959AbSB0VcI>; Wed, 27 Feb 2002 16:32:08 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [Lse-tech] lockmeter results comparing 2.4.17, 2.5.3, and 2.5.5
Date: Wed, 27 Feb 2002 21:31:17 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <a5jj75$cuk$1@penguin.transmeta.com>
In-Reply-To: <3C7D374B.4621F9BA@zip.com.au> <3C7D374B.4621F9BA@zip.com.au> <86760000.1014840118@flay> <3C7D3E5A.490D939D@zip.com.au>
X-Trace: palladium.transmeta.com 1014845492 13122 127.0.0.1 (27 Feb 2002 21:31:32 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 27 Feb 2002 21:31:32 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3C7D3E5A.490D939D@zip.com.au>,
Andrew Morton  <akpm@zip.com.au> wrote:
>"Martin J. Bligh" wrote:
>> 
>> Seeing as people seem to be interested ... there are some big holders
>> of BKL around too - do_exit shows up badly (50ms in the data Hanna
>> posted, and I've seen that a lot before).
>
>That'll be where exit() takes down the tasks's address spaces.  
>zap_page_range().  That's a nasty one.

No, lock_kernel happens after exit_mm, and in fact I suspect it's not
really needed at all any more except for the current "sem_exit()". I
think most everything else is threaded already.

(Hmm.. Maybe disassociate_ctty() too).

So minimizing the BLK footprint in do_exit() should be pretty much
trivial: all the really interesting stuff should be ok already.

		Linus
