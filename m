Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135953AbREHDTO>; Mon, 7 May 2001 23:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136047AbREHDTE>; Mon, 7 May 2001 23:19:04 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:14863 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S135953AbREHDSz>; Mon, 7 May 2001 23:18:55 -0400
Date: Mon, 7 May 2001 22:40:24 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: page_launder() bug
In-Reply-To: <Pine.LNX.4.21.0105071929190.8237-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0105072234580.7685-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 7 May 2001, Linus Torvalds wrote:

> > To divert people's brains to what the intent was :-)
> 
> I can see the intent.
> 
> I can also see that the code doesn't match up to the intent.
> 
> I call that a bug. You don't. Fine.
> 
> But that code isn't coming anywhere _close_ to my tree until the two
> match. And I stand by my assertion that it should be reverted from Alans
> tree too.

I was wrong. The patch is indeed buggy because of the __GFP_IO thing.

So what about moving the check for a dead swap cache page from
swap_writepage() to page_launder() (+ PageSwapCache() check) just before
the "if (!launder_loop)" ? 

Yes, its ugly special casing. Any other suggestion ? 

