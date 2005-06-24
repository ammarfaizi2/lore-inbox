Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263318AbVFXROS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263318AbVFXROS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 13:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263388AbVFXROR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 13:14:17 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:33113 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S263318AbVFXRKi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 13:10:38 -0400
Message-ID: <42BC3E8C.30602@tls.msk.ru>
Date: Fri, 24 Jun 2005 21:10:36 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] ndevfs - a "nano" devfs
References: <20050624081808.GA26174@kroah.com>
In-Reply-To: <20050624081808.GA26174@kroah.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> Now I just know I'm going to regret this somehow...
> 
> Anyway, here's yet-another-ramfs-based filesystem, ndevfs.  It's a very
> tiny:
> $ size fs/ndevfs/inode.o 
>    text    data     bss     dec     hex filename
>    1571     200       8    1779     6f3 fs/ndevfs/inode.o
> replacement for devfs for those embedded users who just can't live
> without the damm thing.  It doesn't allow subdirectories, and only uses
> LSB compliant names.  But it works, and should be enough for people to
> use, if they just can't wean themselves off of the idea of an in-kernel
> fs to provide device nodes.

Well.  Maybe directories really are of no use, but mknod/symlink/unlink
*are* useful.  That same mdadm who needs to create /dev/mdX *before*
that device is created?  And socket for /dev/log...

And oh, directories.. devpts?  Stuff like cciss/... represented in sysfs
like cciss!... ?

I don't see anything wrong with allowing creating/removing files in
the filesystem (except of possible locking issues which can arise) --
in-kernel support just does mknod/unlink on insert/remove, and if
that fails (EEXIST/ENOENT), well, so be it...

And since the whole namespace is now flat, another question comes in:
is there any guarantee the names will not overlap?  /dev/ttyS0 and
/dev/usb/ttyS0 (I don't remember which one it was, but I *think* I
saw same names but in different dirs in /dev...)

/mjt
