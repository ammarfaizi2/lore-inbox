Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129627AbQLGEip>; Wed, 6 Dec 2000 23:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129581AbQLGEif>; Wed, 6 Dec 2000 23:38:35 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:39949 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129429AbQLGEi3>; Wed, 6 Dec 2000 23:38:29 -0500
Date: Wed, 6 Dec 2000 22:07:57 -0600
To: Reto Baettig <baettig@scs.ch>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: 64bit offsets for block devices ?
Message-ID: <20001206220757.N6567@cadcamlab.org>
In-Reply-To: <3A2E5227.693121F@scs.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A2E5227.693121F@scs.ch>; from baettig@scs.ch on Wed, Dec 06, 2000 at 06:50:15AM -0800
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Reto Baettig]
> Imagine we have a virtual disk which provides a 64bit (sparse)
> address room.  Unfortunately we can not use it as a block device
> because in a lot of places (including buffer_head structure), we're
> using a long or even an int for the block number.

Actually it should be 'unsigned long'.  If anyone uses 'long' or 'int',
I guess it's a bug.

> Is there any way of getting a standardized way of doing I/O to a block
> device which could handle 64bit addresses for the block number?

Yeah, tell the world you explicitly don't support 32-bit architectures.
Linux supports (to some degree) at least four 64-bit architectures,
where 'unsigned long' is nice and big.  And I imagine support for
POWER3 and HP-PA 2.0w are coming in the not-so-distant future.

Either that, or (since you say the address space is sparse) do your own
block mapping within the driver.  If you still need more than 32 bits,
you'll have to fudge it with multiple virtual devices.

> Don't you think that we will run into problems anyway because soon
> there will be raid systems with a couple of Terrabytes of space to
> waste for mp3's ;-)

A couple of terabytes is fine.  That's 32 bits of blocks.  *More* than
that, now, we've got a problem.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
