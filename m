Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbULKD3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbULKD3Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 22:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261814AbULKD3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 22:29:25 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:33778 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261208AbULKD3V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 22:29:21 -0500
Message-ID: <41BA698E.8000603@mvista.com>
Date: Fri, 10 Dec 2004 19:29:18 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
CC: Lee Revell <rlrevell@joe-job.com>, dipankar@in.ibm.com,
       ganzinger@mvista.com, Manfred Spraul <manfred@colorfullife.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: RCU question
References: <41B8E6F1.4070007@mvista.com> <20041210043102.GC4161@in.ibm.com>  <41B9FC3F.50601@mvista.com>  <20041210204003.GC4073@in.ibm.com> <1102711532.29919.35.camel@krustophenia.net> <41BA0ECF.1060203@mvista.com> <Pine.LNX.4.61.0412101558240.24986@montezuma.fsmlabs.com> <41BA59F6.5010309@mvista.com> <Pine.LNX.4.61.0412101943260.1101@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.61.0412101943260.1101@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> On Fri, 10 Dec 2004, George Anzinger wrote:
> 
> 
>>>But that's a deadlock and if you enable interrupts you race.
>>
>>Again, I remind you we are in the idle task.  Nothing more important to do.
>>Or do you mean that softirq_pending() will NEVER return false?
>>
>>The other question is: "Is useful work being done?"
> 
> 
> We're in the idle task but obviously interrupts (such as network) are 
> still coming in. So you may take an interrupt after your while 
> (softirq_pending()) loop has exited.

That is ok.  Either we have interrupts off and no softirqs are pending and we 
proceed to the "hlt" (where the interrupt will be taken), or softirqs are 
pending, we turn interrupts on, do the softirq, turn interrupts off and try 
again.  Unless some tasklet (RCU?) never "gives up" or we will exit the while 
with interrupts off and move on to the "hlt".  Or did I miss something?
-
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

