Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261303AbSIWSxz>; Mon, 23 Sep 2002 14:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261380AbSIWSxO>; Mon, 23 Sep 2002 14:53:14 -0400
Received: from kim.it.uu.se ([130.238.12.178]:16304 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S261318AbSIWSss>;
	Mon, 23 Sep 2002 14:48:48 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15759.25411.512115.64467@kim.it.uu.se>
Date: Mon, 23 Sep 2002 20:53:55 +0200
To: Alexander Viro <viro@math.psu.edu>
Cc: Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
       Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.37 broke the floppy driver
In-Reply-To: <Pine.GSO.4.21.0209231104090.3948-100000@weyl.math.psu.edu>
References: <20020923145253.GG9178@suse.de>
	<Pine.GSO.4.21.0209231104090.3948-100000@weyl.math.psu.edu>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
 > 
 > 
 > On Mon, 23 Sep 2002, Jens Axboe wrote:
 > 
 > > Al? The first bug was a legitimate partial completion error in
 > > ll_rw_blk, however there appears to be other breakage hitting floppy as
 > > well.
 > 
 > The third is my fault - I've screwed up reordering patches; get_gendisk
 > prototype change should've been submitted before floppy gendisks.  Missing
 > patch is O/O100-get_gendisk-C38 in usual place, I'll send it to Linus
 > when I finish with the next 4 chunks (ubd fixes on top of jdike's ones +
 > unexporting register_disk() + tapeblock switch to gendisk + removal of
 > "what if opened device has no gendisk" logics).  No comments on the
 > second one, though.

With O100-get_gendisk-C38 the oops is cured, but the floppy size is
still wrong. Freshly booted, dd if=/dev/fd0H1440 bs=72k of=/dev/null
reads only 720K instead of 1440K. Same thing on write: trying to
write more than 720K results in an ENOSPC error.
