Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130217AbRB1Pfz>; Wed, 28 Feb 2001 10:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130228AbRB1PfX>; Wed, 28 Feb 2001 10:35:23 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:23025 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130217AbRB1PfR>; Wed, 28 Feb 2001 10:35:17 -0500
Date: Wed, 28 Feb 2001 12:35:58 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Mike Galbraith <mikeg@wen-online.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch][rfc][rft] vm throughput 2.4.2-ac4
In-Reply-To: <Pine.LNX.4.21.0102280209160.7315-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0102281232240.5502-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Feb 2001, Marcelo Tosatti wrote:
> On Wed, 28 Feb 2001, Mike Galbraith wrote:

> > That's one reason I tossed it out.  I don't _think_ it should have any
> > negative effect on other loads, but a test run might find otherwise.
>
> Writes are more expensive than reads. Apart from the aggressive read
> caching on the disk, writes have limited caching or no caching at all if
> you need security (journalling, for example). (I'm not sure about write
> caching details, any harddisk expert?)

I suspect Mike needs to change his benchmark load a little
so that it dirties only 10% of the pages (might be realistic
for web and/or database loads).

At that point, you should be able to see that doing writes
all the time can really mess up read performance due to extra
introduced seeks.

We probably want some in-between solution (like FreeBSD has today).
The first time they see a dirty page, they mark it as seen, the
second time they come across it in the inactive list, they flush it.
This way IO is still delayed a bit and not done if there are enough
clean pages around.

Another solution would be to do some more explicit IO clustering and
only flush _large_ clusters ... no need to invoke extra disk seeks
just to free a single page, unless you only have single pages left.

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

