Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262940AbSJBDFk>; Tue, 1 Oct 2002 23:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262943AbSJBDFk>; Tue, 1 Oct 2002 23:05:40 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:39685 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262940AbSJBDFj>; Tue, 1 Oct 2002 23:05:39 -0400
Date: Tue, 1 Oct 2002 20:12:28 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Christoph Hellwig <hch@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.40 - and a feature freeze reminder
In-Reply-To: <Pine.GSO.4.21.0210012037040.9782-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.44.0210012007240.7688-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 1 Oct 2002, Alexander Viro wrote:
> 
> Umm...  Speaking of 32bit dev_t, I'd rather do it right way.

Hey, if you drive that part, I'll be very happy. 

I don't doubt you can fix up the block device handling quite nicely by 
now, but I worry about all the other crud, including how to make the 
interfaces be backwards-compatible etc, and making sure we convert 
correctly in all the right places.

The explicit dev_t<->kdev_t conversion has fixed only a subset of the
problems, and we still use dev_t as keys into things (ie we have this
notion that two different dev_t never map to the same "bdev *", for
example - which totally breaks aliases etc).

There's also all the user-level interfaces for dev_t, and the disk layout 
interfaces used by various filesystems.

We can easily make kdev_t be 32-bit, but without a 32-bit dev_t that 
doesn't help much.

			Linus

