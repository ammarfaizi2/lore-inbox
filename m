Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136699AbREGXBy>; Mon, 7 May 2001 19:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136701AbREGXBo>; Mon, 7 May 2001 19:01:44 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:41220 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S136699AbREGXB3>; Mon, 7 May 2001 19:01:29 -0400
Date: Mon, 7 May 2001 18:22:56 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: page_launder() bug
In-Reply-To: <9d6npn$dhp$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0105071820460.7506-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 7 May 2001, Linus Torvalds wrote:

> But it is important to re-calculate the deadness after getting the
> lock. Before, it was just an informed guess. After the lock, it is
> knowledge. And you can use informed guesses for heuristics, but you
> must _not_ use them for any serious decisions.

And thats what swap_writepage() is doing:

static int swap_writepage(struct page *page)
{
        /* One for the page cache, one for this user, one for page->buffers */
        if (page_count(page) > 2 + !!page->buffers)
                goto in_use;
        if (swap_count(page) > 1)
                goto in_use;

...
}



