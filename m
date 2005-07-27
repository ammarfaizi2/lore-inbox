Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261971AbVG0BF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261971AbVG0BF6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 21:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbVG0BF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 21:05:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13805 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261971AbVG0BF4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 21:05:56 -0400
Date: Tue, 26 Jul 2005 18:04:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: mkrufky@m1k.net
Cc: astralstorm@gorzow.mm.pl, linux-kernel@vger.kernel.org
Subject: Re: MM kernels - how to keep on the bleeding edge?
Message-Id: <20050726180452.3bdec6df.akpm@osdl.org>
In-Reply-To: <42E6D7E9.2080408@m1k.net>
References: <20050726185834.76570153.astralstorm@gorzow.mm.pl>
	<42E692E4.4070105@m1k.net>
	<20050726221506.416e6e76.astralstorm@gorzow.mm.pl>
	<42E69C5B.80109@m1k.net>
	<20050726144149.0dc7b008.akpm@osdl.org>
	<42E6D7E9.2080408@m1k.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Krufky <mkrufky@m1k.net> wrote:
>
> Andrew Morton wrote:
> 
> >Michael Krufky <mkrufky@m1k.net> wrote:
> >  
> >
> >>[ tracking mm stuff ]
> >>    
> >>
> While we're on the topic of how -mm works, I have a question for you.  
> How can I test a kernel source tree (during compilation) to determine 
> whether it is a -mm tree or a -linus tree?
> 
> I will give you an example of what I am trying to do:
> 
> video4linux cvs is backwards compatible with older 2.6 kernels.  We keep 
> backwards compatibility so that users can install newer device drivers 
> without having to compile an entire kernel.  There are things like:
> 
> #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,13)
> 
> ...all over the code that allows it to compile cleanly with many 
> different versions.  Our patching scripts eliminate these "compatibility 
> tests" from the source when building patches, and only presents the code 
> compatible with the correct kernel version, so this doesn't interfere 
> with development or the patching process.

I'd really rather not have to get into that level of divergence.  Usually,
patches in -mm should be directly applicable to -linus.

> However, sometimes there are patches in -mm that are incompatable with 
> -linus.  An example of this is "Pavel's pm_message_t mangling" ... 

OK.  The way I handle an exceptional case like that is to merge the
-linus-compatible patch into -mm and then have another patch on top of that
which fixes things up for the -mm tree.  Later, that patch gets folded into
your patch if Pavel's stuff gets merged.  Or gets dropped if it doesn't get
merged.  Or gets folded into Pavel's stuff if your patch goes in first.

IOW: for a bunch of reasons we really do want to make the "fix up V4l for
-mm differences" patch be a separate patch file.

And I very much prefer that people work against -linus and when these
things occasionally pop up I'll just fix stuff up.  It's only if someone is
explicitly working against a patch which is only in -mm that they should
have to care about -mm vs -linus differences.

> Testing for the numbered 2.6.x version isn't enough of a test in a case 
> like this, but it would be nice to be able to develop against the most 
> recent version of both the -mm tree and the -linus tree without having 
> to revert patches.  Of course, v4l has chosen to maintain compatibility 
> with -mm, for the sake of patch generation, and I have a handy 
> -linus-compat.patch on the side for now if I want to build cvs against 
> -linus, until Pavel's patches get merged later on.  But I'm sure things 
> like this must happen all the time.  How do others deal with issues like 
> these automatically?
> 
> It doesn't matter which -mm version or which -linus version it is... I 
> can already test for 2.6.x ... All that matters is if it is -mm or 
> -linus.  If there isn't already an answer to this question, maybe you 
> can create a /linux/.mm file, or something like that.  A Makefile can 
> test for the presence of that file... or is there already a file present 
> that is unique to the -mm tree?

Well, if you really, really, really feel a need to do this then feel free
to send along a patch which does whatever you need it to do.

But as I say, I'd prefer that you be raising patches against -linus and
testing them in -mm.

