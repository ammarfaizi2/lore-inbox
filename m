Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312178AbSCYAtH>; Sun, 24 Mar 2002 19:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312181AbSCYAs6>; Sun, 24 Mar 2002 19:48:58 -0500
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:57315 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S312178AbSCYAsu>; Sun, 24 Mar 2002 19:48:50 -0500
Date: Mon, 25 Mar 2002 00:48:49 +0000 (GMT)
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
To: Steve Whitehouse <Steve@ChyGwyn.com>
cc: Anton Altaparmakov <aia21@cam.ac.uk>, linux-kernel@vger.kernel.org,
        pavel@suse.cz, linux-fsdevel@vger.kernel.org
Subject: Re: NBD client/server broken?
In-Reply-To: <200203242016.UAA05010@gw.chygwyn.com>
Message-ID: <Pine.SOL.3.96.1020325002758.23892A-100000@virgo.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Mar 2002, Steven Whitehouse wrote:
> > Just to keep interested parties informed:
> > 
> > Thanks to Steven Whitehouse I found out that the latest nbd client/server 
> > user space programs are in CVS on Sourceforge (the kernel nbd documentation 
> > needs updating to point to http://sf.net/projects/nbd)...
> > 
> > And I have just submitted a patch to Steven to make the nbd-server 64-bit 
> > clean on 32-bit machines and to allow proper auto detection of device size. 
> > Hopefully we will see it entering the CVS soon. Otherwise patch is 
> > available on request from me. (-:
> > 
> Its all there now and as you suggested I've added the configure script so
> autoconf is no longer required to build it.

Great.

> > Mounting a NTFS 15GiB partition over nbd (using ntfs tng driver) gave me a 
> > data throughput of 7-10MiB/sec over 100MBit ethernet (going via switch and 
> > a hub) which is quite impressive. (-:
> > 
> Also there is the zerocopy nbd patch I did for my UKUUG talk last year on my 
> patches page: http://www.chygwyn.com/~steve/kpatch/ its out of date now
> but my plan is to update and sumbit it for 2.5 in the next few weeks or so. 
> It should make things even faster or at least more efficient if we are maxing 
> out the network already :-)

Oooh. Cool. (-:

Talking about performance. When streaming I noticed that the request size
increases until it reaches 128kiB. 

This would be all fine except that nbd (or other part of the kernel?)
splits those up into two requests, one 130048 bytes and one 1024 bytes
which is not the best for performance. Note I am running a kernel with
memmory debugging (and everything else debugging) enabled so that might be
interfering here, haven't tried without debugging support in the kernel
yet... Just thought you might want to know... (The client here is 2.5.7 +
latest nbd-client from nbd CVS on SF.net.)

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

