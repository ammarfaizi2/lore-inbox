Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130117AbRARAls>; Wed, 17 Jan 2001 19:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131340AbRARAli>; Wed, 17 Jan 2001 19:41:38 -0500
Received: from [129.94.172.186] ([129.94.172.186]:35311 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S130117AbRARAl3>; Wed, 17 Jan 2001 19:41:29 -0500
Date: Wed, 17 Jan 2001 19:46:44 +1100 (EST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@localhost.localdomain>
To: Daniel Phillips <phillips@innominate.de>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Subtle MM bug
In-Reply-To: <3A5B61F7.FB0E79C1@innominate.de>
Message-ID: <Pine.LNX.4.31.0101171942550.31432-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2001, Daniel Phillips wrote:
> Linus Torvalds wrote:
> > (This is why I worked so hard at getting the PageDirty semantics right in
> > the last two months or so - and why I released 2.4.0 when I did. Getting
> > PageDirty right was the big step to make all of the VM stuff possible in
> > the first place. Even if it probably looked a bit foolhardy to change the
> > semantics of "writepage()" quite radically just before 2.4 was released).
>
> On the topic of writepage, it's not symmetric with readpage at
> the moment - it still takes (struct file *).  Is this in the
> cleanup pipeline?  It looks like nfs_readpage already ignores
> the struct file *, but maybe some other net filesystems are
> still depending on it.

writepage() and readpage() will never be symmetric...

readpage()
	program can't continue until data is there
	reading in larger clusters eats (wastes?) more memory
	done when we think a process needs data

writepage()
	called after the process has written data and moved on
	writing larger clusters has no influence on memory use
	often done to free up memory

Since readpage() needs to tune readahead behaviour, we will
always want to give it some information (eg. in the file *)
so it can do the extra things it needs to do.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
