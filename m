Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264597AbSIQUbi>; Tue, 17 Sep 2002 16:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264602AbSIQUbi>; Tue, 17 Sep 2002 16:31:38 -0400
Received: from packet.digeo.com ([12.110.80.53]:25811 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264597AbSIQUbg>;
	Tue, 17 Sep 2002 16:31:36 -0400
Message-ID: <3D87924D.364C4884@digeo.com>
Date: Tue, 17 Sep 2002 13:36:29 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Anton Altaparmakov <aia21@cantab.net>, ptb@it.uc3m.es,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: route inode->block_device in 2.5?
References: <5.1.0.14.2.20020917132943.00b239e0@pop.cus.cam.ac.uk> <Pine.GSO.4.21.0209170845020.1645-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Sep 2002 20:36:29.0457 (UTC) FILETIME=[E6BE8010:01C25E89]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> ...
> There might be such thing as underlying block device of a <foofs> inode.

What he said.  Generally when the generic layers want to know
what the backing block_device is they defer this all the way down
to the point where they have called the filesystem's ->get_block
callback, and they pluck the block_dev pointer out of bh_result->b_bdev.

That's the only point at which it can be sanely resolved.

It may be different for different blocks of the file (striping;
swap_get_block() did this for the short period when it nearly
existed).
