Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261749AbUK2QUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261749AbUK2QUt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 11:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbUK2QUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 11:20:49 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:3994 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261749AbUK2QUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 11:20:41 -0500
Subject: Re: [RFC] relinquish_fs() syscall
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mitchell Blank Jr <mitch@sfgoth.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041129135559.GC33900@gaz.sfgoth.com>
References: <20041129114331.GA33900@gaz.sfgoth.com>
	 <1101729087.20223.14.camel@localhost.localdomain>
	 <20041129135559.GC33900@gaz.sfgoth.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101741440.20225.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 29 Nov 2004 15:17:21 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-11-29 at 13:55, Mitchell Blank Jr wrote:
> OK, good point, at least on i386/x86_64.  So before jailing itself a task
> will have to take CAP_SYS_RAWIO out of its permitted set.  That shouldn't
> be too bad of a restriction for most programs to live with.

> > Pardon. Its equally ineffectual. It might take someone a week longer to
> > write the exploit but an hour after that its no different.
> 
> OK, could you please describe other attacks against it then?

With CAP_SYS_RAWIO I can ask the IDE controller to DMA into the kernel
as one example. Without it should be sane. However if you take away all
the capabilities then you don't need the other changes because mount
works just fine.

> > That doesn't do name lookup, character set translation, or time (and a
> > few other things).
> 
> Alan - have you looked at privsep implementation in, say, opensshd.  The
> way privsep works is that you have two processes communicating over a
> UNIX domain socket.  One then jails itself and handles all the hairy
> untrusted data.  The unjailed process handles requests from inside as
> needed.  So if the program needs to do DNS lookups then your privsep
> protocol would include a primitive for doing that.

Yes I realise that but you also need to realise that glibc has a lot of
supporting baggage it likes to find if its going to function sanely. Yes
you can deal with it but SELinux can deal with it better.

> > >    Imagine, for example, a jpeg decoder that after opening its input and
> > >    output files called relinquish_fs().  Now if the decoder has a flaw and
> > 
> > Imagine a jpeg decoder using an SELinux policy. 
> 
> SELinux is great but it's a pretty orthoginal issue.  There's no reason the
> two can't coexist.

I don't see it as orthogonal except for the "done by user" aspect. "foo"
isnt allowed to open files or chdir is SELinux policy at work (or for
that matter the rather nice bitmap filtered syscall stuff Andrea was
talking about some time back).

BTW: you also have to deal with fchdir() and potentially AF_UNIX
sockets.

