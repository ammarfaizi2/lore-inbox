Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261684AbSI0K51>; Fri, 27 Sep 2002 06:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261689AbSI0K51>; Fri, 27 Sep 2002 06:57:27 -0400
Received: from mx2.elte.hu ([157.181.151.9]:16516 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S261684AbSI0K50>;
	Fri, 27 Sep 2002 06:57:26 -0400
Date: Fri, 27 Sep 2002 13:11:47 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@digeo.com>, Rusty Russell <rusty@rustcorp.com.au>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 'sticky pages' support in the VM, futex-2.5.38-C5
In-Reply-To: <Pine.LNX.4.33.0209261533230.1345-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209271307510.8893-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 26 Sep 2002, Linus Torvalds wrote:

> and then the "callback" function just updates the page information in
> the futex block directly - as if it was looked up anew.

yes. And it would also have to rehash the futex queue (which is hashed
along (page,offset), because a FUTEX_WAKE has to find the proper queue -
but it's still very cheap.

this also means that FUTEX_WAIT does not have to make the futex page
writable - just making it present and hashing it along the physical page.  
Ie. more robust and less intrusive futexes.

	Ingo

