Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261882AbUJZBZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbUJZBZt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 21:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbUJZBWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 21:22:08 -0400
Received: from zeus.kernel.org ([204.152.189.113]:4051 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261893AbUJZBSs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 21:18:48 -0400
Message-ID: <417D8846.3090308@mvista.com>
Date: Mon, 25 Oct 2004 16:12:06 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortelnetworks.com>
CC: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       root@chaos.analogic.com, "Brown, Len" <len.brown@intel.com>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: gradual timeofday overhaul
References: <F989B1573A3A644BAB3920FBECA4D25A011F96CB@orsmsx407> <41782771.3060404@mvista.com> <41783AE7.8040705@nortelnetworks.com>
In-Reply-To: <41783AE7.8040705@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> George Anzinger wrote:
> 
>> Well, that is part of the accounting overhead the increases with 
>> context switch rate.  You also need to include the time it takes to 
>> figure out which of the time limits is closes (run time limit, profile 
>> time, slice time, etc).  Then, you also need to remove the timer when 
>> switching away.  No, it is not a lot, but it is way more than the 
>> nothing we do when we can turn it all over to the periodic tick.  The 
>> choice is load sensitive overhead vs flat overhead.
> 
> 
> It should be possible to be clever about this.  Most processes don't use 
> their timeslice, so if we have a previous timer running, just keep track 
> of how much beyond that timer our timeslice will be.  If we context 
> switch before the timer expiry, well and good.  If the timer expires, 
> set it for what's left of our timeslice.

Me thinks that rather quickly devolves to a periodic tick.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

