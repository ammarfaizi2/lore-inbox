Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132482AbRCZRsn>; Mon, 26 Mar 2001 12:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132506AbRCZRse>; Mon, 26 Mar 2001 12:48:34 -0500
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:59128 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S132503AbRCZRsZ>; Mon, 26 Mar 2001 12:48:25 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200103261747.f2QHlEX19564@webber.adilger.int>
Subject: Re: 64-bit block sizes on 32-bit systems
In-Reply-To: <20010326181803.F31126@parcelfarce.linux.theplanet.co.uk> from Matthew
 Wilcox at "Mar 26, 2001 06:18:03 pm"
To: Matthew Wilcox <matthew@wil.cx>
Date: Mon, 26 Mar 2001 10:47:13 -0700 (MST)
CC: LA Walsh <law@sgi.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox writes:
> On Mon, Mar 26, 2001 at 08:39:21AM -0800, LA Walsh wrote:
> > I vaguely remember a discussion about this a few months back.
> > If I remember, the reasoning was it would unnecessarily slow
> > down smaller systems that would never have block devices in
> > the 4-28T range attached.  
> 
> 4k page size * 2GB = 8TB.
> 
> i consider it much more likely on such systems that the page size will
> be increased to maybe 16 or 64k which would give us 32TB or 128TB.
> 
> personally, i'm going to see what the situation looks like in 5 years time
> and try to solve the problem then.

What do you mean by problems 5 years down the road?  The real issue is that
this 32-bit block count limit affects composite devices like MD RAID and
LVM today, not just individual disks.  There have been several postings
I have seen with people having a problem _today_ with a 2TB limit on
devices.

There is some hope with LVM (and MD I suspect as well), that it could
do blocksize remapping, so it appears to be a 4k sector device, but
remaps to 512-byte sector disks underneath.  This _should_ give us an
upper limit of 16TB, assuming 32-bit unsigned ints for block numbers.
Of course, you would need to only do 4kB block I/O on top of these devices
(not much of an issue for such large devices).

Still, this is just a stop-gap measure because next year people will want
> 16TB devices, and there won't be an easy way to do this.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
