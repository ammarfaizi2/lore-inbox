Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130442AbQLGW5s>; Thu, 7 Dec 2000 17:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130349AbQLGW5j>; Thu, 7 Dec 2000 17:57:39 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:31168 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130012AbQLGW5b>;
	Thu, 7 Dec 2000 17:57:31 -0500
Date: Thu, 7 Dec 2000 17:26:46 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
cc: Jan Niehusmann <jan@gondor.com>, linux-kernel@vger.kernel.org,
        adilger@turbolinux.com, Byron Stanoszek <gandalf@winds.org>
Subject: Re: [PATCH] Re: fs corruption with invalidate_buffers()
In-Reply-To: <3A300933.29813DE8@Hell.WH8.TU-Dresden.De>
Message-ID: <Pine.GSO.4.21.0012071718330.22281-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Dec 2000, Udo A. Steinberg wrote:

> Jan Niehusmann wrote:
> > 
> > The following patch actually prevents the corruption I described.
> > 
> > I'd like to hear from the people having problems with hdparm, if it helps
> > them, too.
> 
> Yes, it prevents the issue.
> 
> > Please note that the patch circumvents the problem more than it fixes it.
> > The true fix would invalidate the mappings, but I don't know how to do it.
> 
> I don't know either. What does Alexander Viro say to all of this?

That invalidate_buffers() should leave the unhashed ones alone. If it can't
be found via getblk() - just leave it as is.

IOW, let it skip bh if (bh->b_next == NULL && !destroy_dirty_buffers).
No warnings needed - it's a normal situation.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
