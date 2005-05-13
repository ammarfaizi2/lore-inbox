Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262358AbVEMNNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262358AbVEMNNi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 09:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262359AbVEMNNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 09:13:38 -0400
Received: from mail.timesys.com ([65.117.135.102]:9859 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S262358AbVEMNNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 09:13:25 -0400
Message-ID: <4284A7B6.4090408@timesys.com>
Date: Fri, 13 May 2005 09:12:22 -0400
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       john cooper <john.cooper@timesys.com>
Subject: Re: RT and Cascade interrupts
References: <Pine.LNX.4.44.0505120740270.31369-100000@dhcp153.mvista.com> <20050513074439.GB25458@elte.hu>
In-Reply-To: <20050513074439.GB25458@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 May 2005 13:07:33.0296 (UTC) FILETIME=[B9D24300:01C557BC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Daniel Walker <dwalker@mvista.com> wrote:
> 
> 
>>	It seems like the cascade interrupts could run in threads, but 
>>i386 doesn't, and I know ARM crashed with cascades in threads. You may 
>>have a bit of a slow down, but it seems possible. Does anyone have 
>>some reasoning for why we aren't running the cascades in threads?
> 
> 
> are the x86 cascade interrupts real ones in fact? Normally they should 
> never trigger directly. (except on ARM which has a completely different 
> notion of cascade irq)

I just caught this thread in the corner of my eye.

I'm seeing the BUG assert in kernel/timers.c:cascade()
kick in (tmp->base is somehow 0) during a test which
creates a few tasks of priority higher than ksoftirqd.
This race doesn't happen if ksoftirqd's priority is
elevated (eg: chrt -f -p 75 2) so the -RT patch might
be opening up a window here.

I'm in the process of investigating this and see a few
potential suspects but was wondering if anyone else has
seen this behavior?

-john

-- 
john.cooper@timesys.com
