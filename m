Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130893AbQL1ScQ>; Thu, 28 Dec 2000 13:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130792AbQL1Sb4>; Thu, 28 Dec 2000 13:31:56 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:44039 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129732AbQL1Sbu>; Thu, 28 Dec 2000 13:31:50 -0500
Date: Thu, 28 Dec 2000 10:01:09 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Juan Quintela <quintela@fi.udc.es>, Rik van Riel <riel@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] not sleep while holding a locked page in block_truncate_page
In-Reply-To: <Pine.LNX.4.21.0012281312020.12295-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.10.10012280955570.12064-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 28 Dec 2000, Marcelo Tosatti wrote:
> 
> Hi Linus, 
> 
> block_truncate_page() function unecessarily calls mark_buffer_dirty(),
> which may wait on bdflush, while holding a locked page.

Good catch. It should be ok to sleep for bdflush while holding the page,
but at the same time it's certainly preferable _not_ to do that.

bdflush should not need any locks that we hold, so it shouldn't have
deadlocked. How did you find this? Just reading the source, or have you
seen any real problems? If the latter, maybe there's something that tries
to get a FS lock when it shouldn't?

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
