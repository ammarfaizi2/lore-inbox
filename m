Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262315AbRE3VP2>; Wed, 30 May 2001 17:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262632AbRE3VPS>; Wed, 30 May 2001 17:15:18 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:8453 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262315AbRE3VPN>;
	Wed, 30 May 2001 17:15:13 -0400
Date: Wed, 30 May 2001 23:15:09 +0200
From: Jens Axboe <axboe@kernel.org>
To: Jeff Meininger <jeffm@boxybutgood.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: determining size of cdrom
Message-ID: <20010530231509.D25129@suse.de>
In-Reply-To: <Pine.LNX.4.21.0105301548120.296-100000@mangonel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0105301548120.296-100000@mangonel>; from jeffm@boxybutgood.com on Wed, May 30, 2001 at 04:11:00PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30 2001, Jeff Meininger wrote:
> 
> I'm not subscribed to the mailing list, so please Cc a copy of your
> replies straight to my email address: jeffm@boxybutgood.com.
> 
> 
> I'm trying to determine the raw size of a cdrom disc, as in the size of
> the file you'd get by doing 'dd if=/dev/cdrom of=size_of_this.img'.
> 
> I've tried the following things (with a disc in the drive) without
> success, and I'm hoping that someone will be able to point me in the right
> direction.
> 
> 
> struct stat s;
> stat("/dev/cdrom", &s);
> /* s.st_size is 0, s.st_blocks is 0.  */
> 
> int fd = open("/dev/cdrom", O_RDONLY);
> 
> off_t bytes = lseek(fd, 0, SEEK_END);
> /* bytes is 0 */
> 
> long sectors = 0;
> ioctl(fd, BLKGETSIZE, &sectors);
> /* sectors varies (never seems accurate) and is usually LONG_MAX */

At least this is the capacity as reported by the drive when we read the
table of contents.

> long ssz = 0;
> ioctl(fd, BLKSSZGET, &ssz);
> /* ssz varies, and is usually 1024. (shouldn't it be 2048?)  */

Someone added a block size setting of 1024 to ide revalidate, and this
has screwed us for a awhile (ie atapi dvd-ram breaks). Recent ac has the
correct stuff to reset it.

> /* ioctl HDIO_GETGEO fails. */
> 
> /* ioctl HDIO_GET_IDENTITY returns 0's for the c/h/s values I'm looking
> for.  */
> 
> I didn't find anything that looked obvious to me in linux/cdrom.h, except
> in the #ifdef __KERNEL__ section which I don't believe I can use from
> user space.

You can do it from user space with CDROMREADTOCHDR/CDROMREATOCENTRY if
you want, did you see those?

-- 
Jens Axboe

