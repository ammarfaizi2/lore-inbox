Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129718AbRBRUug>; Sun, 18 Feb 2001 15:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129767AbRBRUu0>; Sun, 18 Feb 2001 15:50:26 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:19974 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129718AbRBRUuS>;
	Sun, 18 Feb 2001 15:50:18 -0500
Date: Sun, 18 Feb 2001 21:49:55 +0100
From: Jens Axboe <axboe@suse.de>
To: Andries.Brouwer@cwi.nl
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, zzed@cyberdude.com
Subject: Re: [PROBLEM] 2.4.1 can't mount ext2 CD-ROM
Message-ID: <20010218214955.C6593@suse.de>
In-Reply-To: <UTC200102181934.UAA168081.aeb@vlet.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200102181934.UAA168081.aeb@vlet.cwi.nl>; from Andries.Brouwer@cwi.nl on Sun, Feb 18, 2001 at 08:34:03PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 18 2001, Andries.Brouwer@cwi.nl wrote:
>     > A value of hardsect_size[] means: this is the smallest size
>     > the hardware can work with. It is therefore a serious mistake
>     > just to come with "a good guess". This value is used only
> 
>     You are defeating the entire purpose of having a hardware sector
>     size independently from the software block size. And 2kB is a
>     valid guess, apart from the drives that do 512 byte transfers too
>     2kB is really the smallest transfer we can do.
> 
> : And 2kB is a valid guess
> 
> Strange. The twelve or so CD readers I have here are all
> able to read 512-byte sectors. I am quite willing to believe

I think most Plextor and Yamaha do, but it's not guaranteed to
be supported. And it definitely won't for ATAPI with ide-scsi.
Did you verify that changing block size works? Just curious.

> that hardware exists that is unable to, but it is a bad idea
> to refuse to mount filesystems just because of some "good guess"
> that was not so good at all.

By far most media used will be 2kB based, so it is a good guess. Of course
we change it if we switch the block size.

>     So put 0 and sure anyone can submit I/O on the size that they want.
>     Now the driver has to support padding reads, or gathering data to do
>     a complete block write. This is silly. Sr should support 512b transfers
>     just fine, but only because I added the necessary _hacks_ to support
>     it. sd doesn't right now for instance.
> 
> Please calm down. Removing this sr_hardsizes nonsense

I'm perfectly calm.

> is a good idea today. No padding reads involved.
> If you disagree, please go slowly and state very explicitly
> why you think I should be unable to mount ext2 filesystems with
> a block size smaller than 2048 on my SCSI CD drive.

I don't think you should be unable to, of course we would want to
support 1kB ext2 and other file systems that want to change the block
size. We are just disagreeing on how to do it. I don't think counting
on being able to change the block size of a device at will always
be reliable.

-- 
Jens Axboe

