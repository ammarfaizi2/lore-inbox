Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262095AbUJZEVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbUJZEVh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 00:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbUJZESx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 00:18:53 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:41117 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262080AbUJZBlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 21:41:31 -0400
Message-ID: <417D918E.8030804@nortelnetworks.com>
Date: Mon, 25 Oct 2004 17:51:42 -0600
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
References: <F989B1573A3A644BAB3920FBECA4D25A011F96CB@orsmsx407> <41782771.3060404@mvista.com> <41783AE7.8040705@nortelnetworks.com> <417D8846.3090308@mvista.com>
In-Reply-To: <417D8846.3090308@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Anzinger wrote:
> Chris Friesen wrote:

>> It should be possible to be clever about this.  Most processes don't 
>> use their timeslice, so if we have a previous timer running, just keep 
>> track of how much beyond that timer our timeslice will be.  If we 
>> context switch before the timer expiry, well and good.  If the timer 
>> expires, set it for what's left of our timeslice.
> 
> 
> Me thinks that rather quickly devolves to a periodic tick.

In the busy case, yes.  But on an idle system you get tickless behaviour.

It's still going to be load-sensitive, since you are doing additional work to 
keep track of the timer/timeout values.  But it saves work if reprogramming the 
timer is time-consuming compared to simply reading it.  On something like the 
ppc, it probably doesn't buy you much since the decrementer is cheap to program.

Chris
