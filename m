Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277371AbRKSU0U>; Mon, 19 Nov 2001 15:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277382AbRKSU0K>; Mon, 19 Nov 2001 15:26:10 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:48401 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S277371AbRKSUZz>; Mon, 19 Nov 2001 15:25:55 -0500
Date: Mon, 19 Nov 2001 12:20:42 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] problem with grow_dev_page()/readpage()
In-Reply-To: <Pine.GSO.4.21.0111191501000.19969-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0111191217390.8460-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Nov 2001, Alexander Viro wrote:
>
> That breaks if you do bread() on something less than hardware sector size,
> though.  Then all following attempts to read that page (until ->buffers
> is evicted) will keep trying to submit IO on too small buffers.

I don't think that can happen - you can only bread with i_blksize, and the
set_blocksize() stuff refuses to set to smaller than the hardware sector
size.

See

        /* Size cannot be smaller than the size supported by the device */
        if (size < get_hardsect_size(dev))
                return -EINVAL;

in set_blocksize().

		Linus

