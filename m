Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268434AbRHAWEt>; Wed, 1 Aug 2001 18:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268441AbRHAWEg>; Wed, 1 Aug 2001 18:04:36 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:59384 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S268434AbRHAWEZ>; Wed, 1 Aug 2001 18:04:25 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200108012204.f71M4Bo0007352@webber.adilger.int>
Subject: Re: repeated failed open()'s results in lots of used memory [Was: [Fwd:
 memory consumption]]
In-Reply-To: <3B686D73.6040602@starentnetworks.com> "from Brian Ristuccia at
 Aug 1, 2001 04:58:27 pm"
To: Brian Ristuccia <bristuccia@starentnetworks.com>
Date: Wed, 1 Aug 2001 16:04:10 -0600 (MDT)
CC: linux-kernel@vger.kernel.org, djohnson@starentnetworks.com
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You write:
> We've been experiencing a problem where an errant process would run in a 
> tight loop trying to create files in a directory where it did not have 
> access. While this errant process was running, we'd notice all of the 
> available memory shift from buffers/cache (or free) to used and stay 
> that way while the process was running. vmstat also reports heavy in/out 
> traffic on the swap, but swap consumption does not grow past a few dozen 
> megabytes. The memory used by the process itself does not grow.
> 
> Note that we increase the default values for certain FS parameters:
> 
> echo '16384' >/proc/sys/fs/super-max
> echo '32768' >/proc/sys/fs/file-max
> echo '65535' > /proc/sys/fs/inode-max

You are probably creating negative dentries.  Check /proc/slabinfo for
the number of dentries, and it will confirm this.  I'm not sure why
that would cause swapping, but then again I haven't checked the policy
for shrinking the dentry cache recently, and there have been a number
of changes in that area lately.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

