Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262313AbRE3VKi>; Wed, 30 May 2001 17:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262309AbRE3VK2>; Wed, 30 May 2001 17:10:28 -0400
Received: from texlog2.texas.rr.com ([24.93.35.223]:44955 "EHLO
	texlog2.texas.rr.com") by vger.kernel.org with ESMTP
	id <S262276AbRE3VKM>; Wed, 30 May 2001 17:10:12 -0400
Date: Wed, 30 May 2001 16:11:00 +0000 (GMT)
From: Jeff Meininger <jeffm@boxybutgood.com>
To: linux-kernel@vger.kernel.org
Subject: determining size of cdrom
Message-ID: <Pine.LNX.4.21.0105301548120.296-100000@mangonel>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm not subscribed to the mailing list, so please Cc a copy of your
replies straight to my email address: jeffm@boxybutgood.com.


I'm trying to determine the raw size of a cdrom disc, as in the size of
the file you'd get by doing 'dd if=/dev/cdrom of=size_of_this.img'.

I've tried the following things (with a disc in the drive) without
success, and I'm hoping that someone will be able to point me in the right
direction.


struct stat s;
stat("/dev/cdrom", &s);
/* s.st_size is 0, s.st_blocks is 0.  */

int fd = open("/dev/cdrom", O_RDONLY);

off_t bytes = lseek(fd, 0, SEEK_END);
/* bytes is 0 */

long sectors = 0;
ioctl(fd, BLKGETSIZE, &sectors);
/* sectors varies (never seems accurate) and is usually LONG_MAX */
	
long ssz = 0;
ioctl(fd, BLKSSZGET, &ssz);
/* ssz varies, and is usually 1024. (shouldn't it be 2048?)  */

/* ioctl HDIO_GETGEO fails. */

/* ioctl HDIO_GET_IDENTITY returns 0's for the c/h/s values I'm looking
for.  */

I didn't find anything that looked obvious to me in linux/cdrom.h, except
in the #ifdef __KERNEL__ section which I don't believe I can use from
user space.

I hope I didn't miss something really obvious, but I've been at this
problem for a few days now (mostly spent reading docs and headers) and I'm
at the point where I'll risk asking something stupid.

Thanks!!

BTW, once again, I'm not subscribed to the mailing list, so please Cc a
copy of your replies straight to my email address: jeffm@boxybutgood.com.


