Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129224AbRBRTRQ>; Sun, 18 Feb 2001 14:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129944AbRBRTRG>; Sun, 18 Feb 2001 14:17:06 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:8454 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129940AbRBRTRA>;
	Sun, 18 Feb 2001 14:17:00 -0500
Date: Sun, 18 Feb 2001 20:16:39 +0100
From: Jens Axboe <axboe@suse.de>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, zzed@cyberdude.com, alan@lxorguk.ukuu.org.uk
Subject: Re: [PROBLEM] 2.4.1 can't mount ext2 CD-ROM
Message-ID: <20010218201639.A6593@suse.de>
In-Reply-To: <UTC200102181749.SAA171185.aeb@vlet.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200102181749.SAA171185.aeb@vlet.cwi.nl>; from Andries.Brouwer@cwi.nl on Sun, Feb 18, 2001 at 06:49:26PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 18 2001, Andries.Brouwer@cwi.nl wrote:
> Someone has added
>         /*
>          * These are good guesses for the time being.
>          */
>         for (i = 0; i < sr_template.dev_max; i++) {
>                 sr_blocksizes[i] = 2048;
>                 sr_hardsizes[i] = 2048;
>         }
>         blksize_size[MAJOR_NR] = sr_blocksizes;
>         hardsect_size[MAJOR_NR] = sr_hardsizes;
> setting of hardsect_size to drivers/scsi/sr.c.
> 
> A value of hardsect_size[] means: this is the smallest size
> the hardware can work with. It is therefore a serious mistake
> just to come with "a good guess". This value is used only

You are defeating the entire purpose of having a hardware sector
size independently from the software block size. And 2kB is a
valid guess, apart from the drives that do 512 byte transfers too
2kB is really the smallest transfer we can do.

> to reject impossible sizes, and everywhere the kernel accepts 0
> meaning "don't know".

So put 0 and sure anyone can submit I/O on the size that they want.
Now the driver has to support padding reads, or gathering data to do
a complete block write. This is silly. Sr should support 512b transfers
just fine, but only because I added the necessary _hacks_ to support
it. sd doesn't right now for instance.

In my oppinion we are always going to have hacks like this unless we
add some generic support for < hardware submission of I/O. Simply
ignoring this issue only makes it worse.

-- 
Jens Axboe

