Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130670AbRCEVSQ>; Mon, 5 Mar 2001 16:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130671AbRCEVR5>; Mon, 5 Mar 2001 16:17:57 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:39422 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130670AbRCEVRm>;
	Mon, 5 Mar 2001 16:17:42 -0500
Date: Mon, 5 Mar 2001 16:17:33 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: linux-kernel@vger.kernel.org
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.4.2ac12
In-Reply-To: <E14a26R-0007lp-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0103051605490.27373-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 5 Mar 2001, Alan Cox wrote:

> o	Fix binfmt_misc (and make the proc handling	(Al Viro)
> 	|a filesystem -
> 	|mount -t binfmt_misc none /proc/sys/fs/binfmt_misc

One comment: probably the best way to maintain backwards compatibility
for people who used binfmt_misc as a module would be the following:

post-install binfmt_misc /bin/mount -t binfmt_misc none /proc/sys/fs/binfmt_misc
pre-remove binfmt_misc /bin/umount /proc/sys/fs/binfmt_misc

in the /etc/modules.conf. Then insmod binfmt_misc and rmmod binfmt_misc
will have the same effect as they used to do.

However, the Right Thing(tm) is
	a) let mount do insmod (not the other way round)
	b) use less idiotic mountpoint (binfmt_misc is sysctl-related, so it
got no business being under /proc/sys).

BTW, the new code in fs/binfmt_misc.c can be considered as a demo on how to turn
drivers into filesystems...
								Cheers,
									Al

