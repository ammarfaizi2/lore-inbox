Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbTHSVlg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 17:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261547AbTHSVl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 17:41:28 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:40357
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S261623AbTHSVjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 17:39:17 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Will uclibc be supported in 2.6? (was Re: [PATCH] Re: [PATCH] scsi.h uses "u8" which isn't defined.)
Date: Tue, 19 Aug 2003 17:38:36 -0400
User-Agent: KMail/1.5
Cc: Erik Andersen <andersen@codepoet.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <lRjc.6o4.3@gated-at.bofh.it> <200308190832.24744.rob@landley.net> <20030819172651.GA15781@gtf.org>
In-Reply-To: <20030819172651.GA15781@gtf.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308191738.36574.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 August 2003 13:26, Jeff Garzik wrote:
> On Tue, Aug 19, 2003 at 08:32:24AM -0400, Rob Landley wrote:
> > On Monday 18 August 2003 15:04, Jeff Garzik wrote:
> > > >    But generally idea is good: keep interface separately from
> > > > implementation.
> > >
> > > No, the idea is to physically separate the headers.
> > >
> > > include/{linux,asm} is currently copied to userspace, hacked a bit,
> > > and then shipped as the "glibc-kernheaders" package.
> >
> > Or used directly by uclibc (and linux from scratch) to build the library
> > against.
>
> Yes, this is incorrect.
>
> Kernel developers have been telling people for years, "do not directly
> include kernel headers."

In userspace programs, no.  But the C library has needed to include the kernel 
headers because there was nothing else defining the kernel ABI, and there 
still isn't in the actual kernel tarball.

> > I've got a project using uclibc, and build it myself, currently against
> > the 2.4 headers.  What's the plan for 2.6?  Everything I've seen on the
> > subject is "using kernel headers directly from userspace is evil, even to
> > build your libc against, but we currently offer no alternative, so go bug
> > your libc maintainer and have THEM do it..."
>
> Well, do you expect kernel developers to fix up every libc out there?

No, but I do expect the kernel to provide some way to bind to its ABI, and I'd 
expect the change you're proposing to be to be a 2.7 issue if no alternative 
has been presented yet for things that currently DO need the kernel headers.  
(Or is the official word that everybody must install this glibc package to 
use a 2.6 kernel?)

The new kernel ABI headers mentioned here don't seem to exist yet, yet what 
I'm hearing is that we're not just supposed to deprecate the old ad-hoc way 
of doing things, but completely stop using it immediately.  What exactly is 
the benefit of this supposed of to be?

Or are you saying that glibc will be the only C library supported for use with 
2.6, and uclibc users should wait until 2.7?

> That's what libc maintainers exist for.  Distro guys did glibc,
> (glibc-kernheaders) that covers the majority.

The message everybody quotes from Linus to stop having the asm symlink point 
into /usr/src/linux came out during the 2.4.0-test series.

http://groups.google.com/groups?selm=linux.kernel.8lop07%242ee%241%40penguin.transmeta.com

Now we're in 2.6.0-test and there's another change coming.  Fine.  What's the 
alternative?  If the replacement isn't ready, then this is a 2.7 thing rather 
than what people will actually be doing under 2.6.

Or are you saying linux-kernel should punt and the glibc guys are now going to 
define the linux kernel ABI for 2.6? 

> In any case, _this thread_ is an attempt to answer your question,
> "what's the plan?"  For 2.6, I don't need include/abi happening.  Way
> too late for that.  For 2.7, IMO we need it...

I'm all for doing it in 2.7.  I just want to know what I should do for 2.6.  
If there's a consensus that we're talking about 2.7 and allowing ad-hockery 
to continue in 2.6, I'll shut up. :)

> 	Jeff

Rob
