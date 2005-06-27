Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261438AbVF0HWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbVF0HWR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 03:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbVF0HWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 03:22:16 -0400
Received: from nome.ca ([65.61.200.81]:49893 "HELO gobo.nome.ca")
	by vger.kernel.org with SMTP id S261668AbVF0HTF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 03:19:05 -0400
Date: Mon, 27 Jun 2005 00:19:08 -0700
From: Mike Bell <kernel@mikebell.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] ndevfs - a "nano" devfs
Message-ID: <20050627071907.GA5433@mikebell.org>
Mail-Followup-To: Mike Bell <kernel@mikebell.org>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org
References: <20050624081808.GA26174@kroah.com> <20050625221516.GD14426@waste.org> <20050625234305.GA11282@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050625234305.GA11282@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 25, 2005 at 04:43:05PM -0700, Greg KH wrote:
> So no, I'm not going to be submitting this.  But what it is, is a nice
> proof-of-concept for people who "just can't live without a in-kernel
> devfs" to show that it can be done in less than 300 lines of code, and
> only 6 hooks (2 functions in 3 different places) in the main kernel
> tree.  That is managable outside of the main kernel for years, with
> almost little to no effort.

Except that it isn't.

The "everything in the root" model just doesn't seem to work. It's been
so long since I used linux without devfs I hadn't thought about how
things like ALSA and the input subsystem have gone beyond supporting
device nodes in a subdirectory to actually requiring device nodes to be
in a subdirectory.

The obvious (and less important) legacy stuff has the old standard
names, but for the newer, properly named stuff like the input subsystem
and ALSA, it's just yet another incompatible naming scheme, and this one
doesn't even have the advantage of being an improvement in /dev
cleanliness like devfs tried to be.

For it to be manageable outside the mainline kernel the device names
/have/ to be inside the mainline kernel and have to be something
applications recognise without patching. When the ones in sysfs don't
work, we're back to needing the ones drivers provide through devfs
hooks, since I somehow don't see you modifying sysfs to accommodate a
project like this. :)

It's a shame too, once I had symlink, mkdir, mknod, chown/chmod and
unlink of symlinks working on the filesystem I was able to boot up with
it as /dev on my laptop, and figured it would just be a matter of
de-devfsifying my scripts, but it looks now like the names it implements
are just plain unworkable rather than merely inconvenient, quite aside
from the unholy amount of pointless chmoding required.

What could work is using the devfs-style registration hooks with a
filesystem like this, but that returns us to what I proposed (and I
believe a few people before me actually have coded up) of a simply
cleaned up and simplified devfs. Which, as far as I know, you outright
reject.
