Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291252AbSBUJzR>; Thu, 21 Feb 2002 04:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291257AbSBUJzJ>; Thu, 21 Feb 2002 04:55:09 -0500
Received: from hera.cwi.nl ([192.16.191.8]:22676 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S291252AbSBUJyy>;
	Thu, 21 Feb 2002 04:54:54 -0500
From: Andries.Brouwer@cwi.nl
Date: Thu, 21 Feb 2002 10:54:44 +0100 (MET)
Message-Id: <UTC200202210954.g1L9siM06287.aeb@apps.cwi.nl>
To: bcrl@redhat.com, phillips@bonn-fries.net
Subject: Re: [PATCH] size-in-bytes
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Benjamin LaHaise <bcrl@redhat.com>

    Using the number of sectors in kernel is perhaps more efficient, but it 
    is a microoptimization that won't show up on any benchmarks.

Yes. Since we have to go to 64-bit anyway it is not more
space-efficient, but of course shifting over 3 positions
is slightly faster than shifting over 12 positions.
But as you say, timewise there is no measurable difference,
while the code becomes much simpler.

There is also the point that a block device need not have a size
that is an integral number of sectors. That is most obvious with
the loop device, but also occurs elsewhere.
The partition making ioctls (and the loop mount options) allow one
to give a starting offset in bytes.

Thus, there are applications where it is really useful to have
the precise size, rather than the approximate size in sectors.
Also nbd uses the size in bytes, while amiga uses 256-byte sectors.

Andries

