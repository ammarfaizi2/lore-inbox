Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261322AbSKXOZx>; Sun, 24 Nov 2002 09:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261330AbSKXOZw>; Sun, 24 Nov 2002 09:25:52 -0500
Received: from almesberger.net ([63.105.73.239]:36101 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S261322AbSKXOZv>; Sun, 24 Nov 2002 09:25:51 -0500
Date: Sun, 24 Nov 2002 11:32:58 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Alexander Viro <viro@math.psu.edu>
Cc: Patrick Mochel <mochel@osdl.org>, Rusty Lynch <rusty@linux.co.intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] sysfs on 2.5.48 unable to remove files while in use
Message-ID: <20021124113258.S17062@almesberger.net>
References: <20021124100445.Q1407@almesberger.net> <Pine.GSO.4.21.0211240832460.9014-100000@steklov.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0211240832460.9014-100000@steklov.math.psu.edu>; from viro@math.psu.edu on Sun, Nov 24, 2002 at 08:38:22AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> a) sysfs doesn't allow mkdir/rmdir and thus avoids an imperial buttload
> of races - witness the crap in devfs.

But isn't one of the problems there that kernel and user space can
both initiate changes ? What I'm proposing is to let this be driven
by user space. You'd of course still have different policies in
different parts of the sysfs hierarchy, but would that really be a
problem ?

> b) rmdir of non-empty directory pretty much guarantees another buttload of
> races.

Hmm, if the sysfs user could veto file creation while the removal is
in progress, behaviour like rm -r would certainly be sufficient.
Even if it can't veto it, this may be good enough, since user space
is in charge of file creation (after mkdir) anyway.

The main reason why I think rmdir with rm -r functionality would be
useful in this case, is that, in order to implement a "remove probe"
functionality, the application wouldn't have to know what exactly
lives in that directory, and it also wouldn't have to implement a
real rm -r (or rm xxx/* && rmdir xxx), which I'd also consider a
more powerful operation than a simple rmdir.

I can see a potential issue with a proliferation of callbacks,
though.

> c) mkdir creating non-empty directory or rmdir removing non-empty directory
> is *ugly*.

Uglier than a "magic" file that then goes and creates/removes
directories and files in them ? Why don't we  echo mkdir foo >.
then ? ;-)

Besides, there's some precedent: . and .. are also handled
implicitly. (And do we really have no file systems that store
some meta-data in "magic" files that are created/removed
implicitly ?)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
