Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbWGKWTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWGKWTw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 18:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWGKWTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 18:19:52 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:7877 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932202AbWGKWTv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 18:19:51 -0400
Subject: Re: tty's use of file_list_lock and file_move
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Theodore Tso <tytso@mit.edu>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <9e4733910607111508x526ee642p5b587698306b22d3@mail.gmail.com>
References: <9e4733910607100810r6e02f69g9a3f6d3d1400b397@mail.gmail.com>
	 <1152552806.27368.187.camel@localhost.localdomain>
	 <9e4733910607101027g5f3386feq5fc54f7593214139@mail.gmail.com>
	 <1152554708.27368.202.camel@localhost.localdomain>
	 <9e4733910607101535i7f395686p7450dc524d9b82ae@mail.gmail.com>
	 <1152573312.27368.212.camel@localhost.localdomain>
	 <9e4733910607101604j16c54ef0r966f72f3501cfd2b@mail.gmail.com>
	 <9e4733910607101649m21579ae2p9372cced67283615@mail.gmail.com>
	 <20060711012904.GD30332@thunk.org>
	 <20060711194456.GA3677@flint.arm.linux.org.uk>
	 <9e4733910607111508x526ee642p5b587698306b22d3@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 11 Jul 2006 23:37:45 +0100
Message-Id: <1152657465.18028.72.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-07-11 am 18:08 -0400, ysgrifennodd Jon Smirl:
> What about adjusting things so the BKL isn't required? I tried
> completely removing it and died in release_dev. tty_mutex is already
> locks a lot of stuff, maybe it can be adjusted to allow removal of the
> BKL.

Thats what is happening currently. However it is being done piece by
piece, slowly and carefully.

> I see why no one works on this code, it is very intertwined with the
> rest of the kernel and a lot of the reasons for locking are
> non-obvious.

You should follow l/k more closely. Since 2.6.15 Paul Fulghum and I have
completely rewritten the entire buffering logic. In 2.6.14 or so I
rewrote the line discipline locking and support code.

One hint by the way - stop looking at locks and code, look at locks and
data structures. There is an old saying "lock data not code" and it
really is true if you want to follow the locking and get it right.

The open/close/hangup logic is last on the list to fix, because as
you've noticed its the most horrible. Once the other locking is sane
that bit should become more managable even with the strict and bizarre
rules POSIX and SuS enforce on us in this area.

Alan

