Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261396AbSIWTGb>; Mon, 23 Sep 2002 15:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261404AbSIWTFl>; Mon, 23 Sep 2002 15:05:41 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:65218 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261396AbSIWTEr>;
	Mon, 23 Sep 2002 15:04:47 -0400
Date: Mon, 23 Sep 2002 15:09:53 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.37 broke the floppy driver
In-Reply-To: <15759.25411.512115.64467@kim.it.uu.se>
Message-ID: <Pine.GSO.4.21.0209231507370.3948-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 23 Sep 2002, Mikael Pettersson wrote:

> With O100-get_gendisk-C38 the oops is cured, but the floppy size is
> still wrong. Freshly booted, dd if=/dev/fd0H1440 bs=72k of=/dev/null
> reads only 720K instead of 1440K. Same thing on write: trying to
> write more than 720K results in an ENOSPC error.


Arrrgh.  O/O101-floppy_sizes-C38 and it's also my fsckup - missed the
size in kilobytes/size in sectors.  Fortunately that kind of crap is
over - blk_size[] is no more...

