Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275766AbRI0FCG>; Thu, 27 Sep 2001 01:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275764AbRI0FB4>; Thu, 27 Sep 2001 01:01:56 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:52212 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S275766AbRI0FBm>; Thu, 27 Sep 2001 01:01:42 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Wed, 26 Sep 2001 23:01:52 -0600
To: Ken Zalewski <kennyz@nycap.rr.com>
Cc: linux-kernel@vger.kernel.org, zalewski@docdev.com
Subject: Re: linux kernel 2.4.10 possibly breaks LILO
Message-ID: <20010926230152.M1140@turbolinux.com>
Mail-Followup-To: Ken Zalewski <kennyz@nycap.rr.com>,
	linux-kernel@vger.kernel.org, zalewski@docdev.com
In-Reply-To: <3BB2A19D.1FB6D91A@nycap.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BB2A19D.1FB6D91A@nycap.rr.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 26, 2001  23:48 -0400, Ken Zalewski wrote:
> Modifying /etc/lilo.conf and running "lilo" when using kernel version
> 2.4.10 does not appear to modify the boot sector accordingly, even
> though I receive no errors or warnings.  On next reboot, LILO is
> configured as it was previous to my changes.  I am therefore unable to
> modify LILO configuration in any way while using 2.4.10.

It is likely the blkdev-in-pagecache change which caused this problem.
If you have a mounted filesystem on the same device as the bootsector
you are writing (e.g. /dev/hda1) and the bootsector shares a block with
the filesystem (e.g. 2kB or 4kB blocks and ext2/ext3) then any changes
made to the bootsector are overwritten as soon as you make any change
to the filesystem.

To test this theory (if possible) you could remount the filesystem
read-only before running LILO.  This would only work if you had a
setup like /dev/hda1 is / and /dev/hdX is /boot, because you still
need to be able to write into /boot.  If /boot is in the root fs, it
is not possible to do this.  If you CAN do this, then you need to
reboot after running LILO.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

