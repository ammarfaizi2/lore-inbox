Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269638AbRHHXaE>; Wed, 8 Aug 2001 19:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269639AbRHHX3y>; Wed, 8 Aug 2001 19:29:54 -0400
Received: from guestpc.physics.umanitoba.ca ([130.179.72.122]:6916 "EHLO
	mobilix.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S269638AbRHHX3h>; Wed, 8 Aug 2001 19:29:37 -0400
Date: Wed, 8 Aug 2001 18:29:28 -0500
Message-Id: <200108082329.f78NTSc02344@mobilix.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] one of $BIGNUM devfs races
In-Reply-To: <Pine.GSO.4.21.0108081742350.22542-100000@weyl.math.psu.edu>
In-Reply-To: <9ksa6j$jo7$1@cesium.transmeta.com>
	<Pine.GSO.4.21.0108081742350.22542-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> 
> On 8 Aug 2001, H. Peter Anvin wrote:
> 
> > Followup to:  <Pine.GSO.4.21.0108071510390.18565-100000@weyl.math.psu.edu>
> > By author:    Alexander Viro <viro@math.psu.edu>
> > In newsgroup: linux.dev.kernel
> > > 
> > > It is not reliable. E.g. on NFS inumbers are not unique - 32 bits is
> > > not enough.
> > 
> > Unfortunately there is a whole bunch of other things too that rely on
> > it, and *HAVE* to rely on it -- (st_dev, st_ino) are defined to
> > specify the identity of a file, and if the current types aren't large
> > enough we *HAVE* to go to new types.  THERE IS NO OTHER WAY TO TEST
> > FOR FILE IDENTITY IN UNIX, and being able to perform such a test is
> > vital for many things, including security and hard link detection
> 
> Indeed, but it still doesn't help libc5 getcwd(3), which uses 32 bit
> values.

FYI: the problem that spawned this sub-thread is fixed. The
devfs-patch-v185 that I released last night fixes this. So the libc5
getcwd(3) is fine with 32 bit inums on devfs.

Filesystems with larger inums are left as an exercise for the reader
:-)

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
