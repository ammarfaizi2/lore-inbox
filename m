Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268072AbUIAWFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268072AbUIAWFU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 18:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268191AbUIAWCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 18:02:38 -0400
Received: from mail.shareable.org ([81.29.64.88]:16842 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S268180AbUIAWAH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 18:00:07 -0400
Date: Wed, 1 Sep 2004 22:59:39 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Pavel Machek <pavel@suse.cz>
Cc: David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Chris Wedgwood <cw@f00f.org>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040901215939.GK31934@mail.shareable.org>
References: <200408311931.i7VJV8kt028102@laptop11.inf.utfsm.cl> <41352279.7020307@slaphack.com> <20040901045922.GA512@elf.ucw.cz> <20040901161456.GA31934@mail.shareable.org> <20040901201824.GB11838@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040901201824.GB11838@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> > Can I do these already using uservfs?
> > 
> >    cd
> >    less foo.zip/contents/bar.c
> 
> less foo.zip#uzip/contents/bar.c
> 
> >    less /usr/portage/distfiles/perl-5.8.5.tar.gz/contents/toke.c
> 
> less /usr/portage/distfiles/perl-5.8.5.tar.gz#utar/contents/toke.c
>
> >    grep -R obscure_label ~/RPMS
> 
> I do not think you'd want this. How would you tell grep obscure label
> without entering archives, then? 

Granted, this is where we need "grep --recurse-into-files" or, more
generally useful, a find option.

> > No I can't.
> 
> > Even using the right "#" names for uservfs ('foo.zip#zip' etc.), I can
> > only do the above with convenient paths, completion etc. if I mount
> > my
> 
> Well, you can... or at least I had version somewhere that
> automagically prepended /overlay when file was not found. That way,
> normal requests were fast and uservfs were used whenever it was
> needed... At the price of little uglyness and slowing down -ENOENTs.

There you go... a kernel hook to prepend /overlay works :)
These hook I keep mentioning, they are really very simple :)

> > So all I am asking for is a facility to auto-mount with
> > file-as-directory, and the ability for a userspace daemon to be
> > notified of regular file modifications synchronously.  Both can be
> > added later, once file-as-directory and moveable mounts are
> 
> If the userspace daemon is synchronously notified of file
> modification... will not that lead to very ugly deadlocks?

Not if it's written properly.

-- Jamie
