Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262767AbREVUKr>; Tue, 22 May 2001 16:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262773AbREVUKh>; Tue, 22 May 2001 16:10:37 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:61630 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262767AbREVUKZ>;
	Tue, 22 May 2001 16:10:25 -0400
Date: Tue, 22 May 2001 16:10:23 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andries.Brouwer@cwi.nl
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] struct char_device
In-Reply-To: <UTC200105221952.VAA78718.aeb@vlet.cwi.nl>
Message-ID: <Pine.GSO.4.21.0105221605110.15685-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 22 May 2001 Andries.Brouwer@cwi.nl wrote:

> One remark, repeating what I wrote on some web page:
> -----
> A struct block_device provides the connection between a device number
> and a struct block_device_operations. 
> ...
> Clearly, we also want to associate a struct char_device_operations
> to a character device number. When we do this, all bdev code will

They are entirely different. Too different sets of operations.

> have to be duplicated for cdev, so there seems no point in having
> bdev code - kdev, for both bdev and cdev, seems more elegant. 
> -----

Not really. For struct block_device you have partitioning stuff sitting
nearby. It should be handled by generic code. Nothing of that kind for
character devices.

But the main point is that for block devices ->read() and ->write() do
not belong to the natural interface. Request queue does. They are about
as far from each other as from FIFOs and sockets.

> And a second remark: don't forget that presently the point where
> bdev is introduced is not quite right. We must only introduce it
> when we really have a device, not when there only is a device
> number (like on a mknod call).

That's simply wrong. kdev_t is used for unopened objects quite often.

