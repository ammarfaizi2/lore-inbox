Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261325AbSIWT7B>; Mon, 23 Sep 2002 15:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261327AbSIWT7B>; Mon, 23 Sep 2002 15:59:01 -0400
Received: from kim.it.uu.se ([130.238.12.178]:34480 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S261325AbSIWT67>;
	Mon, 23 Sep 2002 15:58:59 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15759.29621.741797.479861@kim.it.uu.se>
Date: Mon, 23 Sep 2002 22:04:05 +0200
To: Alexander Viro <viro@math.psu.edu>
Cc: Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.37 broke the floppy driver
In-Reply-To: <Pine.GSO.4.21.0209231507370.3948-100000@weyl.math.psu.edu>
References: <15759.25411.512115.64467@kim.it.uu.se>
	<Pine.GSO.4.21.0209231507370.3948-100000@weyl.math.psu.edu>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
 > 
 > 
 > On Mon, 23 Sep 2002, Mikael Pettersson wrote:
 > 
 > > With O100-get_gendisk-C38 the oops is cured, but the floppy size is
 > > still wrong. Freshly booted, dd if=/dev/fd0H1440 bs=72k of=/dev/null
 > > reads only 720K instead of 1440K. Same thing on write: trying to
 > > write more than 720K results in an ENOSPC error.
 > 
 > 
 > Arrrgh.  O/O101-floppy_sizes-C38 and it's also my fsckup - missed the
 > size in kilobytes/size in sectors.  Fortunately that kind of crap is
 > over - blk_size[] is no more...

With that patch the /dev/fd0H1440 device now seems to work. However,
the /dev/fd0 (autosensing) device gets its very first read or write
after boot wrong. For example, dd if=/dev/fd0 bs=8k count=1 of=/dev/null
only reads 4096 bytes, and likewise a write will only write 4096 bytes
before reporting ENOSPC. Accesses after the first work though.
