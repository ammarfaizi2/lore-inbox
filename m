Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282302AbRKWX4q>; Fri, 23 Nov 2001 18:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282294AbRKWX4k>; Fri, 23 Nov 2001 18:56:40 -0500
Received: from [212.18.232.186] ([212.18.232.186]:56837 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S282305AbRKWX42>; Fri, 23 Nov 2001 18:56:28 -0500
Date: Fri, 23 Nov 2001 23:56:11 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Jahn Veach <V64@Galaxy42.com>
Cc: linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Re: 2.4.15 + fs corruption.
Message-ID: <20011123235611.E3141@flint.arm.linux.org.uk>
In-Reply-To: <013601c17479$933f0450$2b910404@Molybdenum>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <013601c17479$933f0450$2b910404@Molybdenum>; from V64@Galaxy42.com on Fri, Nov 23, 2001 at 05:50:03PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2001 at 05:50:03PM -0600, Jahn Veach wrote:
> What kind of breakage are we looking at here? I had a system that ran 2.4.15
> and got shut down without a sync. What kind of corruption will occur and is
> it something a simple fsck will fix?

fsck does seem to fix it, but it won't automatically detect the problem
(since the filesystem is marked clean).

It basically removes the inodes from the disk, but leaves the names in
the directory.  On the next boot, init scripts which clear out certain
directories fail, and various daemons fail to start because of it.

It seems that the only solution is to force a fsck at boot:

	shutdown -F -r now

should do the trick.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

