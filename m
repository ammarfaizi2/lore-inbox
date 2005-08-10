Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965019AbVHJGpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965019AbVHJGpE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 02:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965021AbVHJGpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 02:45:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:64444 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965019AbVHJGpC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 02:45:02 -0400
Message-ID: <42F9A264.5030006@suse.de>
Date: Wed, 10 Aug 2005 08:44:52 +0200
From: Thomas Renninger <trenn@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.8) Gecko/20050621
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Stefan Seyfried <seife@suse.de>, Con Kolivas <kernel@kolivas.org>,
       tony@atomide.com, ck@vds.kolivas.org, tuukka.tikkanen@elektrobit.com,
       linux-kernel@vger.kernel.org, tytso@mit.edu
Subject: Re: [patch] i386 dynamic ticks 2.6.13-rc4 (code reordered)
References: <88056F38E9E48644A0F562A38C64FB600565DD73@scsmsx403.amr.corp.intel.com>
In-Reply-To: <88056F38E9E48644A0F562A38C64FB600565DD73@scsmsx403.amr.corp.intel.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pallipadi, Venkatesh wrote:
>>-----Original Message-----
>>From: linux-kernel-owner@vger.kernel.org 
>>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
>>Stefan Seyfried
>>Sent: Sunday, August 07, 2005 10:43 PM
>>To: Con Kolivas
>>Cc: tony@atomide.com; ck@vds.kolivas.org; 
>>tuukka.tikkanen@elektrobit.com; linux-kernel@vger.kernel.org; 
>>tytso@mit.edu
>>Subject: Re: [patch] i386 dynamic ticks 2.6.13-rc4 (code reordered)
>>
>>Con Kolivas wrote:
>>
>>>>When I enabled dynamic tick using:
>>>>
>>>>	echo 1 > /sys/devices/system/timer/timer0/dyn_tick_state
>>>>
>>>>The number of ticks dropped down to 60-70 HZ, bus mastering activity
>>>>jumpped up to being almost always active,
>>>Anyone know why this would happen?
>>This is just a guess, without any actual code-reading:
>>Maybe the C-state decision process just relies on being called every
>>tick, so "after X ticks with no BM activity, go to next deeper 
>>C state".
>>As long as 1000 ticks per second are coming in, everything is fine and
>>we enter C[n+1] after X miliseconds without BM activity. Now if there
>>are only 60-70 ticks per second, you never get X ticks without BM
>>activity so you never go deeper than C2.
>>
>>Just a guess.
> 
> That is correct. The C-state policy right now looks at jiffies to decide
> on which C-state to go to (instead of absolute time).
> This patch from Thomas should help with respect to going to proper 
> C-state in presence of dynamic tick.
> http://lkml.org/lkml/2005/4/19/96
> 
My patch considered only the average last idle times and the average last bus master
activities.
It could happen that C3/C4 comes in too fast (not waiting long enough for bus master
activity to settle down) which could result in failed transitions or misfunctionality
of bus master devices.
However, it worked on my machine and I could gain a lot of power savings.
But be prepared that your WLAN card, USB peripherie or others might behave strangely or even that
the machine freezes (if, it should freeze quite fast if idle).
I plan to have a look at x86 and x86_64 dynamic tick patches again and rewrite the C-state
patch, soon.
Any hints on updated dyn-tick patches/projects crawling around are appreciated.

Thanks,

   Thomas
