Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317212AbSEXQ3w>; Fri, 24 May 2002 12:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317214AbSEXQ3u>; Fri, 24 May 2002 12:29:50 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26891 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317212AbSEXQ3p>; Fri, 24 May 2002 12:29:45 -0400
Date: Fri, 24 May 2002 09:29:56 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Andrea Arcangeli <andrea@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: negative dentries wasting ram
In-Reply-To: <Pine.GSO.4.21.0205241215340.9792-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.44.0205240927580.11495-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 24 May 2002, Alexander Viro wrote:
>
> On Fri, 24 May 2002, Linus Torvalds wrote:
>
> > However, you're right that it probably doesn't help to do this after
> > "unlink()" - it's probably only worth doing when actually doing a
> > "lookup()" that fails.
>
> Depends on many things, including the amount of userland code that does
> 	unlink(name);
> 	open(name, O_CREAT|O_EXCL..., ...);

Note that this will have to touch the FS anyway, since the O_CREAT thing
forces a call down to the FS to actually create the file.

The only think we save is a dentry kfree/kmalloc in this case, nbot a FS
downcall. And I think Andrea is right that it can waste memory for the
likely much more common case where the file just stays removed.

		Linus

