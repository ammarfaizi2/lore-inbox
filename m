Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272938AbRIHBvb>; Fri, 7 Sep 2001 21:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272939AbRIHBvV>; Fri, 7 Sep 2001 21:51:21 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14348 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S272938AbRIHBvK>; Fri, 7 Sep 2001 21:51:10 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Buddy allocator - help! I thought I understood this
Date: Sat, 8 Sep 2001 01:47:15 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9nbtb3$o6i$1@penguin.transmeta.com>
In-Reply-To: <525190103.999719280@[10.132.112.53]>
X-Trace: palladium.transmeta.com 999913871 26747 127.0.0.1 (8 Sep 2001 01:51:11 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 8 Sep 2001 01:51:11 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <525190103.999719280@[10.132.112.53]>,
Alex Bligh - linux-kernel  <linux-kernel@alex.org.uk> wrote:
>I could swear I understood this bit of __free_pages_ok()
>Monday night, but my mind appears to have gone blank.
>
>As I recall, the memory bitmaps indicate by the
>status a bit op returns whether or not a page
>is on the free list for that particular order
>area.

No. It actually indicates that the _buddy_ of the page is on the free
list for that particular order.

Basically each bit describes two pages of the order in question, which
is sufficient because while they have four states (both free, first
free, second free, neither free), we get the "other bit" of information
from the fact that we are just freeing one page - which obviously cannot
have been free before.

Thus the games with xor'ing the bit around, and looking at the old
state.

And no, most kernel programmers don't have to actually follow that piece
of code. Ugly but efficient.

		Linus
