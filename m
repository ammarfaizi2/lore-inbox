Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263137AbSJVPhG>; Tue, 22 Oct 2002 11:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263135AbSJVPhG>; Tue, 22 Oct 2002 11:37:06 -0400
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:49555 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S263137AbSJVPhF> convert rfc822-to-8bit; Tue, 22 Oct 2002 11:37:05 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: ebuddington@wesleyan.edu,
       Eric Buddington <eric@ma-northadams1b-3.bur.adelphia.net>,
       linux-kernel@vger.kernel.org
Subject: Re: can chroot be made safe for non-root?
Date: Tue, 22 Oct 2002 10:42:29 -0500
User-Agent: KMail/1.4.1
References: <20021016015106.E30836@ma-northadams1b-3.bur.adelphia.net> <87n0pevq5r.fsf@ceramic.fifi.org> <20021019134445.B28191@ma-northadams1b-3.bur.adelphia.net>
In-Reply-To: <20021019134445.B28191@ma-northadams1b-3.bur.adelphia.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210221042.29498.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 19 October 2002 12:44 pm, Eric Buddington wrote:
> On Tue, Oct 15, 2002 at 11:44:32PM -0700, Philippe Troin wrote:
> > > Would it be reasonable to allow non-root processes to chroot(), if the
> > > chroot syscall also changed the cwd for non-root processes?
> >
> > No.
> >
> >   fd = open("/", O_RDONLY);
> >   chroot("/tmp");
> >   fchdir(fd);
> >
> > and you're out of the chroot.
>
> I see. From my aesthetic, it would make sense for chroots to 'stack',
> such that once a directory is made the root directory, its '..' entry
> *always* points to itself, even after another chroot(). That would
> prevent the above break (you could be outside the new root, but you
> still couldn't back out past the old root), though perhaps at an
> unacceptable in complexity.

That isn't relevent - the fchdir(fd) doesn't use a path. It doesn't matter
what is done to the ".." entry. fd is referring to an OPEN file id. The
chdir goes to the file id, bypassing any path name evaluation.
-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
