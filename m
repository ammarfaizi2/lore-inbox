Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264865AbRFYQbz>; Mon, 25 Jun 2001 12:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264868AbRFYQbq>; Mon, 25 Jun 2001 12:31:46 -0400
Received: from 20dyn20.com21.casema.net ([213.17.90.20]:23314 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S264865AbRFYQbb>; Mon, 25 Jun 2001 12:31:31 -0400
Message-Id: <200106251631.SAA09431@cave.bitwizard.nl>
Subject: Re: loop device broken in 2.4.6-pre5
In-Reply-To: <UTC200106212258.AAA370096.aeb@vlet.cwi.nl> from "Andries.Brouwer@cwi.nl"
 at "Jun 22, 2001 00:58:53 am"
To: Andries.Brouwer@cwi.nl
Date: Mon, 25 Jun 2001 18:31:07 +0200 (MEST)
CC: jari.ruusu@pp.inet.fi, torvalds@transmeta.com, axboe@suse.de,
        linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
>     From: Jari Ruusu <jari.ruusu@pp.inet.fi>
> 
>     File backed loop device on 4k block size ext2 filesystem:
> 
>     # dd if=/dev/zero of=file1 bs=1024 count=10
>     10+0 records in
>     10+0 records out
>     # losetup /dev/loop0 file1
>     # dd if=/dev/zero of=/dev/loop0 bs=1024 count=10 conv=notrunc
>     dd: /dev/loop0: No space left on device
>     9+0 records in
>     8+0 records out
>     # tune2fs -l /dev/hda1 2>&1| grep "Block size"
>     Block size:               4096
>     # uname -a
>     Linux debian 2.4.6-pre5 #1 Thu Jun 21 14:27:25 EEST 2001 i686 unknown
> 
>     Stock 2.4.5 and 2.4.5-ac15 don't have this problem.
> 
> I am not sure there is an error here.

How about:

dd if=/dev/hda1 of=disk.img bs=1k 
mount disk.img /mnt/d1 -o loop


If the filesystem on hda1 happens to use the last 2k of the partition,
and the partition size is 2k mod 4k, then I get a non-working disk.img
if I don't pad the disk.img file with another 2k. And then I might
trip up the "how big is this partition" code in the fs-driver....

				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
