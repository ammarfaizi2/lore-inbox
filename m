Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288953AbSBZQFd>; Tue, 26 Feb 2002 11:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290823AbSBZQFO>; Tue, 26 Feb 2002 11:05:14 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:48637
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S288953AbSBZQFL>; Tue, 26 Feb 2002 11:05:11 -0500
Date: Tue, 26 Feb 2002 08:05:44 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3 and undeletion
Message-ID: <20020226160544.GD4393@matchmail.com>
Mail-Followup-To: "H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <fa.n4lfl6v.h4chor@ifi.uio.no> <05cb01c1be1e$c490ba00$1a01a8c0@allyourbase> <20020225172048.GV20060@matchmail.com> <02022518330103.01161@grumpersII> <a5f7s4$2o1$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5f7s4$2o1$1@cesium.transmeta.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2002 at 09:53:08PM -0800, H. Peter Anvin wrote:
> Followup to:  <02022518330103.01161@grumpersII>
> By author:    Tom Rauschenbach <tom@rauschenbach.mv.com>
> In newsgroup: linux.dev.kernel
> >
> > On Monday 25 February 2002 12:20, Mike Fedyk wrote:
> > > On Mon, Feb 25, 2002 at 12:06:29PM -0500, Dan Maas wrote:
> > > > > but I don't want a Netware filesystem running on Linux, I
> > > > > want a *native* Linux filesystem (i.e. ext3) that has the
> > > > > ability to queue deleted files should I configure it to.
> > > >
> > > > Rather than implementing this in the filesystem itself, I'd first try
> > > > writing a libc shim that overrides unlink(). You could copy files to
> > > > safety, or do anything else you want, before they actually get deleted...
> > >
> > > Yep, more portable.
> > 
> > But it only works if everything get linked with the new library.
> > 
> 
> What's a lot worse is that the kernel cannot chose to garbage-collect
> it.  One reason to put undelete in the kernel is that that files in
> limbo can be reclaimed as the disk space is needed for other users,
> and you don't risk getting ENOSPC due to the disk being full with
> ghosts.
>

True, and it could to tricks like listing space used for undelete as "free"
in addition to dynamic garbage collection.

Though, with a daemon checking the dirs often, or using Daniel's idea of a
socket between unlink() in glibc and an undelete daemon could work quite
similairly.

Also, there wouldn't be any interaction with filesystem internals, and
userspace would probably work better with non-posix type filesystems (vfat,
hfs, etc) too.

IOW, there seems to be little gain to having an kernelspace solution.

Mike
