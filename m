Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265220AbUD3THU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265220AbUD3THU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 15:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265229AbUD3THU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 15:07:20 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:26862 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S265220AbUD3THO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 15:07:14 -0400
Message-ID: <4092A3DA.4040908@mvista.com>
Date: Fri, 30 Apr 2004 12:07:06 -0700
From: Todd Poynor <tpoynor@mvista.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Russell King <rmk+lkml@arm.linux.org.uk>,
       Patrick Mochel <mochel@digitalimplant.org>,
       linux-hotplug-devel@lists.sourceforge.net,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Hotplug for device power state changes
References: <20040429202654.GA9971@dhcp193.mvista.com>	 <20040429224243.L16407@flint.arm.linux.org.uk>	 <40918375.2090806@mvista.com> <1083286226.20473.159.camel@gaston>
In-Reply-To: <1083286226.20473.159.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:

>>Now that you mention it, device power hotplug should be synchronous, to 
>>make sure the power management application has reacted to the changed 
>>state prior to the device going into actual service (in the case of a 
>>resume).
> 
> 
> This is dangerous.
> 
> If the device you are suspending is on the VM path in any way,
> beeing synchronous with a userland call can deadlock you solid.
> 
> This is even more true for system suspend where we are suspending
> all devices including the main swap/storage.

Well, this feature is intended to allow power management of appropriate 
devices; using sysfs or a driver call to individually suspend a device 
required for proper system operation would be a danger, hotplug 
notification or no.  And the individual device notifications provided by 
the patch under discussion are not for use during a system-wide 
suspend/resume sequence.  I would imagine system suspend/resume would be 
separate events that probably would not notify of the individual device 
suspends/resumes performed as a consequence.  At any rate, yes, this 
would occur outside of the code path that freezes processes and such.

-- 
Todd Poynor
MontaVista Software

