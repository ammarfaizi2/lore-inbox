Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131644AbREHLyV>; Tue, 8 May 2001 07:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131949AbREHLyM>; Tue, 8 May 2001 07:54:12 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:29450 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S131644AbREHLyA>; Tue, 8 May 2001 07:54:00 -0400
Date: Mon, 7 May 2001 23:37:16 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: page_launder() bug
In-Reply-To: <Pine.LNX.4.21.0105072038280.8237-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0105072329580.7685-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 7 May 2001, Linus Torvalds wrote:

> In fact, it might even clean stuff up. Who knows? At least
> page_launder() would not need to know about magic dead swap pages, because
> the decision would be entirely in writepage().
> 
> And there aren't that many writepage() implementations in the kernel to
> fix up (and the fixup tends to be two simple added lines of code for most
> of them - just the "if (!priority) return").
> 
> Also note how some filesystems might use the writepage() callback even
> with a zero priority as a hint that things are approaching the point where
> we need to start flushing, which might make a difference for deciding when
> to try to write a log entry, for example.

Moreover, the filesystem may want to return "-1" even if "priority" is
non-zero --- think about delayed allocations. (the XFS guys were just
complaining about page_launder() not checking the return value of
writepage() so they could not do this kind of thing with delayed
allocations sometime ago).

> Now, I'm not saying this is _the_ solution to it, but I don't see any
> really clean alternatives.

I like it --- it pushes down control to the pagers so they can be smarter.

Will send a patch later.


