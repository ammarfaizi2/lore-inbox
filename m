Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287865AbSAFNJi>; Sun, 6 Jan 2002 08:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288982AbSAFNJ2>; Sun, 6 Jan 2002 08:09:28 -0500
Received: from mail2.home.nl ([213.51.129.226]:24763 "EHLO mail2.home.nl")
	by vger.kernel.org with ESMTP id <S288983AbSAFNJE>;
	Sun, 6 Jan 2002 08:09:04 -0500
Message-ID: <3C384CB2.2040601@home.nl>
Date: Sun, 06 Jan 2002 14:10:10 +0100
From: Gertjan van Wingerde <gwingerde@home.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20020101
X-Accept-Language: en-us
MIME-Version: 1.0
To: Gertjan van Wingerde <gwingerde@home.nl>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: drivers/md compile fixes.
In-Reply-To: <3C384A97.8090909@home.nl>
Content-Type: multipart/mixed;
 boundary="------------030401060101050502080503"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030401060101050502080503
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Okay,

It seems that I f**ked up the patch creation. Actually only the first 
chunk of the patch is correct. New version of the patch attached.


         Best regards/MvG,

                 Gertjan.

Gertjan van Wingerde wrote:

> Hi,
> 
> The attached patch to 2.5.2-pre9 is necessary to get it to compile and
> to clean up some NODEV vs. mk_kdev(0, 0) usages.
> 
> 


-- 
	MvG,

		Gertjan

----------

Gertjan van Wingerde
Geessinkweg 177
7544 TX Enschede
The Netherlands
E-mail: gwingerde@home.nl

--------------030401060101050502080503
Content-Type: text/plain;
 name="linux-md.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-md.diff"

diff -u --recursive linux-2.5.2-pre8/drivers/md/md.c linux-2.5.x/drivers/md/md.c
--- linux-2.5.2-pre8/drivers/md/md.c	Sun Jan  6 11:28:53 2002
+++ linux-2.5.x/drivers/md/md.c	Sun Jan  6 11:30:03 2002
@@ -641,7 +641,7 @@
 	int err = 0;
 	struct block_device *bdev;
 
-	bdev = bdget(rdev->dev);
+	bdev = bdget(kdev_t_to_nr(rdev->dev));
 	if (!bdev)
 		return -ENOMEM;
 	err = blkdev_get(bdev, FMODE_READ|FMODE_WRITE, 0, BDEV_RAW);

--------------030401060101050502080503--

