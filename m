Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265005AbUD2Wg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265005AbUD2Wg7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 18:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265013AbUD2Wgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 18:36:54 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:56818 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S265005AbUD2Wgr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 18:36:47 -0400
Message-ID: <40918375.2090806@mvista.com>
Date: Thu, 29 Apr 2004 15:36:37 -0700
From: Todd Poynor <tpoynor@mvista.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: mochel@digitalimplant.org, linux-hotplug-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Hotplug for device power state changes
References: <20040429202654.GA9971@dhcp193.mvista.com> <20040429224243.L16407@flint.arm.linux.org.uk>
In-Reply-To: <20040429224243.L16407@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

> Note that we should run this synchronously with userspace - ie, wait
> for the userspace hotplug script to finish executing before moving
> on to the next device.  Why?
> 
> Think of the case where we're suspending the complete system.  If you
> go round and asynchonously try to run userspace scripts, chances are
> you'll have the CPU asleep before _any_ of the scripts have run, which
> means (eg) your DHCP client couldn't tell the server that its released
> its allocation.

I figured system suspend/resume would need to be a separate event and 
isn't covered by this patch, which is for "runtime" individual device 
suspend/resume only.  Also, the flood of notifications of all devices 
suspending/resuming might not be useful -- the single system 
suspend/resume event could imply these device events, although perhaps 
in some cases something would want to know exactly which devices were 
operable at system suspend time.  I can also send a patch for system 
suspend/resume hotplug if there's interest.

Now that you mention it, device power hotplug should be synchronous, to 
make sure the power management application has reacted to the changed 
state prior to the device going into actual service (in the case of a 
resume).

> Also, should we be telling userspace about suspend before we actually
> suspend the device?

I suppose that, depending on the reason notification is needed, "just 
before" or "just after" might be the right answer.  Now that you bring 
this up, it was originally my intention to notify of suspend "just 
after" (so power mgr can change power state, knowing that the associated 
device no longer has any requirements), and notify of resume "just 
before" (so power mgr can adjust power state to match requirements about 
to be put into service).  I'd be interested in hearing about other usage 
scenarios that might need a different notification order.  Thanks,

-- 
Todd Poynor
MontaVista Software
