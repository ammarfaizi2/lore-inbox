Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285020AbRLQGGT>; Mon, 17 Dec 2001 01:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285023AbRLQGGJ>; Mon, 17 Dec 2001 01:06:09 -0500
Received: from mail.linpro.no ([213.203.57.2]:46342 "HELO linpro.no")
	by vger.kernel.org with SMTP id <S285020AbRLQGGB>;
	Mon, 17 Dec 2001 01:06:01 -0500
To: <linux-kernel@vger.kernel.org>
Subject: Re: Compilation of 2.5.1-pre11 fails w/LVM as module
In-Reply-To: <33364.62.211.145.13.1008513364.squirrel@gtsmail.gts.it>
From: Thorkild Stray <thorkild@linpro.no>
Date: 17 Dec 2001 07:05:58 +0100
In-Reply-To: <33364.62.211.145.13.1008513364.squirrel@gtsmail.gts.it>
Message-ID: <nnd71efkjd.fsf@false.linpro.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<s.rivoir@gts.it> writes:

> As stated in the subject, this is 'make modules' output:
> 
> make[2]: Entering directory `/us2/usr/src/linux/drivers/md'
> gcc -D__KERNEL__ -I/us2/usr/src/linux/include -Wall -Wstrict-prototypes
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing-fno-common -pipe -mpreferred-stack-boundary=2 -march=i686
> -malign-functions=4  -DMODULE   -c -o lvm.o lvm.clvm.c: In function `lvm_user_bmap':
> lvm.c:1046: request for member `bv_len' in something not a structure or union
> make[2]: *** [lvm.o] Error 1
> make[2]: Leaving directory `/us2/usr/src/linux/drivers/md'
> make[1]: *** [_modsubdir_md] Error 2
> make[1]: Leaving directory `/us2/usr/src/linux/drivers'
> make: *** [_mod_drivers] Error 2
> Sorry if already issued by someone else :)

This can be fixed (so that is compiles) by just changing line 1046 from:

bio.bi_io_vec.bv_len = lvm_get_blksize(bio.bi_dev);

to

bio.bi_io_vec->bv_len = lvm_get_blksize(bio.bi_dev);

This is due to changes in the I/O layer. You used to only have one
bio_vec struct in the bio struct, but now it has changed to a linked
list.

Warning: This makes it compile, but it does not necessarily make it
work, but I might. :) Since the rest of LVM hasn't been changed to
use the new linked-list-possibility, it shouldn't make a difference.


-- 
Thorkild Stray, Linpro AS                              <thorkild@linpro.no>
