Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132143AbRAQUob>; Wed, 17 Jan 2001 15:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133095AbRAQUoV>; Wed, 17 Jan 2001 15:44:21 -0500
Received: from [24.65.192.120] ([24.65.192.120]:55279 "EHLO webber.adilger.net")
	by vger.kernel.org with ESMTP id <S132143AbRAQUoO>;
	Wed, 17 Jan 2001 15:44:14 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200101172043.f0HKhnA09341@webber.adilger.net>
Subject: Re: Linux not adhering to BIOS Drive boot order?
In-Reply-To: <20010117205007.D4979@almesberger.net> "from Werner Almesberger
 at Jan 17, 2001 08:50:07 pm"
To: Werner Almesberger <Werner.Almesberger@epfl.ch>
Date: Wed, 17 Jan 2001 13:43:49 -0700 (MST)
CC: Venkatesh Ramamurthy <Venkateshr@ami.com>, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner, you write:
> Venkatesh Ramamurthy wrote:
> > 	[Venkatesh Ramamurthy]  The LILO boot loader and the LILO command
> > line utility should be changed for this. There are some issues when we have
> 
> Grr, I was just waiting for this ...
> 
> See sections 2.6 and 3.5 of
> ftp://icaftp.epfl.ch/pub/people/almesber/booting/bootinglinux-0.ps.gz
> for my views on such things.

Actually, what is being discussed is not related to your above sections
of the paper.  AFAICS, the only change needed is to /sbin/lilo to resolve
UUID and LABEL tags for "root=LABEL=turbo_root" fields in /etc/lilo.conf.
This is not a bloat to the kernel, and doesn't change the boot loader at
all, only the user-space block mapping code.

What _would_ be interesting, and still not affect the boot loader proper,
is to allow specifying multiple boot devices in /etc/lilo.conf (for e.g.
RAID 1 setups), and then /sbin/lilo would put a boot sector on each such
drive.

This would potentially allow you to boot from the second drive if the
first one fails, assuming the kernel does UUID or LABEL resolution for
the root device.  The kernel would boot from the first BIOS drive, and
would match search for a UUID or LABEL as the root device.  If /etc/fstab
is also handled exclusively with UUID or LABEL (or LVM), then you don't
care what the drives are called (excluding swap, hmmm, maybe we can add
a signature to swap?).

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
