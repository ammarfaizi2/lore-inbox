Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277942AbRKNVWV>; Wed, 14 Nov 2001 16:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277782AbRKNVWL>; Wed, 14 Nov 2001 16:22:11 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:59133 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S277942AbRKNVVw>;
	Wed, 14 Nov 2001 16:21:52 -0500
Date: Wed, 14 Nov 2001 14:16:39 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: dalecki@evision.ag, linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: blocks or KB? (was: .. current meaning of blk_size array)
Message-ID: <20011114141639.P5739@lynx.no>
Mail-Followup-To: "Peter T. Breuer" <ptb@it.uc3m.es>, dalecki@evision.ag,
	linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3BF23D01.F7E879E8@evision-ventures.com> <200111142041.fAEKfBN15594@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <200111142041.fAEKfBN15594@oboe.it.uc3m.es>; from ptb@it.uc3m.es on Wed, Nov 14, 2001 at 09:41:11PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 14, 2001  21:41 +0100, Peter T. Breuer wrote:
>   "A month of sundays ago Martin Dalecki wrote:"
>   > "Peter T. Breuer" wrote:
>   > > Is blk_size[][] supposed to contain the size in KB or blocks?
>   > There is no rumor it's in blocks.
> 
> Maybe I misinterpret what you write. I interpret it as meaning "the
> rumour is not a rumour but a fact. It is in blocks".

Check what /proc/partitions shows us.  #blocks, with units of 1kB.
This has been standard in the kernel for a loooong time.

> The point is that if blk_size counts in KB, then the size of a device
> cannot reach more that 2^32 * 2^10 = 2^42 = 4TB.  I'd personally say
> 2TB, becuase the int blk_size number is signed.
> 
> That's rumoured not to be the case, and the max size of a device is
> supposed to be about 8 to 16TB. Let's suppose the rumour is true ..

Well, the rumor is wrong.  There has always been a single-device 1TB/2TB
limit in the kernel (2^31 or 2^32 * 512 byte sector size), and until
recently it has not been a problem.  To remove the problem Jens Axboe
(I think, or Ben LaHaise, can't remember) has a patch to support 64-bit
block counts and has been tested with > 2TB devices.

> So we deduce that one has to assign a different meaning for the blk_size
> array. "count in blocks" is how the rumour goes. That way you can get
> 4 times higher sizes .. all the way to 8 or 16TB per device. And this
> is what is rumoured to be the case.

Where do you get these rumors?

> It should be in blocks if the size of a device is to reach 8 or 16TB.
> If it is in KB, we are limited to 2 or 4TB.

In theory this is possible (it was discussed on the LVM list a bit), but
it would take a bunch of work to make it real.  For LVM (and MD RAID),
since we are dealing with multiple real devices < 2TB in size, we could
use a blocksize of 4kB to get a larger virtual device.  In the end this
only wins for a short time and you need 64-bit block numbers anyways.

> Persuade me that this is not a bug, and an important one at that :-)
> Hellloooooo everybody! Linux cannot manage partitions greater than
> 4TB, ha ha ha hhhhhaaaa! ;-)

And it can't handle more than 64GB of RAM on ia32 (was previously 1GB).
So what?  When a limit is reached for any reasonable number of people,
it is fixed.

> I at least am getting up to devicesizes at the 8TB range.

If you are in that ballpark, then get the 64-bit blocknumber patch, and
start testing/fixing, instead of complaining.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

