Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268631AbRGZSWM>; Thu, 26 Jul 2001 14:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268634AbRGZSWB>; Thu, 26 Jul 2001 14:22:01 -0400
Received: from congress199.linuxsymposium.org ([209.151.18.199]:17157 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S268631AbRGZSVu>;
	Thu, 26 Jul 2001 14:21:50 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200107261821.f6QIL4017990@lynx.adilger.int>
Subject: Re: Weird ext2fs immortal directory bug (all-in-one)
To: wingc@engin.umich.edu (Christopher Allen Wing)
Date: Thu, 26 Jul 2001 12:21:04 -0600 (MDT)
Cc: sentry21@cdslash.net, linux-kernel@vger.kernel.org,
        tytso@mit.edu (Theodore Y. Ts'o), alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <Pine.LNX.4.33.0107261312450.6405-100000@bayarea.engin.umich.edu> from "Christopher Allen Wing" at Jul 26, 2001 01:21:01 PM
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Chris Wing writes:
> I am assuming that the problem here was that fsck restored a lost inode to
> lost+found, but the inode had been corrupted and had the immutable bit
> set.
> 
> At the very least, ext2 fsck should complain about ext2 attributes set for
> symlinks or device files... I have had this same problem myself many times
> on machines with bad SCSI termination- I end up with unremovable device
> files thanks to a bogus immutable bit and have to use debugfs to get rid
> of them.

It should actually assume that such inodes are corrupt, and either just
delete them at e2fsck time, or at least clear the "bad" parts of the inode
before sticking it in lost+found.

Cheers, Andreas

PS - I CC'd Ted on this, as he can probably fix this a lot faster than I
     (I may be able to fix it during another OLS presentation today or
     tomorrow).
-- 
Andreas Dilger                               Turbolinux filesystem development
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/
