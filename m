Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267767AbUIBHhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267767AbUIBHhX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 03:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267777AbUIBHhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 03:37:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:43925 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267785AbUIBHhS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 03:37:18 -0400
Date: Thu, 2 Sep 2004 00:36:32 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Hans Reiser <reiser@namesys.com>
cc: David Masover <ninja@slaphack.com>, Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
In-Reply-To: <4136C876.5010806@namesys.com>
Message-ID: <Pine.LNX.4.58.0409020030220.2295@ppc970.osdl.org>
References: <20040826150202.GE5733@mail.shareable.org>
 <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org>
 <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org> <20040902002431.GN31934@mail.shareable.org>
 <413694E6.7010606@slaphack.com> <Pine.LNX.4.58.0409012037300.2295@ppc970.osdl.org>
 <4136A14E.9010303@slaphack.com> <Pine.LNX.4.58.0409012259340.2295@ppc970.osdl.org>
 <4136C876.5010806@namesys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2 Sep 2004, Hans Reiser wrote:
> Linus Torvalds wrote:
> >
> >. Doing transactions on one file is 
> >only the beginning - you'll find people who want transactions across file 
> >boundaries etc.
>
> Yup, that's what reiser4 is aiming at and where things get exciting for 
> version control systems and the like.  We are just missing the api code 
> for it at the moment, all the infrastructure is there, and the api is in 
> progress in sys_reiser4.

But _my_ point is, no user program is going to take _advantage_ of
anything that only one filesystem on one system offers.

So there's no point.

It's much saner (from _any_ app standpoint) to roll their own database in 
user space - that way it just works.

In other words, nobody is really ever going to take advantage of this. 
This is _not_ how technical advanncement happens. The way you get people 
to take advantage of something is to have a nice gradual ramp-up, not a 
sudden new feature that they can't realistically use.

So before you do transactions in the filesystem, you have to be able to do 
them in user space - and then make the filesystem version be _compatible_ 
with that user space library. That way you can get people to use the 
library ("hey, it works anywhere") and then you can get them to use your 
filesystem ("hey, if you use our super-duper filesystem, you can do what 
you are already doing five times faster").

See? You're starting at the wrong end. Give me a portable interface to use 
_first_. Then do transactions in the filesystem.

(Now, as an academic exercise and as a learnign experience and prototyping 
work it migt make sense to do the filesystem first. But then you have to 
really _consider_ it a prototype, and realize that to make it useful you'd 
still have to do the user thing before you can "sell" people on the idea).

		Linus
