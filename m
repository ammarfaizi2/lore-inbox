Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261246AbREOSnI>; Tue, 15 May 2001 14:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261247AbREOSm6>; Tue, 15 May 2001 14:42:58 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:53669 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261246AbREOSmr>;
	Tue, 15 May 2001 14:42:47 -0400
Date: Tue, 15 May 2001 14:42:42 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: James Simmons <jsimmons@transvirtual.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <Pine.LNX.4.10.10105151036490.22038-100000@www.transvirtual.com>
Message-ID: <Pine.GSO.4.21.0105151419040.21081-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 May 2001, James Simmons wrote:

> Well creating a new device wouldn't make linus happen right now. I do
> agree ioctl calls are evil!!!! You only have X amount of them. With write
> you can have infinte amounts of different functions to perform on a
> device. I didn't design fbdev :-( If I did it would have been far
> different. I do plan on some day merging drm and fbdev into one interface. So
> I plan to change this behavior. I like to see this interface ioctl-less
> (is their such a word ???). You mmap to alter buffers. Mmap is much more
> flexiable than write for graphics buffers anyways. You use write to pass
> "data" to the driver.

For data - maybe (but you lose any semblance of network transparency).
For commands? No fscking way in hell.

Look, we used to live in the world where every bloody action with
every bloody device required a special application (or macro, or
special library or equivalent abortion). It sucked. It _still_
sucks that way in CP/M and VMS lands.

The only reason for such suckitude is laziness. We shouldn't need to
do fscking voodoo to change modem speed. We shouldn't need it to change
font. We shouldn't need it to rewind tape or format disk. We _have_ to
do it because "ioctls are good enough and allow to do it fast, dirty and
without thinking about good APIs".

But guess what? mmap() also means that you need special applications.
mmap() also doesn't work over the network. You may need it as a performance
hack for massive data transfers, but if you hit memory bandwidth limitiations
on stuff like changing palette... Well, maybe you should spend time doing
something more productive. Like picking nose or masturbating.

