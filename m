Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266274AbSLOHQ3>; Sun, 15 Dec 2002 02:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266285AbSLOHQ3>; Sun, 15 Dec 2002 02:16:29 -0500
Received: from fed1mtao03.cox.net ([68.6.19.242]:33168 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP
	id <S266274AbSLOHQ2>; Sun, 15 Dec 2002 02:16:28 -0500
From: junkio@cox.net
To: Andrew Walrond <andrew@walrond.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Symlink indirection
References: <fa.eib7vkv.1tju08k@ifi.uio.no> <fa.cnblikv.qjmuqd@ifi.uio.no>
Date: 14 Dec 2002 23:24:15 -0800
Message-ID: <7v65tvn3s0.fsf@assigned-by-dhcp.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"AW" == Andrew Walrond <andrew@walrond.org> gives an example of
a/{x,y,z}, b/{y,z}, c/z mounted on d/. in that order, later
mounts covering the earlier ones.

AW> echo "d/w" > d/w would create a new file in directory a.

Personally I'd rather expect this to happen in c/.  Imagine a/
being on read-only medium like CD-ROM containing bunch of source
files, b/ to hold patched source, and c/ to hold binaries
resulting from compilation.  That is,

    rm -fr a b c d
    mkdir a b c d
    mount /cdrom a
    mount --bind a d
    mount --bind --overlay b d
    (cd b && bzip2 -d <../patch-2.9.91.bz2 | patch -p1)
    mount --bind --overlay c d
    (cd c && make mrproper && cat ../.config >.config &&
    make oldconfig && make dep && make bzImage)

Back to your example; what do you wish to happen when we do
this?

    $ mv d/z d/zz && test -f d/z && cat d/z

Here we rename d/z (which is really c/z) to zz.  Does this
reveal z that used to be hidden by that, namely b/z, and "cat
d/z" now shows "b/z"?

Or just like the case of creating a new file, does the union
"remember" the fact that the directory "d" should not contain
"z" anymore, and "test -f d/z" fails?

