Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131316AbRCSBWy>; Sun, 18 Mar 2001 20:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131318AbRCSBWd>; Sun, 18 Mar 2001 20:22:33 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:5650 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131316AbRCSBWZ>; Sun, 18 Mar 2001 20:22:25 -0500
Date: Sun, 18 Mar 2001 17:21:28 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: changing mm->mmap_sem  (was: Re: system call for process
 information?)
In-Reply-To: <Pine.LNX.4.21.0103181757400.13050-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.31.0103181719440.2956-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 18 Mar 2001, Rik van Riel wrote:
>
> Indeed, having threaded apps do multiple page faults at the
> same time is the main goal of this patch. However, I don't
> see how it would be good for scalability to have multiple
> threads fault in the same page at the same time, when they
> could just wait for one of them to do the work.

But they will.

That's what lock_page() etc are there for - there's no need for the VM to
synchronize because we already have the synchronization primitives at a
lower level.

And there isn't any other lock that could work anyway. It's either the
whole MM or a page. There's nothing in between.

		Linus

