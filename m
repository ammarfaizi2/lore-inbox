Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280829AbRKBUbB>; Fri, 2 Nov 2001 15:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280826AbRKBUav>; Fri, 2 Nov 2001 15:30:51 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27146 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280822AbRKBUaj>; Fri, 2 Nov 2001 15:30:39 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Google's mm problem - not reproduced on 2.4.13
Date: Fri, 2 Nov 2001 20:27:57 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9ruvkd$jh1$1@penguin.transmeta.com>
In-Reply-To: <E15yzlQ-00021P-00@starship.berlin> <15330.56589.291830.542215@abasin.nj.nec.com> <20011102190046.B6003@athlon.random> <20011102181758Z16039-4784+420@humbolt.nl.linux.org>
X-Trace: palladium.transmeta.com 1004733026 25483 127.0.0.1 (2 Nov 2001 20:30:26 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 2 Nov 2001 20:30:26 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011102181758Z16039-4784+420@humbolt.nl.linux.org>,
Daniel Phillips  <phillips@bonn-fries.net> wrote:
>
>It's hard to see how that could be wrong.  Plus, this test program does run 
>under 2.4.9, it just uses way too much CPU on that kernel.  So I'd say mm 
>bug.

So how much memory is mlocked?

The locked memory will stay in the inactive list (it won't even ever be
activated, because we don't bother even scanning the mapped locked
regions), and the inactive list fills up with pages that are completely
worthless. 

And the kernel will decide that because most of the unfreeable pages are
mapped, it needs to do VM scanning, which obviously doesn't help.

Why _does_ this thing do mlock, anyway? What's the point? And how much
does it try to lock?

If root wants to shoot himself in the head by mlocking all of memory,
that's not a VM problem, that's a stupid administrator problem.

		Linus
