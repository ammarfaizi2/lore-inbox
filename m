Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269960AbRHEOO0>; Sun, 5 Aug 2001 10:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269964AbRHEOOQ>; Sun, 5 Aug 2001 10:14:16 -0400
Received: from weta.f00f.org ([203.167.249.89]:43664 "EHLO weta.f00f.org")
	by vger.kernel.org with ESMTP id <S269960AbRHEOOD>;
	Sun, 5 Aug 2001 10:14:03 -0400
Date: Mon, 6 Aug 2001 02:14:55 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Nico Schottelius <nicos@pcsystems.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ext3/reiserfs: ext3fine, reiser got OOPS!
Message-ID: <20010806021455.B21919@weta.f00f.org>
In-Reply-To: <3B6CAE4E.17850717@pcsystems.de> <20010805172718.B20716@weta.f00f.org> <3B6D4738.6F77A5E0@pcsystems.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B6D4738.6F77A5E0@pcsystems.de>
User-Agent: Mutt/1.3.20i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 05, 2001 at 03:16:40PM +0200, Nico Schottelius wrote:

    Mount and delete.

    reiserfs

    I created 200000 empty files, and then deleted them.

In many cases (ie. lots of files in a small number of directories),
reiserfs is _much_ faster then ext2 and ext3.

This is fairly well established.

For example, on a rather humble machine (dual PIII 866) the time to
extract a while bunch of files, including compression time and delete
them (whilst the machine was doing other things):


cw:tty2@tapu(cw)$ /usr/bin/time tx archive/freedb/freedb-complete-20010617.tar.bz2
128.87user 152.89system 5:33.36elapsed 84%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (2141major+2086minor)pagefaults 0swaps

cw:tty2@tapu(cw)$ du -s freedb-complete-20010617/
1380821 freedb-complete-20010617

cw:tty2@tapu(cw)$ find freedb-complete-20010617/ -type f -print|wc -l
 350065

cw:tty2@tapu(cw)$ ls -F freedb-complete-20010617/
COPYING  blues/      country/  folk/  misc/    reggae/  soundtrack/
README   classical/  data/     jazz/  newage/  rock/

<stress memory and cause swapping to purge much of page cache>

cw:tty2@tapu(cw)$ /usr/bin/time rm -rf freedb-complete-20010617/
0.68user 66.48system 3:22.71elapsed 33%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (111major+17minor)pagefaults 0swaps

Hot-cache, the delete time is about 15seconds from memory (I posted
results to the reiserfs list a few weeks back).




  --cw
