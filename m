Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261190AbREMNL2>; Sun, 13 May 2001 09:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261264AbREMNLT>; Sun, 13 May 2001 09:11:19 -0400
Received: from adsl-204-0-249-112.corp.se.verio.net ([204.0.249.112]:56053
	"EHLO tabby.cats-chateau.net") by vger.kernel.org with ESMTP
	id <S261190AbREMNLH>; Sun, 13 May 2001 09:11:07 -0400
From: Jesse Pollard <jesse@cats-chateau.net>
Reply-To: jesse@cats-chateau.net
To: Alexander Viro <viro@math.psu.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: mount /dev/hdb2 /usr; swapon /dev/hdb2 keeps flooding
Date: Sun, 13 May 2001 08:04:26 -0500
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: BERECZ Szabolcs <szabi@inf.elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0105121939310.11973-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0105121939310.11973-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Message-Id: <01051308104500.22790@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 May 2001, Alexander Viro wrote:
>On Sun, 13 May 2001, Alan Cox wrote:
>
>> > > root@kama3:/home/szabi# cat /proc/mounts
>> > > /dev/hdb2 /usr ext2 rw 0 0
>> > > root@kama3:/home/szabi# swapon /dev/hdb2
>> > 
>> > - Doctor, it hurts when I do it!
>> > - Don't do it, then.
>> > 
>> > Just what behaviour had you expected?
>> 
>> EBUSY would be somewhat nicer.
>
>Probably. Try to convince Linus that we need such exclusion. All stuff
>needed to implement it is already there - see blkdev_open() for details.
>OTOH, as long as kernel itself survives that... In this case I can see
>the point in "give them enough rope" approach.

It doesn't matter .... The device is not a swap partition - from the
original message:
> root@kama3:/home/szabi# swapon /dev/hdb2
> set_blocksize: b_count 1, dev ide0(3,66), block 2, from c0126b48
> set_blocksize: b_count 1, dev ide0(3,66), block 3, from c0126b48
> set_blocksize: b_count 1, dev ide0(3,66), block 4, from c0126b48
> set_blocksize: b_count 1, dev ide0(3,66), block 5, from c0126b48
> set_blocksize: b_count 1, dev ide0(3,66), block 6, from c0126b48
> set_blocksize: b_count 1, dev ide0(3,66), block 7, from c0126b48
> set_blocksize: b_count 1, dev ide0(3,66), block 8, from c0126b48
> set_blocksize: b_count 1, dev ide0(3,66), block 1, from c0126b48
> Unable to find swap-space signature
> swapon: /dev/hdb2: Invalid argument

The error message is quite clear (the set blocksize isn't, but that
is during the identification and isn't an error, but appears to be
a status..).

If you are going to swap on a mounted file system, then you have to
specify a swap file, formatted for swap.

The message that was output says exactly what is needed for protecting
against configuration errors.

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: jesse@cats-chateau.net

Any opinions expressed are solely my own.
