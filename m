Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312817AbSDKW5j>; Thu, 11 Apr 2002 18:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313012AbSDKW5i>; Thu, 11 Apr 2002 18:57:38 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:20987 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S312817AbSDKW5i>; Thu, 11 Apr 2002 18:57:38 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Thu, 11 Apr 2002 16:55:36 -0600
To: Andrew Morton <akpm@zip.com.au>
Cc: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [prepatch] address_space-based writeback
Message-ID: <20020411225536.GE8062@turbolinux.com>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	Alexander Viro <viro@math.psu.edu>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <a94r5k$m23$1@penguin.transmeta.com> <Pine.GSO.4.21.0204111629370.21089-100000@weyl.math.psu.edu> <3CB5FFB5.693E7755@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 11, 2002  14:27 -0700, Andrew Morton wrote:
> One thing I'm not clear on with the private metadata address_space
> concept: how will it handle blocksize less than PAGE_CACHE_SIZE? 
> The only means we have at present of representing sub-page
> segments is the buffer_head.  Do we want to generalise the buffer
> layer so that it can be applied against private address_spaces?
> That wouldn't be a big leap.

I was going to send you an email on this previously, but I (think I)
didn't in the end...

At one time Linus proposed having an array of dirty bits for a page,
which would allow us to mark only parts of a page dirty (say down to
the sector level).  I believe this was in the discussion about moving
the block devices to the page cache around 2.4.10.

While that isn't a huge win in the most cases (it costs the same to
write 512 bytes as 4096 bytes to disk because of disk latencies) it may
be more important if/when we ever have larger pages.  This also becomes
more important if you are working with a network filesystem where you
have to send all of the dirty data over a much smaller pipe, so sending
512 bytes takes 1/8 as long as sending 4096 bytes.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

