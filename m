Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135209AbRD3MDz>; Mon, 30 Apr 2001 08:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135211AbRD3MDp>; Mon, 30 Apr 2001 08:03:45 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:17 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S135209AbRD3MD2>; Mon, 30 Apr 2001 08:03:28 -0400
Date: Mon, 30 Apr 2001 08:02:50 -0400
From: Chris Mason <mason@suse.com>
To: spam@perlpimp.com, linux-kernel@vger.kernel.org
Subject: Re: reiserfs autofix?
Message-ID: <738200000.988632170@tiny>
In-Reply-To: <20010430000704.A2313@vancouver.yi.org>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday, April 30, 2001 12:07:04 AM -0700 putter <spam@perlpimp.com>
wrote:

> I think I have tracked down the problem to the card itself. My machine is
> on @ graphics mode all the time, like 24hrs a day, and it seems that it
> is somewhat taxing on the cards performance. So now I switch down to text
> mode, everytime I leave the machine. How did I find out? I placed my
> finger of heatsink of my GeForce DDR. It was HOT! Fan works alright, so
> if I was to run computer a while, stress accumilates, and when I run
> GeForce understress of maximum resolutions, it craps out. So much for
> NVidia eh?

Do a search through the kernel arcvhies for nvidia.  The crashes could just
be the driver.  But heat is always a problem, add fans ;-)

> 
> BTW, I don't question graphical subsystem crashes. I question reiserfs
> that suppose to leave my partitions in consistent state, no matter how
> trigger happy with power switch I am, or is my judgement is clouded? >=)

After a crash, reiserfs only cleans up after itself.  If someone else went
in and hosed the metadata (nvidia, bad drive, controller, ide fun with
via), you've still got bad blocks.

This is one possible reason that we've seen more reports than ext2 has.
After a crash, ext2fsck fixes _whatever_ was broken.  log replay in
reiserfs only fixes the operations that were in progress when the system
crashed.

Anyway, those messages show that you've got metadata corruption.  grab the
latest reiserfsprogs from ftp.reiserfs.org and run reiserfsck -x (after
backing things up).

-chris

