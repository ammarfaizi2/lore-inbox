Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270086AbRHGFx0>; Tue, 7 Aug 2001 01:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270087AbRHGFxQ>; Tue, 7 Aug 2001 01:53:16 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:5253 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S270086AbRHGFxD>; Tue, 7 Aug 2001 01:53:03 -0400
Date: Mon, 6 Aug 2001 23:53:26 -0600
Message-Id: <200108070553.f775rQ631046@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] one of $BIGNUM devfs races
In-Reply-To: <Pine.GSO.4.21.0108062129030.16817-100000@weyl.math.psu.edu>
In-Reply-To: <200108070127.f771RNe27524@vindaloo.ras.ucalgary.ca>
	<Pine.GSO.4.21.0108062129030.16817-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> Why on the Earth do you need it, in the first place? Just put the
> pointer to entry into inode->u.generic_ip and be done with that -
> it kills all that mess for good. AFAICS the only places where you
> really use that table is your get_devfs_entry_from_vfs_inode()
> and devfs_write_inode(). In both cases pointer would be obviously more
> convenient.

Damn. I've just run into a snag. My read_inode() needs to dereference
inode->u.generic_ip, however, I can only initialise this *after* the
call to iget() finishes. Now, I could shoehorn my pointer into
inode->ino (thanks to it being an unsigned long), but that's pretty
gross.

I also notice iget4() and the read_inode2() method, however, from the
comments, it looks like those are reiserfs-specific, and will die
soon. At the very least, it seems use thereof is discouraged.

Suggestions?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
