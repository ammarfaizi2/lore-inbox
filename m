Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262557AbSI0R3q>; Fri, 27 Sep 2002 13:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262558AbSI0R3q>; Fri, 27 Sep 2002 13:29:46 -0400
Received: from mx2.elte.hu ([157.181.151.9]:35244 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S262557AbSI0R3k>;
	Fri, 27 Sep 2002 13:29:40 -0400
Date: Fri, 27 Sep 2002 19:44:08 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@zip.com.au>, Rusty Russell <rusty@rustcorp.com.au>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 'virtual => physical page mapping cache', vcache-2.5.38-B8
In-Reply-To: <Pine.LNX.4.44.0209271921481.15791-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0209271939090.16693-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


and i'm not quite sure how other users of get_user_pages() (direct-IO)
handle these kinds of COW races. A COW can invalidate a physical page
anytime, so the DMA might go to the fork()ed child process, creating very
unexpected results. We are protected against kswapd via the elevated page
count, but are not protected against COW.

	Ingo

