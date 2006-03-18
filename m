Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751908AbWCRF6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751908AbWCRF6R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 00:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751922AbWCRF6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 00:58:17 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:29410 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1751908AbWCRF6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 00:58:16 -0500
Message-ID: <00e801c64a50$e4c82980$4168010a@bsd.tnes.nec.co.jp>
From: "Takashi Sato" <sho@bsd.tnes.nec.co.jp>
To: "Badari Pulavarty" <pbadari@gmail.com>
Cc: "lkml" <linux-kernel@vger.kernel.org>,
       "ext2-devel" <Ext2-devel@lists.sourceforge.net>
References: <000401c6482d$880adfa0$4168010a@bsd.tnes.nec.co.jp> <1142630359.15257.30.camel@dyn9047017100.beaverton.ibm.com>
Subject: Re: [Ext2-devel] [PATCH 2/2] ext2/3: Support 2^32-1blocks(e2fsprogs)
Date: Sat, 18 Mar 2006 14:57:47 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-2022-jp";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Hi,
> 
> Few comments on the patches:
> 
> 1) Both kernel patch and e2fsprogs doesn't seem to apply cleanly for
> the versions you mentioned. I had to fix few rejects.

Sorry. My patches were corrupted because my poor mailer had
removed spaces in the patch.
I will take care of it when I update this patch.

> 2) I am still not able to make filesystem bigger than 8TB with your
> patch. I get following message.
> 
> # fdisk -l /dev/md0
> 
> Disk /dev/md0: 10479.7 GB, 10479753756672 bytes
> 2 heads, 4 sectors/track, -1736433664 cylinders
> Units = cylinders of 8 * 512 = 4096 bytes
> 
> 
> elm3b29:~/e2fsprogs-1.38/misc # ./mke2fs /dev/md0
> mke2fs 1.38 (30-Jun-2005)
> mke2fs: Filesystem too large.  No more than 2**31-1 blocks
>         (8TB using a blocksize of 4k) are currently supported.
> 
> When I try to create "ext3":

As I said in my previous mail, You should specify -F option to
create ext2/3 which has more than 2**31-1 blocks.
It is because of the compatibility.

> elm3b29:~/e2fsprogs-1.38/misc # ./mke2fs -t ext3 /dev/md0
> mke2fs 1.38 (30-Jun-2005)
> mke2fs: invalid blocks count - /dev/md0
> 
> Were you able to test these changes ?

You should specify -j option to create ext3 as below.

# ./mke2fs -j /dev/md0
