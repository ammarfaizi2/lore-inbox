Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129242AbRBTCBX>; Mon, 19 Feb 2001 21:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129311AbRBTCBN>; Mon, 19 Feb 2001 21:01:13 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:37897 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129242AbRBTCBB>; Mon, 19 Feb 2001 21:01:01 -0500
Date: Mon, 19 Feb 2001 18:00:25 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] exclusive wakeup for lock_buffer
In-Reply-To: <Pine.LNX.4.21.0102192156330.3008-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.10.10102191757330.28351-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 19 Feb 2001, Marcelo Tosatti wrote:
> 
> The following patch makes lock_buffer() use the exclusive wakeup scheme
> added in 2.3.

Ugh, This is horrible.

You should NOT have one function that does two completely different things
depending on a flag. That way lies madness and bad coding habits.

Just do two different functions - make one be "__wait_on_buffer()", and
the other be "__lock_buffer()". See how the page functions work.

		Linus

