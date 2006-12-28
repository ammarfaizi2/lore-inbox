Return-Path: <linux-kernel-owner+w=401wt.eu-S932936AbWL1KRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932936AbWL1KRS (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 05:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932979AbWL1KRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 05:17:18 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:37371 "EHLO
	sorrow.cyrius.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932936AbWL1KRR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 05:17:17 -0500
Date: Thu, 28 Dec 2006 11:16:59 +0100
From: Martin Michlmayr <tbm@cyrius.com>
To: Gordon Farquharson <gordonfarquharson@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>, David Miller <davem@davemloft.net>,
       ranma@tdiedrich.de, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       andrei.popa@i-neo.ro, Andrew Morton <akpm@osdl.org>, hugh@veritas.com,
       nickpiggin@yahoo.com.au, arjan@infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one
Message-ID: <20061228101659.GB14626@deprecation.cyrius.com>
References: <20061226.205518.63739038.davem@davemloft.net> <Pine.LNX.4.64.0612271601430.4473@woody.osdl.org> <Pine.LNX.4.64.0612271636540.4473@woody.osdl.org> <20061227.165246.112622837.davem@davemloft.net> <Pine.LNX.4.64.0612271835410.4473@woody.osdl.org> <97a0a9ac0612272032uf5358c4qf12bf183f97309a6@mail.gmail.com> <Pine.LNX.4.64.0612272039411.4473@woody.osdl.org> <97a0a9ac0612272115g4cce1f08n3c3c8498a6076bd5@mail.gmail.com> <Pine.LNX.4.64.0612272120180.4473@woody.osdl.org> <97a0a9ac0612272138o5348488ahfde03f9e22a71b5d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97a0a9ac0612272138o5348488ahfde03f9e22a71b5d@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Gordon Farquharson <gordonfarquharson@gmail.com> [2006-12-27 22:38]:
> >> #define TARGETSIZE (100 << 12)
> >
> >That's just 400kB!
> >
> >There's no way you should see corruption with that kind of value. It
> >should all stay solidly in the cache.
> >
> >Is this perhaps with ARM nommu or something else strange? It may be that
> >the program just doesn't work at all if mmap() is faked out with a malloc
> >or similar.
> 
> Definitely a question for the ARM gurus. I'm out of my depth.

By the way, I just tried it with TARGETSIZE (100 << 12) on a different
ARM machine (a Thecus N2100 based on an IOP32x chip with 128 MB of
memory) and I see similar results to that from Gordon:

Writing chunk 279/280 (99%)
Chunk 256 corrupted (1-1455)  (1025-2479)
Expected 0, got 1
Written as (199)43(184)
Chunk 258 corrupted (1-1455)  (3945-1303)
Expected 2, got 3
Written as (184)74(145)
Chunk 260 corrupted (1-1455)  (2769-127)
Expected 4, got 5
Written as (145)89(237)
Chunk 262 corrupted (1-1455)  (1593-3047)
Expected 6, got 7
Written as (237)168(174)
Chunk 264 corrupted (1-1455)  (417-1871)
Expected 8, got 9
Written as (174)135(161)
Chunk 266 corrupted (1-1455)  (3337-695)
Expected 10, got 11
Written as (161)123(180)
Chunk 268 corrupted (1-1455)  (2161-3615)
Expected 12, got 13
Written as (180)13(19)
Chunk 270 corrupted (1-1455)  (985-2439)
Expected 14, got 15
Written as (19)172(106)
Chunk 272 corrupted (1-1455)  (3905-1263)
Expected 16, got 17
Written as (106)212(140)
Chunk 274 corrupted (1-1455)  (2729-87)
Expected 18, got 19
Written as (140)124(73)
Chunk 276 corrupted (1-1455)  (1553-3007)
Expected 20, got 21
Written as (73)151(52)
Chunk 278 corrupted (1-1455)  (377-1831)
Expected 22, got 23
Written as (52)215(99)
Checking chunk 279/280 (99%)

-- 
Martin Michlmayr
http://www.cyrius.com/
