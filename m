Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263213AbREWSnI>; Wed, 23 May 2001 14:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263214AbREWSm6>; Wed, 23 May 2001 14:42:58 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:45503 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S263213AbREWSmn>;
	Wed, 23 May 2001 14:42:43 -0400
Date: Wed, 23 May 2001 14:42:42 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andries.Brouwer@cwi.nl
cc: helgehaf@idb.hist.no, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] struct char_device
In-Reply-To: <UTC200105231828.UAA89871.aeb@vlet.cwi.nl>
Message-ID: <Pine.GSO.4.21.0105231430210.20269-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 23 May 2001 Andries.Brouwer@cwi.nl wrote:

> > Andries, initrd code is _sick_.
> 
> Oh, but the fact that there exists a bad implementation
> does not mean the idea is wrong. It is really easy to
> make an elegant implementation.

Andries, I've been doing cleanups of that logics (see namespaces-patch -
they've got merged into it) and I have to say that you are sadly mistaken.

It's not just an implementation that is ugly, it's behaviour currently
implemented (and relied upon by existing boot setups) that is extremely
ill-defined and crufty. I would rather get rid of the abortion, but that
is impossible without breaking tons of existing setups.

And that _is_ an area where "we can do something vaguely similar to
current behaviour that wouldn't take pages to describe" does not work.
You don't fsck with others' boot sequences, unless you want a free
tar-and-feather ride. I don't want it.

Besides, just on general principles, we'd better have clean interface
for changing partitioning on the kernel side and rip that crap out of
$BIGNUM fdisk implmentations. It can be made modular, so problem of
teaching it new types of partitions is not hard.

