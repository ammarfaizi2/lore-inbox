Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283048AbRLIFib>; Sun, 9 Dec 2001 00:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283046AbRLIFiW>; Sun, 9 Dec 2001 00:38:22 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:28306 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S283048AbRLIFiI>; Sun, 9 Dec 2001 00:38:08 -0500
Date: Sat, 8 Dec 2001 22:38:04 -0700
Message-Id: <200112090538.fB95c4G06607@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Devfs races with block devices
In-Reply-To: <Pine.GSO.4.21.0111060202160.27713-100000@weyl.math.psu.edu>
In-Reply-To: <200111060701.fA671hL20646@vindaloo.ras.ucalgary.ca>
	<Pine.GSO.4.21.0111060202160.27713-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Finally, after other things have stabilised, I'm ready to tackle this
issue]

Alexander Viro writes:
> 	BTW, here's one more devfs rmmod race: check_disk_changed() in
> fs/devfs/base.c.  Calling ->check_media_change() with no protection
> whatsoever.  If rmmod happens at that point...

How about if I do this sequence:
	lock_kernel();
	devfs checks;
	if (bd_op->owner)
		__MOD_INC_USE_COUNT(bd_op->owner);
	revalidate();
	if (bd_op->owner)
		__MOD_DEC_USE_COUNT(bd_op->owner);
	unlock_kernel();

Is there any reason why that won't work?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
