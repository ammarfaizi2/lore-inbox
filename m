Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753159AbWKFN6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753159AbWKFN6z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 08:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753164AbWKFN6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 08:58:55 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2432 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1753159AbWKFN6z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 08:58:55 -0500
Date: Mon, 6 Nov 2006 14:57:51 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tejun Heo <htejun@gmail.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, axboe@suse.de
Subject: Re: SATA powersave patches
Message-ID: <20061106135751.GA13517@elf.ucw.cz>
References: <20060908110346.GC920@elf.ucw.cz> <45015767.1090002@gmail.com> <20060908123537.GB17640@elf.ucw.cz> <4501655F.5000103@gmail.com> <20060910224815.GC1691@elf.ucw.cz> <4505394F.6060806@gmail.com> <20060918100548.GJ3746@elf.ucw.cz> <450E771E.1070207@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <450E771E.1070207@gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

First, sorry for long reply time. I had too many horses and not enough
time.

> >>Can you check if there is any difference between [D/H]IPS and static? 
> >>ICH6M on my notebook can't do DIPS/HIPS, so I couldn't compare them 
> >>against static.
> >
> >What is D/HIPS? I could not find anything relevant..
> 
> D/HIPS stand for device/host initiated power saving.  These modes use 
> two SATA link powersaving state (partial and slumber).  Static mode 
> simply turns off PHY on unoccupied port using SControl register.  So, if 
> you have an access to a notebook which has a SATA dock which support 
> link powersaving, you can test it by...
> 
> * set link powersaving mode to HIPS/static. (mode 4)
> 
> * w/ device inserted, leave it idle for 15 seconds and record power 
> consumption level (link should be in slumber state).
> 
> * pull out the device, wait for libata to detach the device and record 
> power consumption level (libata should have turned off PHY after 
> detaching the device).
> 
> I wanna know whether there is any difference in the amount of power 
> saved between slumber and off states.

I'm probably doing something wrong, but...

I'm on commit 

commit 9a7b050525f7d70d2ed62affb691b9d4ca2b82d2
tree b8195e5625dc5bad6757b0dddec0dacf416a0779
parent 50c3086de212ce56eaa2bf284586fb021615b5e1
author Tejun Heo <htejun@gmail.com> Mon, 16 Oct 2006 07:24:57 +0900
committer Tejun Heo <htejun@gmail.com> Mon, 16 Oct 2006 07:24:57 +0900

    [PATCH] sata_sil24: implement PORT_RST

    As DEV_RST (hardreset) sometimes fail to recover the controller
    (especially after PMP DMA CS errata).  In such cases, perform
PORT_RST
    prior to DEV_RST.

    Signed-off-by: Tejun Heo <htejun@gmail.com>


(2.6.19-rc1)

and I do not see powersave tunable:

root@amd:/sys/module# ls libata/parameters/
ata_probe_timeout         atapi_enabled hotplug_polling_interval
atapi_dmadir              fua

...how do I pull working version?

> >>So, I think option #1 is the way to go - implementing leveled dynamic 
> >>power management infrastructure and adding support in the block layer. 
> >>What do you think?
> >
> >Would be nice :-).
> 
> So, do you think we're ready for another PM infrastructure update?  :-P

Well... things are pretty quiet in that area just now... So yes.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
