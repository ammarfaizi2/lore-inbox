Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261429AbREOUPS>; Tue, 15 May 2001 16:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261431AbREOUPI>; Tue, 15 May 2001 16:15:08 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:62110 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261429AbREOUPB>;
	Tue, 15 May 2001 16:15:01 -0400
Date: Tue, 15 May 2001 16:14:58 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: James Simmons <jsimmons@transvirtual.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <Pine.LNX.4.10.10105151151380.22038-100000@www.transvirtual.com>
Message-ID: <Pine.GSO.4.21.0105151607100.21081-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 May 2001, James Simmons wrote:

> > only one _device_node_, you can have multiple fd's. In fact, you can, with
> > the Linux VFS layer, fairly easily do things like
> > 
> > 	mknod /dev/fd0 c X Y
> > 
> > and then use
> > 
> > 	fd = open("/dev/fd0/colourspace", O_RDWR);
> 
> Yipes!! I have to say UNIX has a tendency to teach you ioctl is the only
> way. I have never thought outside of the box nor see anyone else in this
> manner. This is absolutely brillant!!! I can see alot of possibilties with
> this. 

The thing being, why thet hell create these device/directory hybrids?
Driver can export a tree and we mount it on fb0. After that you have
the whole set - yes, /dev/fb0/colourspace, etc. - no problem. And no
need to do mknod, BTW. Yes, we'll need to use /dev/fb0/frame for
frame itself. BFD...

You see, as soon as you want slightly more structured stuff (deeper than
one level) you need the dentry tree, yodda, yodda. IOW, you need a
filesystem anyway and it's easy to implement. Want me to do framebufferfs?
Would make a nice demo.  No majors. No minors. No ioctls. Less code than
in current tree.  ~3 days to implement.

