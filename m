Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264098AbUECWFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264098AbUECWFf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 18:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264102AbUECWFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 18:05:35 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:43759 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S264098AbUECWF0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 18:05:26 -0400
Message-ID: <4096C202.10206@mvista.com>
Date: Mon, 03 May 2004 15:04:50 -0700
From: Todd Poynor <tpoynor@mvista.com>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ncunningham@linuxmail.org
CC: Russell King <rmk+lkml@arm.linux.org.uk>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Patrick Mochel <mochel@digitalimplant.org>,
       linux-hotplug-devel@lists.sourceforge.net,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Hotplug for device power state changes
References: <20040429202654.GA9971@dhcp193.mvista.com> <20040429224243.L16407@flint.arm.linux.org.uk> <40918375.2090806@mvista.com> <1083286226.20473.159.camel@gaston> <20040430093012.A30928@flint.arm.linux.org.uk> <4092B02C.5090205@mvista.com> <opr7anr02fshwjtr@laptop-linux.wpcb.org.au>
In-Reply-To: <opr7anr02fshwjtr@laptop-linux.wpcb.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham wrote:

> Given this model, I would suggest that hotplug should silently drop any  
> events that happen while suspending, and queue events that occur while  
> resuming until the kernelspace part of resuming is complete and 
> userspace  can run as normal. It shouldn't rely upon device 
> suspend/resume  notifications because they can and do happen while we're 
> still in the  process of suspending and resuming. The means to detect 
> whether we're  suspending or resuming or running normally could be 
> implemented as a  simple function that could test the status of the 
> different suspend  implementations.

If needed, there's already a "system_running" flag used to ignore the 
underlying usermode helper execution if requested prior to the system 
being ready for such an event at boot time, and perhaps this could be 
co-opted or extended for use at suspend/resume time.  Sounds like the 
correct behavior is to leave the exec requests queued until userspace is 
resumed (and I'd assume that device power state notifications are not 
needed, but perhaps hotplug events and/or modprobes of drivers for 
hotpluggable devices and associated features may be generated at resume 
time).  Thanks,

-- 
Todd Poynor
MontaVista Software

