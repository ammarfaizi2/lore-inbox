Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277338AbRJOJJT>; Mon, 15 Oct 2001 05:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277345AbRJOJJI>; Mon, 15 Oct 2001 05:09:08 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:45039 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S277338AbRJOJJA>; Mon, 15 Oct 2001 05:09:00 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Mon, 15 Oct 2001 03:09:09 -0600
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: journaling and devel [was Re: Development Setups]
Message-ID: <20011015030909.A2519@turbolinux.com>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel writes:
> I disagree.. With journal filesystem, when something is silently corrupting
> your disk, you'll never know.  With ext2, you sometimes sync & reset to make
> sure your disks are still healthy.  I would not recomment journaling on
> experimental boxes.

I would say just the opposite with ext3 - I prefer to use it on my development
boxes.

1) No fsck time (normally) after crashing, which can happen a lot.
2) You can set ext3 to fsck automatically after a fixed number of reboots/time
   if you are worried about a bad disk/cable/kernel.

Most of the mke2fs which support ext3 (1.20+ or so) will set the check
interval to 20 + rand(20) reboots per check by default, or 6 months.  Since
this is a random value, you don't get all of your filesystems checked at the
same time, but it happens at least once in a while to ensure that each fs is
OK.

Of course, you can turn it off if you want, but the option is there to do
periodic checks.  The time interval is probably still a good idea, even if
you turn of the per-N-mount checking, because of bit rot, etc.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

