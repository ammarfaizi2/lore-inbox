Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130073AbRBSBoR>; Sun, 18 Feb 2001 20:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130436AbRBSBoJ>; Sun, 18 Feb 2001 20:44:09 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:62470 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S130073AbRBSBnv>;
	Sun, 18 Feb 2001 20:43:51 -0500
Date: Mon, 19 Feb 2001 02:43:30 +0100
From: Jens Axboe <axboe@suse.de>
To: Andries.Brouwer@cwi.nl
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, zzed@cyberdude.com
Subject: Re: [PROBLEM] 2.4.1 can't mount ext2 CD-ROM
Message-ID: <20010219024330.B8227@suse.de>
In-Reply-To: <UTC200102182111.WAA170825.aeb@vlet.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200102182111.WAA170825.aeb@vlet.cwi.nl>; from Andries.Brouwer@cwi.nl on Sun, Feb 18, 2001 at 10:11:36PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 18 2001, Andries.Brouwer@cwi.nl wrote:
>     > Strange. The twelve or so CD readers I have here are all
>     > able to read 512-byte sectors. I am quite willing to believe
> 
>     I think most Plextor and Yamaha do, but it's not guaranteed to
>     be supported. And it definitely won't for ATAPI with ide-scsi.
> 
> Strange. I just used ATAPI with ide-scsi as test. It works.

Yeah it works because sr does read padding on drives that can't dish
out 512b sectors... This is my point.

> Setting hardsect_size to 2048 means: this hardware is unable
> to use smaller blocks, give an error to whoever asks for
> something smaller.

Which is the case for some drives. The error now occurs when ext2
forcibly tries to set the block size.

> Not setting hardsect_size at all means: I have no idea what this
> hardware can do. Now it is up to the user. If the user tries
> something the hardware cannot do, she will get EIO.
> Limiting the user in advance is a bad idea.

Ok agreed, just forcing 2048 is a bit harsh but it was nicer than
letting sr bomb on 512b requests at the time.

-- 
Jens Axboe

