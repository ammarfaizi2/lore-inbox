Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262150AbRETTP6>; Sun, 20 May 2001 15:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262149AbRETTPt>; Sun, 20 May 2001 15:15:49 -0400
Received: from pop.gmx.net ([194.221.183.20]:13445 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S262150AbRETTPn>;
	Sun, 20 May 2001 15:15:43 -0400
Message-ID: <3B08149B.A28FDBD@gmx.de>
Date: Sun, 20 May 2001 21:01:47 +0200
From: Edgar Toernig <froese@gmx.de>
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linus Torvalds <torvalds@transmeta.com>, Ben LaHaise <bcrl@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: F_CTRLFD (was Re: Why side-effects on open(2) are evil.)
In-Reply-To: <Pine.GSO.4.21.0105201203090.8940-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Sun, 20 May 2001, Edgar Toernig wrote:
> 
> > IMHO any scheme that requires a special name to perform ioctl like
> > functions will not work.  Often you don't known the name of the
> > device you're talking to and then you're lost.
> 
> ls -l /proc/self/fd/<n>

Oh come on.  You made most of the VFS and should know better.  Since when
is it possible to always get a "usable" name for an fd???  The ls -l will
give me "deleted", "socket", "...".  If I try to access the name given
by procfs I may get EPERM, etc etc.  And then, it's pretty strange to append
a "ctl" to some arbitrary name and I get a control device for that name???
No.  Using names is __wrong__!

> [not going to happen:]
>         1) sys_ioctl() going away from syscall table.

I would never suggest that.

>         2) semi-automatic conversion of existing applications.

Same.  Much too dangerous.

> To hell with
> the way we are finding descriptor, we need to deal with arguments themselves.
> And no extra logics in libc will help - the whole problem is that ioctls
> have rather irregular arguments.

Don Quijote II.? ;-)

IMHO any similar powerful (and versatile) interface will see the same
problems.  Enforcing a read/write like interface (and rejecting drivers
that pass ptrs through this interface) may give you some knowledge about
the kernel/userspace communication.  But the data the flows around will
become the same mess that is present with the current ioctl.  Every driver
invents its own sets of commands, its own rules of argument parsing, ...
Maybe it's no longer strange binary data but readable ASCII strings but
that's all.  Look at how many different "styles" of /proc files there are.

> What we need is "make it sane", not "inherit as many things from the
> old API as possible". And obvious first target is Linux-specific
> device ioctls, simply because they have fewer programs using them.

You can impose some rules like "must support" commands, something of
how arguments are encoded, errors reported and so on.  But I wouldn't
like to see an SNMP like mess...

IMHO what's needed is a definition for "sane" in this context.  Trying
to limit the kind of actions performed by ioctls is not "sane".  Then
people will always revert back to old ioctl.  "Sane" could be: network
transparent, architecture independant, usable with generic tools and non
C-like languages.

Ciao, ET.
