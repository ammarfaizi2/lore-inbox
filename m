Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130382AbQLETat>; Tue, 5 Dec 2000 14:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130379AbQLETaj>; Tue, 5 Dec 2000 14:30:39 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:7636 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130371AbQLETaY>;
	Tue, 5 Dec 2000 14:30:24 -0500
Date: Tue, 5 Dec 2000 13:59:34 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <aviro@redhat.com>, Andrew Morton <andrewm@uow.edu.au>,
        Alan Cox <alan@redhat.com>, Christoph Rohland <cr@sap.com>,
        Rik van Riel <riel@conectiva.com.br>,
        MOLNAR Ingo <mingo@chiara.elte.hu>
Subject: Re: test12-pre5
In-Reply-To: <Pine.LNX.4.10.10012051030060.1902-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0012051337290.12284-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 5 Dec 2000, Linus Torvalds wrote:

> > So Stephen is right wrt fsync() (it will not get that stuff on disk).
> > However, it's not a bug - if that crap will not end up on disk we
> > will only win.
> 
> Stephen is _wrong_ wrt fsync().
> 
> Why?
> 
> Think about it for a second. How the hell could you even _call_ fsync() on
> a file that no longer exists, and has no file handles open to it?
		^^^^^^^^^^^^^^
clear_inode() <- dispose_list() <- prune_icache().

IOW, if file still exists, but is closed by everyone, etc. you _can_
get clear_inode() on it. <thinks> Ah, I see your point. OK, how about that:
	* clear_inode() _can_ be called for still-alive objects.
	* no matter how it is called, we don't give a damn for the stuff
on the list.
	* moreover, if it gets called for object that is still alive the
list is just empty. It doesn't contain anything valuable (as in every
case) _and_ it doesn't contain random crap.

If that's what you were talking about - fine with me.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
