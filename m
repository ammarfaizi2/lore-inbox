Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274317AbRITGAT>; Thu, 20 Sep 2001 02:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274318AbRITGAK>; Thu, 20 Sep 2001 02:00:10 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:38669 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S274317AbRITF7v>; Thu, 20 Sep 2001 01:59:51 -0400
Date: Wed, 19 Sep 2001 22:58:43 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Hugh Dickins <hugh@veritas.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>
Subject: Re: pre12 VM doubts and patch
In-Reply-To: <20010920071240.P720@athlon.random>
Message-ID: <Pine.LNX.4.33.0109192255360.2852-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Sep 2001, Andrea Arcangeli wrote:
>
> when the page is exclusive we definitely can write to it

NO!

If it is a read-only mapping, we must NOT mark it writable.

The fact is, the page may have been written to earlier, marked read-only
with mprotect(), and the page is dirty but read-only, and swapping it in
MUST NOT markt it writable even if it is our last exclusive copy.

Which we've gotten wrong for a long time, actually. But you #if 0'ed the
fix that happened fairly recently.

		Linus

