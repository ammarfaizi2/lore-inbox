Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262134AbSKCQtx>; Sun, 3 Nov 2002 11:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262152AbSKCQtw>; Sun, 3 Nov 2002 11:49:52 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:53951 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262134AbSKCQtw>;
	Sun, 3 Nov 2002 11:49:52 -0500
Date: Sun, 3 Nov 2002 11:56:22 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       "Theodore Ts'o" <tytso@mit.edu>, Dax Kelson <dax@gurulabs.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, davej@suse.de
Subject: Re: Filesystem Capabilities in 2.6?
In-Reply-To: <1036342259.29642.51.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.GSO.4.21.0211031151590.28485-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 3 Nov 2002, Alan Cox wrote:

> On Sun, 2002-11-03 at 14:51, Alexander Viro wrote:
> > No messing with chroot needed - just a way to irrevertibly turn off the
> > ability (for anybody) to do mounts/umounts in a given namespace and ability
> > to clone that namespace.  Then give them ramfs for root and bind whatever
> > you need in there.  No breaking out of that, since there is nothing below
> > their root where they could break out to...
> 
> mkdir foo
> chroot foo
> cd ../../../..
> chroot .

... will give him nothing, since he is not in chroot jail to start with.
He has a namespace of his own with his own root filesystem.  Which has
several empty directories and nothing else - everything else is bound on
these.  He is at his absolute root and can't break out of it - there is
nowhere to break out.  So his /foo will be a subdirectory of root of his
root filesystem.  OK, he chroots there.  His cwd is still at absolute root
and he can follow .. until he's blue in the face - he will stay where he
started.

