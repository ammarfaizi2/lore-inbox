Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265736AbSKFPu2>; Wed, 6 Nov 2002 10:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265737AbSKFPu2>; Wed, 6 Nov 2002 10:50:28 -0500
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:10231 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S265736AbSKFPuY>;
	Wed, 6 Nov 2002 10:50:24 -0500
Date: Wed, 6 Nov 2002 10:56:56 -0500
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.46: ide-cd cdrecord (almost) success report
Message-ID: <20021106155656.GA20403@www.kroptech.com>
References: <20021106041330.GA9489@www.kroptech.com> <20021106072223.GB4369@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021106072223.GB4369@suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2002 at 08:22:23AM +0100, Jens Axboe wrote:
> On Tue, Nov 05 2002, Adam Kropelin wrote:
> > Still without coaster I tried one more thing...
> > 'dd if=/dev/zero of=foo bs=1M' in parallel with another burn. That one
> > did it in. ;) I'm running ext3 and the writeout load totally killed
> > burn, which isn't surprising. I was asking for it, I know. What happened
> 
> Really, this should work. The deadline scheduler should handle this just
> fine in fact. Which device is your burner and which device is the hard
> drive? It sounds like a bug.

Hard disk is sdc on onboard AIC7xxx.
Writer is hdc, the only device on the secondary onboard IDE channel.
All other disks (IDE & SCSI) were idle during the test.

Source image for the burn was on sdc3 and a directory on the same
partition was also the target for the 'dd'.

The system was exhibiting the usual spotty ext3 large writeout behavior
as has been discussed on the list before. Basically, vmstat 1 looks
something like this (captured from a different test on a different
machine but shows the same pattern):

 0  1  1    120   4464      0 140856   0   0     0 15420 6235   520   0 42  58
 0  1  1    120   4456      0 140856   0   0     0  3240 1094    36   0 2 98
 1  0  0    120   4428      0 140844   0   0     0    52 1151    70   0 4 96
 1  0  0    120   4440      0 141356   0   0     0     4 6810   541   1 42  57
 0  0  0    120   4464      0 141320   0   0     0     0 6894   553   1 40  58
 0  1  1    120   4396      0 140840   0   0     0 15508 6018   466   0 40  59
 0  1  1    120   4388      0 140840   0   0     0  1608 1093    57   0  2  98
 0  0  0    120   4404      0 140832   0   0     0    52 2350   165   0 12  87
 0  0  0    120   4460      0 141380   0   0     0     4 7040   564   1 42  57
 1  0  0    120   4356      0 141372   0   0     0     4 7073   570   1 45  54

> I'll try and reproduce that here, there's been a similar report (same
> oops) before. If you can just send me the dmesg output after a boot that
> should be fine.

Will do when I get home (now +9 hrs or so)...

> Thanks a lot for testing, it's this kind of testing I need to iron out
> the last few bugs!

No sweat. I've got three spindles of blank media left. ;)

--Adam, who remembers buying his first blank CDR for USD 19.95 and is
thankful CD writer testing is no longer so expensive.

