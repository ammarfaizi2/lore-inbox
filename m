Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262360AbVF1BN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbVF1BN2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 21:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261927AbVF1BN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 21:13:27 -0400
Received: from hummeroutlaws.com ([12.161.0.3]:20753 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S262360AbVF1BNS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 21:13:18 -0400
Date: Mon, 27 Jun 2005 21:07:28 -0400
From: Jim Crilly <jim@why.dont.jablowme.net>
To: Prakash Punnoor <lists@punnoor.de>
Cc: Steve Lord <lord@xfs.org>, "Theodore Ts'o" <tytso@mit.edu>,
       Hans Reiser <reiser@namesys.com>, Markus T?rnqvist <mjt@nysv.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       David Masover <ninja@slaphack.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
Message-ID: <20050628010728.GC24548@mail>
Mail-Followup-To: Prakash Punnoor <lists@punnoor.de>,
	Steve Lord <lord@xfs.org>, Theodore Ts'o <tytso@mit.edu>,
	Hans Reiser <reiser@namesys.com>, Markus T?rnqvist <mjt@nysv.org>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	David Masover <ninja@slaphack.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
	Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ReiserFS List <reiserfs-list@namesys.com>
References: <42BB7B32.4010100@slaphack.com> <200506240334.j5O3YowB008100@laptop11.inf.utfsm.cl> <20050627092138.GD11013@nysv.org> <20050627124255.GB6280@thunk.org> <42C0578F.7030608@namesys.com> <42C05F16.5000804@xfs.org> <20050627202841.GA27805@thunk.org> <42C06873.7020102@xfs.org> <42C0868E.4080003@punnoor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C0868E.4080003@punnoor.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/28/05 01:06:54AM +0200, Prakash Punnoor wrote:
> 
> So I gave ext3 a try. Very robust, but at the same time slooow. I couldn't
> bear it after some months. So I gave xfs another try. Yes, now it felt much
> better. Still not that fast as reiserfs, IIRC, but better than the first time
> I tried. I am still having xfs on / and it works pretty well, and is rather
> robust against hard locks with about the same amount of data losing as
> reiserfs. But what annoys me very much, is that I have to run xfs_repair by
> hand and by booting from another partition. Even after a hard lock, the
> partition mounts w/o problems and everything seems OK, but it only seems like
> that. In fact after some hours/days of use, you'll notice oddities, like files
> or directories which cannot be removed and things like that. After running
> xfs_repair everything is back in order.

I don't know what was going on with your systems, but I've been using XFS
since the original 1.0 Linux release from SGI and I'd guess that I've had to run
xfs_repair less than 10 times and most of them were on Alpha and Sparc64
before issues with those arches got ironed out.

Right now I have XFS on both Alpha and Sparc64 and I haven't had
any issues on either box. Infact the Sparc64 box's XFS filesystem was
converted from reiser3 because the some part of the filesystem got
mysteriously corrupted in such a way that reiserfsck and the reiser3 driver
both thought it was fine but accessing a certain file would cause a lockup.

I really hope the reiser4 userland tools are a lot better than the reiser3
tools, that's an area that reiserfs has lagged behind hugely IMO.

> 
> In between I gave an alpha (or rather several alphas) of reiser4 a try - but
> not on /, just on /usr. Well, I wouldn't say it was extraordinary fast. In
> fact it felt slower than reiserfs V3, but much more space efficient. And to my
> surprise it was very robust as well. Hard-locks were no problem. Only annoying
> then was, that unmounting regularly produced oops but later versions corrected
> that. But nevertheless it didn't survive, as like V3, with time V4 became
> slower and slower. In this case no year was needed, but just one month or
> alike. So end of test...but in fact I'll give V4 another go in the near future.
> 
> 
> All in all I can say that every fs I tested was able to not smoke all of my
> data, even using an instable machine - but only ext3, reiser v3 and v4 were
> non-annoying. But xfs is majorly annoying in that respect. I hope that new
> versions will be able to keep consistency w/o having to run xfs_repair every
> time after a lock-up...
> 
> But what I don't understand is, that sometimes even files, which were only
> opened for reading, got overwritten with @^@^@ after a lock-up. I don't
> understand the logics here, how this could happen.
> 
> Thx for your time,
> 
> Prakash

Jim.
