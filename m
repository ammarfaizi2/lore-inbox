Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261971AbULHAiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261971AbULHAiy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 19:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbULHAis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 19:38:48 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:36226 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S261966AbULHAhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 19:37:43 -0500
Date: Wed, 8 Dec 2004 01:37:36 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au
Subject: Re: Time sliced CFQ io scheduler
Message-ID: <20041208003736.GD16322@dualathlon.random>
References: <20041202130457.GC10458@suse.de> <20041202134801.GE10458@suse.de> <20041202114836.6b2e8d3f.akpm@osdl.org> <20041202195232.GA26695@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041202195232.GA26695@suse.de>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2004 at 08:52:36PM +0100, Jens Axboe wrote:
> with its default io scheduler has basically zero write performance in

IMHO the default io scheduler should be changed to cfq. as is all but
general purpose so it's a mistake to leave it the default (plus as Jens
found the write bandwidth is not existent during reads, no surprise it
falls apart in any database load). We had to make the cfq the default
for the enterprise release already. The first thing I do is to add
elevator=cfq on a new install. I really like how well cfq has been
designed, implemented and turned, Jens's results with his last patch are
quite impressive.

BTW, a bit of historic that may be funny to read (and I believe nobody
on l-k knows about it): the first sfq I/O elevator idea (sfq is the
ancestor of cfq, cfq still fallbacks in sfq mode in the unlikely case
that no atomic memory is available during I/O) started at an openmosix
conference in Bologna, when I was listening to one guy fixing the
latency of some videogame app migrating from server to server with
openmosix. So they could use a few boxes clustered to host some hundred
videogames servers migrating depending the the load (I recall they said
the users tend to move from one game to the other all at the same time).
I never heard of sfq before, but when I understood how it worked for the
packet scheduler and how they were using it to fix a latency issue in
the responsiveness of their game while the server was migrating, I
immediatly got the idea I could use the very same sfq algorightm for the
disk elevator too (at that time it was being used only in the networking
qdisc packet scheduler). I wasn't really sure at first if it would work
equally well for disk too (network pays nothing for seeks). But
conceptually it did worth mentioning the idea to Jens so he could
evaluate it (I think he was already working on something similar but I
hope I did provide him with some useful hint). You know the rest, he
quickly turned it into a cfq and did numerous improvements. The funny
thing I meant to say, is that if I didn't incidentally listen to the
videogame talk (a talk I'd normally avoid) we wouldn't have cfq today in
the I/O scheduler in its current great status (of course we could have
it since Jens was already working on something similar, but perhaps it
would be at least a bit in the past compared to his current great
development). 

Even a videogame server may turn out to be very useful ;). I'm quite
sure the developer doing the videogame openmosix speech doesn't know his
speech had an impact on the kernel I/O scheduler ;). Hope he reads this
email.
