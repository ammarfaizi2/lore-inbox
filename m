Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274259AbRISXR3>; Wed, 19 Sep 2001 19:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274263AbRISXRT>; Wed, 19 Sep 2001 19:17:19 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:59899 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S272661AbRISXRE>; Wed, 19 Sep 2001 19:17:04 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Wed, 19 Sep 2001 17:16:43 -0600
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mark Swanson <swansma@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Request: removal of fs/fs.h/super_block.u to enable partition
Message-ID: <20010919171643.T14526@turbolinux.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Mark Swanson <swansma@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3BA8F6EC.E3D73C87@yahoo.com> <E15jpH2-0003wz-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15jpH2-0003wz-00@the-village.bc.nu>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 19, 2001  22:52 +0100, Alan Cox wrote:
> Apart from the fact that the interface is source level you already can
> distribute, compile and merge file systems without patching the kernel.
> 
> It seems to be a user space issue not a kernel one. Your app can amend
> /etc/mtab when it creates and shuts down. 

Well, in recent versions of e2fsprogs it prefers to check /proc/mounts
over /etc/mtab to determine if a device is in-use, because the latter
can be incorrect after a crash, and the root filesystem is read-only at
this time.  There was recently a bug report about this from Slackware
users, where fsck is run on all of the filesystems before root is
remounted rw.  As a result, there is now even extra checking to see if
the devno of the mountpoint == devno of the device, otherwise it assumes
the /etc/mtab entry is bogus.

On most other systems, root is remounted rw before non-root filesystems
are checked, and /etc/mtab could be assumed to be correct, but it will
never be checked if /proc/mounts exists.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

