Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277750AbRJRP2p>; Thu, 18 Oct 2001 11:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277751AbRJRP2f>; Thu, 18 Oct 2001 11:28:35 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:30457 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S277750AbRJRP2T>; Thu, 18 Oct 2001 11:28:19 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Thu, 18 Oct 2001 09:28:37 -0600
To: Kamil Iskra <kamil@science.uva.nl>
Cc: Steve Kieu <haiquy@yahoo.com>, kernel <linux-kernel@vger.kernel.org>
Subject: Re: Poor floppy performance in kernel 2.4.10
Message-ID: <20011018092837.C1144@turbolinux.com>
Mail-Followup-To: Kamil Iskra <kamil@science.uva.nl>,
	Steve Kieu <haiquy@yahoo.com>,
	kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20011017204524.88702.qmail@web10404.mail.yahoo.com> <Pine.LNX.4.33.0110181158060.6306-100000@krakow.science.uva.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0110181158060.6306-100000@krakow.science.uva.nl>
User-Agent: Mutt/1.3.22i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 18, 2001  12:11 +0200, Kamil Iskra wrote:
> So, to reiterate, the conditions known to be necessary to reproduce it
> are: kernel >=2.4.10 (perhaps only the Linus series), small files or
> directory operations, mtools.  The behaviour is as if no caching was done,
> there is a slowdown by a factor of two.  I have this problem both on my
> laptop and on the desktop machine at work.  They are running different
> kernel versions (2.4.12 and 2.4.10), differently configured and compiled
> by two different people.  Kernel 2.4.9 and earlier worked fine.

I think this is a result of the "blockdev in pagecache" change added in
2.4.10.  One of the byproducts of this change is that if a block device
is closed (no other openers) then all of the pages from this device are
dropped from the cache.  In the case of a floppy drive, this is very
important, as you don't want to be cacheing data from one floppy after
you have inserted a new floppy.

In contrast, if you mounted the floppy instead of using mtools, it would
probably have good performance for small files as well.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

