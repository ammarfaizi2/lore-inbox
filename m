Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265275AbTLZX41 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 18:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265276AbTLZX40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 18:56:26 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:57768 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265275AbTLZX4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 18:56:25 -0500
Subject: Re: Page aging broken in 2.6
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Rik van Riel <riel@surriel.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0312260957100.14874@home.osdl.org>
References: <1072423739.15458.62.camel@gaston>
	 <Pine.LNX.4.58.0312260957100.14874@home.osdl.org>
Content-Type: text/plain
Message-Id: <1072482941.15458.90.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 27 Dec 2003 10:55:42 +1100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Yeah, all hail bad MMU's.

Bad MMUs or our architetured beeing tied to one MMU type ? :)

(Note that I'm no special fan of our PPC hash table, it seems
to be fairly bad with the cache).

Note also that the need for a flush isn't tied to that fact we
have a hash table but to how we use it in linux. If we used the
real HW A and D bits and had ptep_test_and_clear* actually walk
the hash and use them, we could avoid the flush the same way in
this case.

But we do not, we use the hash as a big TLB cache and consider
any page in there as accessed and any writeable page in there as
diry, so clearing those bits requires evicting from the hash
(hash misses, at least on ppc32, are fairly cheap though).

> Hash tables may need some kind of "not very urgent TLB flush" thing, so 
> that it doesn't penalize sane architectures.

Or do what I propose here, that is have ptep_test_and_clear_* be
responsible for the flush on archs where it is necessary, but then
it would be nice to have more than the ptep as an argument...

Ben.


