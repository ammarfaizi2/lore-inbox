Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268053AbUIBJNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268053AbUIBJNj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 05:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268026AbUIBJNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 05:13:38 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:40153 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268042AbUIBJM5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 05:12:57 -0400
Message-ID: <4699bb7b04090202121119a57b@mail.gmail.com>
Date: Thu, 2 Sep 2004 21:12:56 +1200
From: Oliver Hunt <oliverhunt@gmail.com>
Reply-To: Oliver Hunt <oliverhunt@gmail.com>
To: Hans Reiser <reiser@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
Cc: Linus Torvalds <torvalds@osdl.org>, David Masover <ninja@slaphack.com>,
       Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <4136E0B6.4000705@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040826150202.GE5733@mail.shareable.org> <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org> <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org> <20040902002431.GN31934@mail.shareable.org> <413694E6.7010606@slaphack.com> <Pine.LNX.4.58.0409012037300.2295@ppc970.osdl.org> <4136A14E.9010303@slaphack.com> <Pine.LNX.4.58.0409012259340.2295@ppc970.osdl.org> <4136C876.5010806@namesys.com> <Pine.LNX.4.58.0409020030220.2295@ppc970.osdl.org> <4136E0B6.4000705@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How would we go about finding out how many data forks were in a file? 
Because in order to be able to retrieve data from a fork we would need
to know that the fork were there.  Currently this would imply that we
go looking through mtab or some such to find out what fs we're running
on, which seems ugly.

Alternatively we go through the _exciting_ task of making every other
fs (with the exceptions of ntfs, and whatever it is that macs use,
which would need there own custom code) and add code that effectively
goes

getNumForks(fileref){ return 1;} 

or add a new open call that can take a fork number...

either way we have to add a new syscall, that doesn't conform to any
real standard(though i suppose it would be possible to use
macOS/windows style fork iopening interface)

I personally like the concept of having multiple forks in a file, but
in this case I'm inclined towards usermode first, then if it takes off
add kernel level support.

--Oliver Hunt

On Thu, 02 Sep 2004 01:58:30 -0700, Hans Reiser <reiser@namesys.com> wrote:
> Linus Torvalds wrote:
> 
> > But _my_ point is, no user program is going to take _advantage_ of
> >
> >anything that only one filesystem on one system offers.
> >
> >
> Apple does not have this problem....
> 
> and yes, the apps will take advantage of it, which is different from
> depending on it.  If you use the wrong fs you will lose some of the
> features of the app.
> 
> For 30 years nothing much has happened in Unix filesystem semantics
> because of sheer cowardice (excepting Clearcase, which priced itself
> into a niche market).   It is 25 years past time for someone to change
> things.  That someone will have first mover advantage, and the more
> little semantic features possessed the more lure there will be to use it
> which will increase market share which will lure more apps into
> depending on it and in a few years the other filesystems will
> (deservedly) have only a small market share because the apps won't all
> work on them.
> 
> Besides, there are enhancements which are simply compelling.  You can
> write a dramatically better performance version control system with a
> much simpler design if the FS is atomic.    Our transaction manager
> first draft was written by a version control guy, and he would probably
> be happy to tell you how  lack of atomicity other than rename makes
> version control software design hideous.
> 
> We have the performance lead.  By next year we will be stable enough for
> mission critical servers, and then we start the serious semantic
> enhancements.
> 
> If you don't embrace progress, then you doom Linux to following behind,
> because the guys at Apple are pretty aggressive now that Jobs is back,
> and they WILL change the semantics, and they will do so in compelling
> ways, and Linux will be reduced to aping them when it should be leading
> them.
> 
> Hans
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
