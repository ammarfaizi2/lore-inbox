Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264772AbSJVQt6>; Tue, 22 Oct 2002 12:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264773AbSJVQt6>; Tue, 22 Oct 2002 12:49:58 -0400
Received: from cs.columbia.edu ([128.59.16.20]:60838 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S264772AbSJVQt5>;
	Tue, 22 Oct 2002 12:49:57 -0400
Subject: Re: can chroot be made safe for non-root?
From: Shaya Potter <spotter@cs.columbia.edu>
To: linux-kernel@vger.kernel.org
In-Reply-To: <200210221042.29498.pollard@admin.navo.hpc.mil>
References: <20021016015106.E30836@ma-northadams1b-3.bur.adelphia.net>
	 <87n0pevq5r.fsf@ceramic.fifi.org>
	 <20021019134445.B28191@ma-northadams1b-3.bur.adelphia.net>
	 <200210221042.29498.pollard@admin.navo.hpc.mil>
Content-Type: text/plain
Organization: 
Message-Id: <1035305728.2479.18.camel@zaphod>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.2 (Preview Release)
Date: 22 Oct 2002 12:55:28 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-22 at 11:42, Jesse Pollard wrote:
> On Saturday 19 October 2002 12:44 pm, Eric Buddington wrote:
> > On Tue, Oct 15, 2002 at 11:44:32PM -0700, Philippe Troin wrote:
> > > > Would it be reasonable to allow non-root processes to chroot(),
if the
> > > > chroot syscall also changed the cwd for non-root processes?
> > >
> > > No.
> > >
> > >   fd = open("/", O_RDONLY);
> > >   chroot("/tmp");
> > >   fchdir(fd);
> > >
> > > and you're out of the chroot.
> >
> > I see. From my aesthetic, it would make sense for chroots to
'stack',
> > such that once a directory is made the root directory, its '..'
entry
> > *always* points to itself, even after another chroot(). That would
> > prevent the above break (you could be outside the new root, but you
> > still couldn't back out past the old root), though perhaps at an
> > unacceptable in complexity.
> 
> That isn't relevent - the fchdir(fd) doesn't use a path. It doesn't
matter
> what is done to the ".." entry. fd is referring to an OPEN file id.
The
> chdir goes to the file id, bypassing any path name evaluation.

yes, but if the fd is within a chroot, then there will be a ".." above
that will be a chroot point, if you go into the orig chroot w an fd,
yea, you can go up to the "orig root" (aka the real /) from that fd. 
Otherwise, you will be stopped once you hit a chroot point.

If you are in a chroot, and you can get chroot's to stack (as per I
described b4) then any fd you ever get will be locked in, as you wont be
able to use fchdir to jump out of all the chroot's and then ".." up.



