Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271186AbUJVDGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271186AbUJVDGU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 23:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271057AbUJVC5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 22:57:00 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:44472 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S271202AbUJVCur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 22:50:47 -0400
Message-ID: <41783AE7.8040705@nortelnetworks.com>
Date: Thu, 21 Oct 2004 16:40:39 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: george@mvista.com
CC: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       root@chaos.analogic.com, "Brown, Len" <len.brown@intel.com>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: gradual timeofday overhaul
References: <F989B1573A3A644BAB3920FBECA4D25A011F96CB@orsmsx407> <41782771.3060404@mvista.com>
In-Reply-To: <41782771.3060404@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Anzinger wrote:

> Well, that is part of the accounting overhead the increases with context 
> switch rate.  You also need to include the time it takes to figure out 
> which of the time limits is closes (run time limit, profile time, slice 
> time, etc).  Then, you also need to remove the timer when switching 
> away.  No, it is not a lot, but it is way more than the nothing we do 
> when we can turn it all over to the periodic tick.  The choice is load 
> sensitive overhead vs flat overhead.

It should be possible to be clever about this.  Most processes don't use their 
timeslice, so if we have a previous timer running, just keep track of how much 
beyond that timer our timeslice will be.  If we context switch before the timer 
expiry, well and good.  If the timer expires, set it for what's left of our 
timeslice.

Chris
