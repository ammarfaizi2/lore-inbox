Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbWFFHDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWFFHDJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 03:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbWFFHDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 03:03:09 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:52231 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932127AbWFFHDH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 03:03:07 -0400
Date: Tue, 6 Jun 2006 09:05:39 +0200
From: Jens Axboe <axboe@suse.de>
To: Tejun Heo <htejun@gmail.com>
Cc: Robert Hancock <hancockr@shaw.ca>, Bill Davidsen <davidsen@tmr.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [git patch] libata resume fix
Message-ID: <20060606070539.GO4400@suse.de>
References: <6hAdo-5CV-5@gated-at.bofh.it> <6hXD0-6Y9-1@gated-at.bofh.it> <6icsx-4vp-33@gated-at.bofh.it> <6ih8Y-3ba-15@gated-at.bofh.it> <6iH3h-2xw-59@gated-at.bofh.it> <447E5EAD.5070808@shaw.ca> <20060601134802.GK4400@suse.de> <4485269B.8060602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4485269B.8060602@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06 2006, Tejun Heo wrote:
> Hi, Jens.
> 
> Jens Axboe wrote:
> >On Wed, May 31 2006, Robert Hancock wrote:
> >>Bill Davidsen wrote:
> >>>The trade-off is that if I have a 15k rpm SCSI drive, it would take a 
> >>>lot of design changes to make it spin up quickly, and improve a function 
> >>>which is usually done on a server once every MTBF when replacing the 
> >>>failed unit.
> >>>
> >>>I think the majority of very large or very fast drives are in systems 
> >>>which don't (deliberately) power cycles often, in rooms where heat is an 
> >>>issue. And to spin up quickly take a larger power supply... 30 sec is 
> >>>fine with most users.
> >>>
> >>>Couldn't find a spin-up time for the new Seagate 750GB drive, but the 
> >>>seek sure is fast!
> >>I wouldn't guess that even a 15K drive would take nearly that long. For 
> >>boot time on servers it doesn't matter much though, disk spinup time is 
> >
> >I do use a 15K rpm drive in my workstation (hello git!), and the spin up
> >really isn't that bad. Less than 10 seconds for the actual spin up, I
> >would say.
> 
> Can you measure spin up time for your 15k's?  Some controllers can't 
> catch the first D2H FIS after POR and have to wait unconditionally for 
> spin up for hotplug & resuming from suspend.  Currently 8 sec wait is 
> used but it seems insufficient for your drives.  Failing to spinup in 
> that 8 secs would probably result in timeout of the first reset attempt 
> and retrial - which currently takes > 30 secs.
> 
> Spin-up time can be measured by first issuing STANDBY and then time how 
> long IDLE IMMEDIATE takes, I think.

The 15K RPM is a SCSI drive, I haven't seen any SATA 15K rpm drives yet.
I have the same model in another box, I can measure spinup with
START_STOP unit there. I will do so later today, when I fire it up, if
you still want to know?

-- 
Jens Axboe

