Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267826AbUIAU1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267826AbUIAU1c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 16:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267776AbUIAUZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 16:25:28 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:39048 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S267743AbUIAUS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:18:27 -0400
Date: Wed, 1 Sep 2004 22:18:24 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jamie Lokier <jamie@shareable.org>
Cc: David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Chris Wedgwood <cw@f00f.org>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040901201824.GB11838@atrey.karlin.mff.cuni.cz>
References: <200408311931.i7VJV8kt028102@laptop11.inf.utfsm.cl> <41352279.7020307@slaphack.com> <20040901045922.GA512@elf.ucw.cz> <20040901161456.GA31934@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040901161456.GA31934@mail.shareable.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > It's not about the kernel, it's about the interface.  And see my other mail:
> > > 	cat foo.zip/README
> > > 	less foo.zip/contents/bar.c
> > > is a lot easier than
> > > 	lynx http://google.com/search?q=zip
> > > 	emerge zip
> > > 	man zip
> > > 	unzip foo.zip
> > > 	cat bar.c
> > > which already assumes quite a lot of expertise.
> > 
> > If you only want nice user interface, you can have that today. Its
> > done using coda, and hosted at uservfs.sf.net.
> 
> Can I do these already using uservfs?
> 
>    cd
>    less foo.zip/contents/bar.c

less foo.zip#uzip/contents/bar.c

>    less /usr/portage/distfiles/perl-5.8.5.tar.gz/contents/toke.c

less /usr/portage/distfiles/perl-5.8.5.tar.gz#utar/contents/toke.c

>    grep -R obscure_label ~/RPMS

I do not think you'd want this. How would you tell grep obscure label
without entering archives, then? 

> No I can't.

> Even using the right "#" names for uservfs ('foo.zip#zip' etc.), I can
> only do the above with convenient paths, completion etc. if I mount
> my

Well, you can... or at least I had version somewhere that
automagically prepended /overlay when file was not found. That way,
normal requests were fast and uservfs were used whenever it was
needed... At the price of little uglyness and slowing down -ENOENTs.

> As we're adding file-as-directories to VFS, I propose it would be good
> to have *hooks* in place, and non-metadata namespace reserved inside
> the directories, so that uservfs-like userspace filesystems can
> be auto-mounted at those places and synchronised with the file.
> 
> In other words, something that makes the next version of uservfs a
> whole lot more useful.

Yep, something less hacky would be nice.

> So all I am asking for is a facility to auto-mount with
> file-as-directory, and the ability for a userspace daemon to be
> notified of regular file modifications synchronously.  Both can be
> added later, once file-as-directory and moveable mounts are

If the userspace daemon is synchronously notified of file
modification... will not that lead to very ugly deadlocks?
								Pavel

-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
