Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263799AbRFDBLx>; Sun, 3 Jun 2001 21:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263806AbRFDBLo>; Sun, 3 Jun 2001 21:11:44 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:22782 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S263799AbRFDBLf>;
	Sun, 3 Jun 2001 21:11:35 -0400
Date: Sun, 3 Jun 2001 21:11:33 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andries.Brouwer@cwi.nl
cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: mount --bind accounting
In-Reply-To: <UTC200106040059.CAA184232.aeb@vlet.cwi.nl>
Message-ID: <Pine.GSO.4.21.0106032101500.29779-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 4 Jun 2001 Andries.Brouwer@cwi.nl wrote:

> >> /* No capabilities? What if users do thousands of these? */
> 
> > look at mount_is_safe()
> 
> Yes, good. My remark means that more tests are required
> than those sketched in mount_is_safe(), and that means
> that for the time being we can throw out the routine
> mount_is_safe(), and remove the test on capable(CAP_SYS_ADMIN)
> in do_remount(), and move the same test in do_mount up to
> the start: all forms of mount require CAP_SYS_ADMIN.
> 
> [side effect: remount read-only upon umount of root fs
> may be possible in a few more cases]

IMO umount / is bogus. For 2.5 we have much better way to unmount
everything - as soon as rootfs patch goes in, we will be able to
unmount root for real and just fall back to absolute root. Besides,
we can simply pass MNT_DETACH to umount(2) and wait until everything
goes quiet (see namespace-patch). That has a nice side effect - if
some fs is really busy (hung NFS hard mount, leak somewhere, whatever)
it will not hold the filesystem it's mounted on. Or prevent clean
unmount of filesystems mounted under it, for that matter, even if
we would hang trying to look their mountpoints up. Whether it goes
into the distributions' shutdown sequences or not, I'm quite happy
using it when I do fs stuff - I'm sick and tired of forced fsck on
root just because experimental stuff mounted on /mnt decides to
hang...

