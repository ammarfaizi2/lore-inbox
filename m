Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272985AbRIRREJ>; Tue, 18 Sep 2001 13:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272989AbRIRREA>; Tue, 18 Sep 2001 13:04:00 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8205 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S272985AbRIRRDx>; Tue, 18 Sep 2001 13:03:53 -0400
Date: Tue, 18 Sep 2001 10:02:55 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Alexander Viro <viro@math.psu.edu>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
In-Reply-To: <20010918121716.D2723@athlon.random>
Message-ID: <Pine.LNX.4.33.0109180956070.2077-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Sep 2001, Andrea Arcangeli wrote:
> >
> > What are you going to use as mapping->host for it?
>
> the only info we'd need from the host is the host->i_rdev, so why can't
> we get it from the file->f_dentry->d_inode->i_rdev?

No, just allocate a real inode as part of "struct block_device"
allocation. This is basically what socket etc stuff does - and it's
actually easiest to do it the other way, exactly like sockets do (ie
_embed_ "struct block_device"  inside a struct inode as if "block_device"
was just another filesystem), and then just allocate one inode and get the
"struct block_device"  allocation for free.

This works really well for sockets, and has worked for a long time. See
how the socket is hidden in "inode->u.socket_i", and how it's trivial to
convert from one to the other.

And the fact is, a block_device _is_ a simple filesystem if you squint
just the right way. Admittedly it's a fairly flat and _boring_ filesystem,
but hey, that's the point of them, after all ;)

			Linus

