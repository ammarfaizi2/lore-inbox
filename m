Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267198AbUBMUcO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 15:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267199AbUBMUcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 15:32:14 -0500
Received: from cpc3-hitc2-5-0-cust51.lutn.cable.ntl.com ([81.99.82.51]:20137
	"EHLO zog.reactivated.net") by vger.kernel.org with ESMTP
	id S267198AbUBMUcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 15:32:07 -0500
Message-ID: <402D3448.7080105@reactivated.net>
Date: Fri, 13 Feb 2004 20:32:08 +0000
From: Daniel Drake <dan@reactivated.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: is nForce2 good choice under Linux?
References: <Pine.LNX.4.58.0402132048330.31906@alpha.polcom.net>
In-Reply-To: <Pine.LNX.4.58.0402132048330.31906@alpha.polcom.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I own an Abit NF7-S 2.0. I generally stick to the latest 2.6-mm kernels.

Grzegorz Kulewski wrote:
> 1. What is the status of nForce2 support under Linux? What works what not? 

I haven't tried the SATA or firewire capabilities of my board, but I believe 
both work. Everything else (sound, network, ...) works OK.

> 2. Are the drivers binary or source or open source? Are the drivers in 
> mainline kernels or do I need a patch?

There are binary sound drivers, but you are best off to go with the ALSA 
intel8x0 drivers (open source).
There are binary network drivers, but you are best off to go with the 
forcedeth drivers (open source).
There is nvidia ide support in the kernel.

My only gripe is that, as I understand it, the onboard sound chip is powerful. 
However, neither the ALSA/OSS drivers, or nvidia's own binaries, will take 
advantage of the good features such as hardware mixing. This means that you 
cannot play two sounds at the same time, unless you use software mixing (dmix, 
arts, esd) or go out and buy a cheapy SB Live :)
Apparently, nvidia are working on new (binary) drivers for nforce-audio which 
will do hardware mixing and the likes.

> 3. Are there any problems with this chipset? Are the problems hardware 
> based or soft based (= will/can be fixed)? Are ACPI, APIC, IRQ and so on 
> working OK?

Yes, there is a problem. This is a hardware problem, which can likely be fixed 
in a BIOS update. Those who have tried contacting manufacturers have basically 
failed.
There is a bug relating to the C1 disconnect feature of AMD CPU's. It causes a 
total system freeze. There is some quite detailed info on this in recent 
threads, search the archive if you are interested.

For the majority of people (as I understand it), these lockups can be totally 
avoided by *not* using APIC/IOAPIC. I never met a lockup until I enabled APIC 
for the first time. The older XTPIC paths are generally not fast enough to 
trigger the C1 bug. Ross Dickson has done some great work here, and he has 
produced patches which workaround this particular bug. His last two revisions 
of patches have worked great for me (and others), not a lockup since.

Of course, you might get lucky and not get problems at all. I have heard from 
a couple of people who use nforce2-based systems, with default configs (plus 
APIC) and have never experienced a lockup.

> 4. Are there any workarounds in the kernel for hardware bugs? Do they 
> affect performance/stability?

See above.

> 5. Should I choose other mainboard? Why? Which?

I have been perfectly happy with my NF7-S, except from the one time it failed 
on me (didn't boot up), and I had to get it replaced. I think there is a 
general risk involved in buying nforce2 boards, their rate of failure is 
fairly high. Still, the benefits are nice.

hope this helps

Daniel
