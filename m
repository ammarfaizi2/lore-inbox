Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263291AbSJCOb7>; Thu, 3 Oct 2002 10:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263296AbSJCOb7>; Thu, 3 Oct 2002 10:31:59 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:64979 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S263291AbSJCOb6>;
	Thu, 3 Oct 2002 10:31:58 -0400
Date: Thu, 3 Oct 2002 10:37:28 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: initrd breakage in 2.5.38-2.5.40
In-Reply-To: <15772.12175.196556.383774@kim.it.uu.se>
Message-ID: <Pine.GSO.4.21.0210031035160.15787-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 3 Oct 2002, Mikael Pettersson wrote:

> That loop does set_capacity() on each element in rd_disks[], but
> set_capacity(disk,size) just sets disk->capacity = size, and
> initrd_disk is a different variable so I don't see how initrd_disk
> could ever get a capacity assigned to it unless by an explicit
> "set_capacity(&initrd_disk, rd_size * 2);".

_Oh_.

Yes, you are right - it's my fault.  FWIW, it should be
	(initrd_end-initrd_start+511)>>9
rather than rd_size * 2.  Thanks, fixed in my tree, will go to Linus
today.

