Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262680AbTJJAWv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 20:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262681AbTJJAWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 20:22:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9383 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262680AbTJJAWt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 20:22:49 -0400
Date: Fri, 10 Oct 2003 01:22:48 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Ulrich Drepper <drepper@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: statfs() / statvfs() syscall ballsup...
Message-ID: <20031010002248.GE7665@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0310091525200.20936-100000@home.osdl.org> <3F85ED01.8020207@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F85ED01.8020207@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 09, 2003 at 04:19:29PM -0700, Ulrich Drepper wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Linus Torvalds wrote:
> 
> > User space shouldn't know or care about frsize, and it doesn't even 
> > necessarily make any sense on a lot of filesystems, so make it easy for 
> > the user. It's not as if the rounding errors really matter.
> 
> There have been numerous requests to add a statvfs syscall, at least
> made to me.  The problem is that the emulation through statfs cannot be
> optimal.  The emulation has to get all kinds of additional information
> (like mount flags) which in some cases lead to hangs or delays.

Umm...  I don't see anything equivalent to statfs(2) ->f_type in statvfs(2).
->f_frsize makes no sense for practically all filesystems we support.
->f_namemax is not well-defined ("maximum filename length" as in "you won't
see filenames longer than..." or "attempt to create a file with name longer
than... will fail" or "longer than that and I'm truncating";  and that is
aside of lovely questions about the meaning of "length" - strlen()?  number
of multibyte characters accepted by that fs? something else?)
->f_fsid is also practically undefined (and left 0 by practically every fs,
so no userland code can do anything useful with it).
->f_flag might be useful, all right.  However, I'd like to see real-world
examples of code (Solaris, whatever) that would use it in any meaningful
way...

Conclusion: if we care about something like statvfs(), it should *not* have
the statvfs() interface.
