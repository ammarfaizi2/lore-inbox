Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262609AbREZXDK>; Sat, 26 May 2001 19:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262621AbREZXBf>; Sat, 26 May 2001 19:01:35 -0400
Received: from zeus.kernel.org ([209.10.41.242]:20647 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262626AbREZXAd>;
	Sat, 26 May 2001 19:00:33 -0400
From: Steve Dodd <steved@loth.demon.co.uk>
Date: Sat, 26 May 2001 10:54:39 +0100
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: ext3-users@redhat.com, Florian Lohoff <flo@rfc822.org>,
        linux-kernel@vger.kernel.org
Subject: Re: ext3 message if FS is not ext3
Message-ID: <20010526105439.A7302@lilith.loth.demon.co.uk>
In-Reply-To: <20010523140013.A883@paradigm.rfc822.org> <20010523130616.B8080@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010523130616.B8080@redhat.com>; from sct@redhat.com on Wed, May 23, 2001 at 01:06:16PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2001 at 01:06:16PM +0100, Stephen C. Tweedie wrote:
> On Wed, May 23, 2001 at 02:00:13PM +0200, Florian Lohoff wrote:

> > i think this message should be removed ;)
[..]
> > VFS: Can't find an ext3 filesystem on dev fd(2,0).

> mount(8) tried to get the kernel to mount /dev/fd0 as an ext3
> filesystem.  The kernel is entitled to emit an error in that case.
> ext2 will complain too.

Shouldn't it be doing the mount 'silently' when mount(8) is guessing the
filesystem type? I'm seeing this too (2.2.19 + ext3 0.0.6b):

lilith:tmp$ cat /etc/filesystems
ext3
vfat
lilith:tmp$ grep floppy /etc/fstab
/dev/fd0 /floppy auto noauto,nodev,nosuid,user 0 0
lilith:tmp$ # with a VFAT filesystem on /dev/fd0:
lilith:tmp$ mount /floppy
VFS: Can't find an ext3 filesystem on dev fd(2,0).

Looking at the kernel source, read_super (and hence ext3_read_super) are only
called with silent=1 when mounting the root filesystem. I believe mount(8)
checks for magic numbers at the start of the filesystem, and so avoids
attempting a mount for ext2 or various others.

As the kernel (2.2 or 2.4) doesn't seem to provide a way for userspace to
request a silent mount, I don't know whose (if anyone's) bug this is.

-- 
PGP signed or encrypted mail preferred, key ID 0x68383A73.
Please *do* Cc: me on mailing list replies.
