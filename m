Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317277AbSFLA1R>; Tue, 11 Jun 2002 20:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317279AbSFLA1Q>; Tue, 11 Jun 2002 20:27:16 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:39862 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S317277AbSFLA1P>; Tue, 11 Jun 2002 20:27:15 -0400
Date: Tue, 11 Jun 2002 19:27:10 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.21: kbuild changes broke filenames with commas 
In-Reply-To: <16120.1023839748@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.44.0206111903480.18347-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jun 2002, Keith Owens wrote:

> So what?  Users want filenames with ',' in them, the build system
> should cope with it.  Restricting what the user is allowed to do to
> what the build system can handle is the wrong approach.  The build
> system already has to replace '-' with '_', changing comma as well is
> not a problem.  Or are you going to say that '-' is not allowed in
> filenames either?

It's a stupid discussion - I added support for filenames containing a ',', 
but the only remaining user is 53c7,8xx.c. That one is broken by the BIO 
changes anyway, and I heard people say it should go away, as the 
hardware is supported by other drivers. So I'll wait and see, if it 
doesn't get fixed but removed, I think removing the hacks to support ',' 
in the filename is the way to go.

> >Now, what if we had:
> > 
> > 	foo,bar.c
> > 
> > and
> > 
> > 	foo_bar.c
> > 
> > in the same directory?  The kbuild system goes wrong, destroying dependency
> > information, using the wrong KBUILD_BASENAME.  Oops.  I guess we papered
> > over a bug by allowing commas in filenames.
> 
> Not in kbuild 2.5.  I handle this case correctly for the -MD dependency
> filename.  Try it and see.

Well, let me rephrase it as "foo,bar.c" and "foo:bar.c" ;). kbuild-2.5
would break. Of course it's fixable with even more workarounds, but that's
not the point.

> OBJECTNAME is externally visible, it is used in Rusty's rationalization
> of boot and module parameters.  The only time that OBJECTNAME collision
> would be a problem is when there are two modules called foo,bar and
> foo_bar.  Having two modules that differ by a single character in the
> middle of the name is going to cause more problems than just option
> collision.  BTW, the existing build system does not support
> KBUILD_OBJECTNAME so Rusty's code cannot go in.

Rusty knows that the current build system can support KBUILD_OBJECT (which 
is what you called it, not KBUILD_OBJECTNAME) just fine - it's a three 
line diff, but I don't see a point in submitting it as long as nobody uses 
it.

--Kai


