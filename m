Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317750AbSGVSBh>; Mon, 22 Jul 2002 14:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317751AbSGVSBh>; Mon, 22 Jul 2002 14:01:37 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:54028 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317750AbSGVSBf>; Mon, 22 Jul 2002 14:01:35 -0400
Date: Mon, 22 Jul 2002 11:05:10 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Robert Love <rml@tech9.net>
cc: Andrew Morton <akpm@zip.com.au>, <riel@conectiva.com.br>,
       <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH] low-latency zap_page_range
In-Reply-To: <1027360686.932.33.camel@sinai>
Message-ID: <Pine.LNX.4.44.0207221103430.2928-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 22 Jul 2002, Robert Love wrote:
>
> Sure.  What do you think of this?

How about adding an "cond_resched_lock()" primitive?

You can do it better as a primitive than as the written-out thing (the
spin_unlock() doesn't need to conditionally test the scheduling point
again, it can just unconditionally call schedule())

And there might be other places that want to drop a lock before scheduling
anyway.

		Linus

