Return-Path: <linux-kernel-owner+w=401wt.eu-S932980AbXABIeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932980AbXABIeS (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 03:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932983AbXABIeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 03:34:18 -0500
Received: from brick.kernel.dk ([62.242.22.158]:16265 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932980AbXABIeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 03:34:17 -0500
Date: Tue, 2 Jan 2007 09:34:14 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Mark Lord <lkml@rtr.ca>
Cc: Rene Herman <rene.herman@gmail.com>, Tejun Heo <htejun@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.20-rc2+: CFQ halving disk throughput.
Message-ID: <20070102083414.GQ2483@kernel.dk>
References: <45893CAD.9050909@gmail.com> <45921E73.1080601@gmail.com> <4592B25A.4040906@gmail.com> <45932AF1.9040900@gmail.com> <45998F62.6010904@gmail.com> <4599992D.8000607@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4599992D.8000607@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 01 2007, Mark Lord wrote:
> Rene Herman wrote:
> >Tejun Heo wrote:
> >
> >>Everything seems fine in the dmesg.  Performance degradation is
> >>probably some other issue in -rc kernel.  I'm suspecting recently
> >>fixed block layer bug.  If it's still the same in the next -rc,
> >>please report.
> >
> >In fact, it's CFQ. The PATA thing was a red herring. 2.6.20-rc2 and 3 
> >give me ~ 24 MB/s from "hdparm t /dev/hda" while 2.6.20-rc1 and below 
> >give me ~ 50 MB/s.
> >
> >Jens: this is due to "[PATCH] cfq-iosched: tighten allow merge 
> >criteria", 719d34027e1a186e46a3952e8a24bf91ecc33837:
> >
> >http://www2.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=719d34027e1a186e46a3952e8a24bf91ecc33837 
> >
> >
> >If I revert that one, I have my 50 M/s back. config and dmesg attached 
> >in case they're useful.
> 
> Wow.. same deal here -- sequential throughput drops from 40MB/sec to 
> 28MB/sec
> with CFQ -- whereas the anticipatory scheduler maintains the 40MB/sec.
> 
> Jens.. I wonder if the new merging test is a bit too strict?
> 
> There are four possible combinations, and the new code
> allows merging for two of them:  sync+sync and async+async.
> 
> But surely one of (not sure which) sync+async or async+sync may also be 
> okay?
> Or would it?

Async merge to sync request should be ok. But I wonder what happens with
hdparm, since it seems to trigger one of these tests. Very puzzling.
I'll dive in and take a look.

> This is a huge performance hit.

Indeed, not acceptable of course. And not intentional :-)

-- 
Jens Axboe

