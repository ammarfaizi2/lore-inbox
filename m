Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263625AbRFRGk6>; Mon, 18 Jun 2001 02:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263660AbRFRGkh>; Mon, 18 Jun 2001 02:40:37 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:30883 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S263625AbRFRGkb>; Mon, 18 Jun 2001 02:40:31 -0400
Date: Mon, 18 Jun 2001 00:40:21 -0600
Message-Id: <200106180640.f5I6eLS30459@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: Re: [PATCH] devfs v181 available
In-Reply-To: <Pine.GSO.4.21.0106180228180.17131-100000@weyl.math.psu.edu>
In-Reply-To: <200106180601.f5I613D29992@vindaloo.ras.ucalgary.ca>
	<Pine.GSO.4.21.0106180228180.17131-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> 
> 
> On Mon, 18 Jun 2001, Richard Gooch wrote:
> 
> > - Widened locking in <devfs_readlink> and <devfs_follow_link>
> 
> No, you hadn't. Both vfs_readlink() and vfs_follow_link() are blocking
> functions, so BKL is worthless there.

Huh? The BKL will protect against other operations which might cause
the devfs entry to be unregistered, where those other operations also
grab the BKL. So, it's an improvement.

Sure, some operations may cause unregistration without grabbing the
BKL, but that's orthogonal (and requires more extensive changes). If
this "widening" is of no use, then what use are the existing grabs of
the BKL in those functions? You're the one who added them in the first
place.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
