Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316542AbSHRW7m>; Sun, 18 Aug 2002 18:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316544AbSHRW7l>; Sun, 18 Aug 2002 18:59:41 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:54147 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S316542AbSHRW7l>;
	Sun, 18 Aug 2002 18:59:41 -0400
Date: Sun, 18 Aug 2002 19:03:42 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Ed Sweetman <safemode@speakeasy.net>
cc: "Barry K. Nathan" <barryn@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: devfs
In-Reply-To: <1029709596.3331.32.camel@psuedomode>
Message-ID: <Pine.GSO.4.21.0208181852450.3920-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 18 Aug 2002, Ed Sweetman wrote:

> This has nothing to do with not mounting devfs and still using devfs to
> work with devices.   If devfs is not mounted but you're still using
> devfs, you shouldn't need anything in /dev.   The documentation says you
> can use devfs without mounting and This is what i'm saying is
> problematic and doesn't seem possible in normal usage.   It's an
> optional config so are we using devfs when we dont mount it or not?  
> and if not, then why make not mounting it an option ? 

What?  If program calls open("/dev/zero",...) and there's no such file,
how the fuck would having devfs enabled help you?

Come on, use common sense - devfs provides a tree with some device nodes.
You can mount it wherever you want (or not mount it anywhere).  Just as
with any other filesystem.

If you mount it on /dev - well, duh, you see that tree on /dev.  If you
do not - you see whatever is in /dev on underlying fs.

If program wants to access a device, it opens that device.  Just as any
other file.  By name.  There is nothing magical about names that begin
with /dev/ - it's just a conventional place for device nodes.

devfs "mount" option is an idiotic kludge that makes _kernel_ mount
it on /dev after the root fs had been mounted.  Why it had been
introduced is a great mistery, since the normal way is to have a
corresponding line in /etc/fstab and have userland mount whatever
it needs.

Said option is, indeed, not required for anything - in a sense that
it does nothing that system wouldn't be perfectly capable of in regular
ways.

But you _do_ need stuff in /dev, no matter what filesystem it comes
from.  Kernel doesn't need it, but userland programs expect to find
it there.  If you had deleted device nodes from underlying /dev and
do not care to mount something on top of it - well, there won't be
anything in that directory.

