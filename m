Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130045AbRBYXvY>; Sun, 25 Feb 2001 18:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130044AbRBYXvP>; Sun, 25 Feb 2001 18:51:15 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:11277 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S130034AbRBYXvI>;
	Sun, 25 Feb 2001 18:51:08 -0500
Date: Mon, 26 Feb 2001 00:51:03 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][CFT] per-process namespaces for Linux
Message-ID: <20010226005103.V18271@almesberger.net>
In-Reply-To: <20010225225750.B19635@almesberger.net> <Pine.GSO.4.21.0102251702350.26808-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0102251702350.26808-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sun, Feb 25, 2001 at 05:39:16PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> No. Just an overmount.

Ah, too bad. Union mounts would have been really elegant (allowing the
operation to be repeated without residues, and also allowing umounting
of the covered FS as a sanity check). But I guess there's no way to
implement them without performance penalty ...

> Is it worth emptying?

Probably not ... the only interesting case would be if you could completely
umount it.

> BTW, Werner - could you take a look at the
> prepare_namespace()/handle_initrd()?

Okay, I'll have a look.

> That's our late boot process taken into one place. I'm really not happy
> about the following:

Agreed on all three counts. Also, change_root might just die by evolution,
just like most of NFS-root-from-initrd (using change_root) died.

What we need is a migration plan. Right now, it seems that most people
still use change_root. Hopefully they read the little message I left them
in linux/Documentation/initrd.txt:

  Current kernels still support it, but you should _not_ rely on its
  continued availability.

So with some luck, distributors will switch to pivot_root sometime soon,
when deploying 2.4. So if we drop all the old junk in 2.5, the amount of
letter bombs should be small ;-)

> Again, current patch reproduces the behaviour of the main tree.

Since you've already done all the work ... ;-) It's good if we can make
one change at a time.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
