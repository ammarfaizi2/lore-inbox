Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315483AbSEMCgf>; Sun, 12 May 2002 22:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315485AbSEMCge>; Sun, 12 May 2002 22:36:34 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:65487 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S315483AbSEMCgd>; Sun, 12 May 2002 22:36:33 -0400
Date: Sun, 12 May 2002 20:36:25 -0600
Message-Id: <200205130236.g4D2aPX13250@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] devfs v212 available
In-Reply-To: <Pine.GSO.4.21.0205110213300.20383-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> On Sat, 11 May 2002, Richard Gooch wrote:
> > This is against 2.5.14. Highlights of this release:
> > 
> > - Added BKL to <devfs_open> because drivers still need it
> 
> Sigh...  Look at the callers of check_disc_changed() and check
> what's going on with traversing directory contents there.

OK, I've had a look. There is indeed a race there. While it is safe
against module unloading, it isn't safe against removal of entries
from the directory. I'm considering some different options to fix this
(one is simple and obvious, the other will be a little more
efficient).

Question: can invalidate_device() and the bdops methods
check_media_change() and revalidate() be called with a lock held?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
