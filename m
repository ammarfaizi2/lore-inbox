Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbWFFGy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWFFGy3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 02:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWFFGy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 02:54:29 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:29366 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750801AbWFFGy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 02:54:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=IcMlWzAfCrQ8o0MbvDdvAYg2aMsBqJxrp+aOarSW7LE4iOlSnChmABc+/UEU64Ixe9v61miCWa7CUeIcaw3GDMa00hF3sPa8mLOjj6niw1nWy+kkbj4a3TFx81i4Cw+WVFK5KY4+ZIjMPhl0DC3jhxTTIaSJXC7wS14+OgxS/Mg=
Message-ID: <4485269B.8060602@gmail.com>
Date: Tue, 06 Jun 2006 15:54:19 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Robert Hancock <hancockr@shaw.ca>, Bill Davidsen <davidsen@tmr.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [git patch] libata resume fix
References: <6hAdo-5CV-5@gated-at.bofh.it> <6hXD0-6Y9-1@gated-at.bofh.it> <6icsx-4vp-33@gated-at.bofh.it> <6ih8Y-3ba-15@gated-at.bofh.it> <6iH3h-2xw-59@gated-at.bofh.it> <447E5EAD.5070808@shaw.ca> <20060601134802.GK4400@suse.de>
In-Reply-To: <20060601134802.GK4400@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jens.

Jens Axboe wrote:
> On Wed, May 31 2006, Robert Hancock wrote:
>> Bill Davidsen wrote:
>>> The trade-off is that if I have a 15k rpm SCSI drive, it would take a 
>>> lot of design changes to make it spin up quickly, and improve a function 
>>> which is usually done on a server once every MTBF when replacing the 
>>> failed unit.
>>>
>>> I think the majority of very large or very fast drives are in systems 
>>> which don't (deliberately) power cycles often, in rooms where heat is an 
>>> issue. And to spin up quickly take a larger power supply... 30 sec is 
>>> fine with most users.
>>>
>>> Couldn't find a spin-up time for the new Seagate 750GB drive, but the 
>>> seek sure is fast!
>> I wouldn't guess that even a 15K drive would take nearly that long. For 
>> boot time on servers it doesn't matter much though, disk spinup time is 
> 
> I do use a 15K rpm drive in my workstation (hello git!), and the spin up
> really isn't that bad. Less than 10 seconds for the actual spin up, I
> would say.

Can you measure spin up time for your 15k's?  Some controllers can't 
catch the first D2H FIS after POR and have to wait unconditionally for 
spin up for hotplug & resuming from suspend.  Currently 8 sec wait is 
used but it seems insufficient for your drives.  Failing to spinup in 
that 8 secs would probably result in timeout of the first reset attempt 
and retrial - which currently takes > 30 secs.

Spin-up time can be measured by first issuing STANDBY and then time how 
long IDLE IMMEDIATE takes, I think.

Thanks.

-- 
tejun
