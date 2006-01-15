Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750878AbWAOTk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbWAOTk4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 14:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbWAOTk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 14:40:56 -0500
Received: from ebb.errno.com ([69.12.149.25]:52496 "EHLO ebb.errno.com")
	by vger.kernel.org with ESMTP id S1750853AbWAOTkz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 14:40:55 -0500
Message-ID: <43CAA4FD.5070605@errno.com>
Date: Sun, 15 Jan 2006 11:39:41 -0800
From: Sam Leffler <sam@errno.com>
Organization: Errno Consulting
User-Agent: Thunderbird 1.5 (Macintosh/20051201)
MIME-Version: 1.0
To: Stefan Rompf <stefan@loplof.de>
CC: Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: wireless: recap of current issues (configuration)
References: <20060113195723.GB16166@tuxdriver.com> <20060113221935.GJ16166@tuxdriver.com> <1137191522.2520.63.camel@localhost> <200601151340.10730.stefan@loplof.de>
In-Reply-To: <200601151340.10730.stefan@loplof.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Rompf wrote:
> Am Freitag 13 Januar 2006 23:32 schrieb Johannes Berg:
> 
>> [Changing mode of virtual devices]
>>
>> IMHO there's not much point in allowing changes. I have a feeling that
>> might create icky issues you don't want to have to tackle when the
>> solution is easy by just not allowing it. Part of my thinking is that
>> different virtual types have different structures associated, so
>> changing it needs re-creating structures anyway. And different virtual
>> device types might even be provided by different kernel modules so you
>> don't carry around AP mode if you don't need it.
> 
> Even though it is a bit more work on kernel side, we should allow changing the 
> mode of virtual devices. Let's face it, even though we find multi-BSS 
> capabilities very interesting, 999 of 1000 users won't care due to the two 
> facts that IPW firmware IMHO doesn't allow it and virtual interfaces are 
> limited to one channel anyway. These users rightfully expect to have one 
> interface and be able to do all configurations on it.

My experience is that once you can create+destroy virtual devices you'll 
never want mode changing.  From a usability standpoint when you switch 
modes you typically have to reconfigure lots of settings and doing 
destroy old followed by create new is easier.  Depending on how things 
tie into hotplug you may also find things getting complicated.

Within the kernel having the operating mode of a virtual device not 
change is very good.  First it lets you isolate the rules for mix+match 
of different virtual devices at create.  Second you can partition code 
so, for example, only code required to support an ap is loaded when an 
ap mode virtual device exists.  There are other less obvious reasons 
such as firmware-based devices can load firmware based on the operating 
mode at create time but if you allow mode switching then you need to 
unload+load on the fly.  All these things can be handled with switching 
modes but the complexity is significant and the gain is minimal.

The big stumbling block I found to going with virtual devices is that it 
affects user apps.  I looked at doing things like auto-create a station 
device for backwards compatibility but decided against it.  If you 
really want this behaviour it can be done by user code.

	Sam


