Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263243AbSJCLrT>; Thu, 3 Oct 2002 07:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263244AbSJCLrT>; Thu, 3 Oct 2002 07:47:19 -0400
Received: from kim.it.uu.se ([130.238.12.178]:38325 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S263243AbSJCLrT>;
	Thu, 3 Oct 2002 07:47:19 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15772.12175.196556.383774@kim.it.uu.se>
Date: Thu, 3 Oct 2002 13:52:47 +0200
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: initrd breakage in 2.5.38-2.5.40
In-Reply-To: <Pine.GSO.4.21.0210030702500.13480-100000@weyl.math.psu.edu>
References: <15772.9013.244887.809979@kim.it.uu.se>
	<Pine.GSO.4.21.0210030702500.13480-100000@weyl.math.psu.edu>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
 > 
 > 
 > On Thu, 3 Oct 2002, Mikael Pettersson wrote:
 > 
 > > First I thought the problem was caused by a apparently missing
 > > set_capacity() call in 2.5.38's drivers/block/rd.c:
 > 
 > I _really_ doubt it - check the loop just above the add_disk() one.
 > set_capacity() call is done there, repeating it won't change anything.

That loop does set_capacity() on each element in rd_disks[], but
set_capacity(disk,size) just sets disk->capacity = size, and
initrd_disk is a different variable so I don't see how initrd_disk
could ever get a capacity assigned to it unless by an explicit
"set_capacity(&initrd_disk, rd_size * 2);".

/Mikael
