Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265964AbSKFSif>; Wed, 6 Nov 2002 13:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265968AbSKFSif>; Wed, 6 Nov 2002 13:38:35 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:56771 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265964AbSKFSie>;
	Wed, 6 Nov 2002 13:38:34 -0500
Date: Wed, 6 Nov 2002 19:45:08 +0100
From: Jens Axboe <axboe@suse.de>
To: Adam Kropelin <akropel1@rochester.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.46: ide-cd cdrecord (almost) success report
Message-ID: <20021106184508.GB897@suse.de>
References: <20021106041330.GA9489@www.kroptech.com> <20021106072223.GB4369@suse.de> <20021106155656.GA20403@www.kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021106155656.GA20403@www.kroptech.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06 2002, Adam Kropelin wrote:
> On Wed, Nov 06, 2002 at 08:22:23AM +0100, Jens Axboe wrote:
> > On Tue, Nov 05 2002, Adam Kropelin wrote:
> > > Still without coaster I tried one more thing...
> > > 'dd if=/dev/zero of=foo bs=1M' in parallel with another burn. That one
> > > did it in. ;) I'm running ext3 and the writeout load totally killed
> > > burn, which isn't surprising. I was asking for it, I know. What happened
> > 
> > Really, this should work. The deadline scheduler should handle this just
> > fine in fact. Which device is your burner and which device is the hard
> > drive? It sounds like a bug.
> 
> Hard disk is sdc on onboard AIC7xxx.
> Writer is hdc, the only device on the secondary onboard IDE channel.
> All other disks (IDE & SCSI) were idle during the test.

Ah ok, yes on SCSI it's very easy to starve requests. There's no good
way to control this yet, unfortunately. Please set max number of tags to
2-4 or so, and you should not be able to kill the burn.

You wont see better performance with more tags than 4 anyways, and you
risk god awful latencies. So it's a good choice, regardless.

> > I'll try and reproduce that here, there's been a similar report (same
> > oops) before. If you can just send me the dmesg output after a boot that
> > should be fine.
> 
> Will do when I get home (now +9 hrs or so)...

Great, thanks.

-- 
Jens Axboe

