Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262578AbTDHXfw (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 19:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262579AbTDHXfw (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 19:35:52 -0400
Received: from almesberger.net ([63.105.73.239]:10250 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S262578AbTDHXfv (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 19:35:51 -0400
Date: Tue, 8 Apr 2003 20:47:21 -0300
From: Werner Almesberger <wa@almesberger.net>
To: David Lang <david.lang@digitalinsight.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: 64-bit kdev_t - just for playing
Message-ID: <20030408204721.H18709@almesberger.net>
References: <20030408195305.F19288@almesberger.net> <Pine.LNX.4.44.0304081607060.5766-100000@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304081607060.5766-100000@dlang.diginsite.com>; from david.lang@digitalinsight.com on Tue, Apr 08, 2003 at 04:11:05PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:
> the biggest problem I see with dynamic numbers is that it needs a
> userspace devfs type solution for creating and maintaining the device
> nodes that are then used.

Agreed, this is the difficult part. This probably means that the
kernel will have to come with a default initrd-like setup that is
built and attached by "make bzImage" and the like. I thought that
people were quite actively working towards something like this ?

> somthing that is hard to get people to agree to (remember the devfs names
> that everyone gripes about are not what richard started with it's what he
> switched to to get things into the kernel, they changed many times during
> that process)

Actually, here we may have an advantage now. The "old way" was to
write the driver, allocate a number, release the driver, and
suggest a device name. If somebody didn't like the name, they
could easily change it to something else. Nobody had to agree
with the author.

devfs was different. The one thing everybody has to agree on is
the kernel. And gratuitous differences in "vendor kernels" are
frowned upon, and are no less of a pain in individual kernels
either. So now everyone had to accept the name the author
assigned - or fight with the author until the name changed.

(Of course, one could have mounted devfs in some dark corner and
set up a link tree pointing to it, which wouldn't have been too
different from using sysfs. devfs was never really positioned to
take such a role, and seems to carry too much overhead trying to
be a "full" /dev replacement to be justifiable as an "almost"
/dev replacement.)

By completely removing such policy from the kernel, we return to
the status quo ante: user-visible names only need to be agreed on
during early system bringup. After that, the "device file
manager" takes over, and that one can just use a local device
name database.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
