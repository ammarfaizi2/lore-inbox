Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129367AbRA1RVy>; Sun, 28 Jan 2001 12:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129235AbRA1RVo>; Sun, 28 Jan 2001 12:21:44 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:42256 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129406AbRA1RVc>; Sun, 28 Jan 2001 12:21:32 -0500
Date: Sun, 28 Jan 2001 09:21:11 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: Re: ps hang in 241-pre10
In-Reply-To: <Pine.LNX.4.21.0101280155480.12703-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.10.10101280918420.3673-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 28 Jan 2001, Marcelo Tosatti wrote:
> 
> Why dont you just put set_page_dirty() back in page_launder() in case
> writepage() fails?

Because a EIO or similar should _not_ be re-tried or kept dirty.

Imagine a bad user that goes over his quota on purpose, and then every
single write will always return an error. What should we do? Let him eat
all physical memory? I don't think so. 

write-out errors will be ignored. We _might_ send a signal or something,
but considering the fact that we don't even know who caused the dirty page
in the first place, even that is kind of hard.

Shared memory and out-of-swap is special - the shared memory code is
supposed to check that we have enough memory before it even allocates
anything.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
