Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932466AbVIZSg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbVIZSg5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 14:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbVIZSg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 14:36:57 -0400
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:24967 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S932466AbVIZSg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 14:36:56 -0400
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: [2.6.13] pktcdvd: IO-errors
References: <Pine.LNX.4.60.0509242057001.4899@poirot.grange>
	<m3slvtzf72.fsf@telia.com>
	<Pine.LNX.4.60.0509252026290.3089@poirot.grange>
From: Peter Osterlund <petero2@telia.com>
Date: 26 Sep 2005 20:36:51 +0200
In-Reply-To: <Pine.LNX.4.60.0509252026290.3089@poirot.grange>
Message-ID: <m34q873ccc.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guennadi Liakhovetski <g.liakhovetski@gmx.de> writes:

> On Sun, 25 Sep 2005, Peter Osterlund wrote:
> 
> > Guennadi Liakhovetski <g.liakhovetski@gmx.de> writes:
> > 
> > > Just tried pktcdvd on 2.6.13.1. The setup went fine:
...
> > > But, as I tried to copy some files to the CD-RW, it first went ok, but 
> > > then produced the following:
> > > 
> > > 20:41:01: ide-cd: cmd 0x2a timed out
> > > 		      ^^^^	---------> write10
> > > 20:41:01: hdc: DMA timeout retry
> > > 20:41:01: hdc: timeout waiting for DMA
...
> > > the "cp" finished earlier, I did a sync, and it also finished. The good 
> > > parts - no Oops, no process stuck in "D", tha bad parts - it didn't 
> > > work:-), the IDE LED stays on and I cannot eject the CD. The CD-R is a 
> > > BenQ 52x32x52 Seamless Link alone on ide1, the disk does indeed say 
> > > 4x-10x. The cd-writer works mostly... if I am gentle to it - I usually 
> > > burn at 32x even if the media says 52x... Is it just a hw-failure or a 
> > > driver bug?
> > 
> > Did it ever work with this hardware, for example using 2.6.12?
> 
> It was the first time I ever tried it. Now as you asked I also tried 
> 2.6.12-rc5. Surprise, surprise - it worked... But very strange. First, I 
> did
> 
> # time cp -a source /cdrom/ ; time sync
> 
> It took a few minutes to copy 190MB, but it finished successfully. Now to 
> the strange things: even after it finished the LED on the writer continued 
> flashing red... Only after I performed a read access to /cdrom/ it 
> stopped. Actually, just wrote a small file to it, did a sync, sync 
> returned, LED is flashing red. Now I cannot stop it by reading. Only 
> unmounting it helped.
...
> Besides, it works under 2.6.12-rc5...

What gcc versions were used when compiling the kernels? (Boot both
kernels, run "cat /proc/version" to find out.)

I just discovered that the driver doesn't work correctly on my laptop
if I use "gcc version 4.0.1 20050727 (Red Hat 4.0.1-5)" from Fedora
Core 4. "pktsetup 0 /dev/hdc ; cat /proc/driver/pktcdvd/pktcdvd0"
OOPSes. If I use gcc32 it does seem to work though.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
