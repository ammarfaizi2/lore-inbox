Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbUCFMnA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 07:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbUCFMnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 07:43:00 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:19626 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261660AbUCFMm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 07:42:57 -0500
Date: Fri, 5 Mar 2004 19:46:46 +0100
From: Pavel Machek <pavel@suse.cz>
To: Johannes Stezenbach <js@convergence.de>,
       Peter Nelson <pnelson@andrew.cmu.edu>, Hans Reiser <reiser@namesys.com>,
       Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, ext3-users@redhat.com,
       jfs-discussion@oss.software.ibm.com, reiserfs-list@namesys.com,
       linux-xfs@oss.sgi.com
Subject: Re: Desktop Filesystem Benchmarks in 2.6.3
Message-ID: <20040305184643.GA4758@openzaurus.ucw.cz>
References: <4044119D.6050502@andrew.cmu.edu> <4044366B.3000405@namesys.com> <4044B787.7080301@andrew.cmu.edu> <20040303234104.GD1875@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040303234104.GD1875@convergence.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> It would be nice if someone with more profound knowledge could comment
> on this, but my understanding of the problem is:
> 
> - journaled filesystems can only work when they can enforce that
>   journal data is written to the platters at specifc times wrt
>   normal data writes
> - IDE write caching makes the disk "lie" to the kernel, i.e. it says
>   "I've written the data" when it was only put in the cache
> - now if a *power failure* keeps the disk from writing the cache
>   contents to the platter, the fs and journal are inconsistent
>   (a kernel crash would not cause this problem because the disk can
>   still write the cache contents to the platters)
> - at next mount time the fs will read the journal from the disk
>   and try to use it to bring the fs into a consistent state;
>   however, since the journal on disk is not guaranteed to be up to date
>   this can *fail*  (I have no idea what various fs implementations do
>   to handle this; I suspect they at least refuse to mount and require
>   you to manually run fsck. Or they don't notice and let you work
>   with a corrupt filesystem until they blow up.)
> 
> Right?  Or is this just paranoia?

Twice a year I fsck my reiser drives, and yes there's some corruption there.
So you are right, and its not paranoia.

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

