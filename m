Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261357AbRE1Kou>; Mon, 28 May 2001 06:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263027AbRE1Kok>; Mon, 28 May 2001 06:44:40 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:10740 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261357AbRE1Koa>; Mon, 28 May 2001 06:44:30 -0400
Date: Mon, 28 May 2001 10:37:50 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Steve Dodd <steved@loth.demon.co.uk>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, ext3-users@redhat.com,
        Florian Lohoff <flo@rfc822.org>, linux-kernel@vger.kernel.org
Subject: Re: ext3 message if FS is not ext3
Message-ID: <20010528103750.C12466@redhat.com>
In-Reply-To: <20010523140013.A883@paradigm.rfc822.org> <20010523130616.B8080@redhat.com> <20010526105439.A7302@lilith.loth.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010526105439.A7302@lilith.loth.demon.co.uk>; from steved@loth.demon.co.uk on Sat, May 26, 2001 at 10:54:39AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, May 26, 2001 at 10:54:39AM +0100, Steve Dodd wrote:
> On Wed, May 23, 2001 at 01:06:16PM +0100, Stephen C. Tweedie wrote:
> > On Wed, May 23, 2001 at 02:00:13PM +0200, Florian Lohoff wrote:
> 
> > > i think this message should be removed ;)
> [..]
> > > VFS: Can't find an ext3 filesystem on dev fd(2,0).
> 
> > mount(8) tried to get the kernel to mount /dev/fd0 as an ext3
> > filesystem.  The kernel is entitled to emit an error in that case.
> > ext2 will complain too.
> 
> Shouldn't it be doing the mount 'silently' when mount(8) is guessing the
> filesystem type? I'm seeing this too (2.2.19 + ext3 0.0.6b):

That's possible.  There is actually a "silent" parameter passed to the
filesystem mount routines in the kernel.  Unfortunately, it's actually
encoded as a "mount-root" parameter, and it gets used when attempting
the initial root mount when we don't know the filesystem type in
advance.  Ext2/ext3 interpret the mount-root parameter as an
instruction to fail silently, but I'm not sure whether there are other
filesystems which actually use it as a hint to treat the root
differently.  If so, we can't overload that parameter to mean
go-silent.  That's no big deal, we can create a new MS_* flag for
it in that case.

> As the kernel (2.2 or 2.4) doesn't seem to provide a way for userspace to
> request a silent mount, I don't know whose (if anyone's) bug this is.

It's not a bug.  It is a missing feature, perhaps.

Cheers,
 Stephen
