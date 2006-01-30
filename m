Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750900AbWA3IaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbWA3IaY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 03:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbWA3IaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 03:30:24 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:61156 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750703AbWA3IaY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 03:30:24 -0500
Message-ID: <43DDCFD0.1090505@aitel.hist.no>
Date: Mon, 30 Jan 2006 09:35:28 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nikita Danilov <nikita@clusterfs.com>
CC: Howard Chu <hyc@symas.com>, Christopher Friesen <cfriesen@nortel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hancockr@shaw.ca
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
References: <20060124225919.GC12566@suse.de>	<20060124232142.GB6174@inferi.kami.home>	<20060125090240.GA12651@suse.de>	<20060125121125.GH5465@suse.de>	<43D78262.2050809@symas.com>	<43D7BA0F.5010907@nortel.com>	<43D7C2F0.5020108@symas.com>	<43D7CAAB.9070008@yahoo.com.au>	<43D7D234.6060005@symas.com> <17368.42664.299094.987071@gargle.gargle.HOWL>
In-Reply-To: <17368.42664.299094.987071@gargle.gargle.HOWL>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov wrote:

>Howard Chu writes:
>
>[...]
>
> > 
> > A straightforward reading of the language here says the decision happens 
> > "when pthread_mutex_unlock() is called" and not at any later time. There 
> > is nothing here to support your interpretation.
> > >
> > > I think the intention of the wording is that for deterministic policies,
> > > it is clear that the waiting threads are actually worken and reevaluated
> > > for scheduling. In the case of SCHED_OTHER, it means basically nothing,
> > > considering the scheduling policy is arbitrary.
> > >
> > Clearly the point is that one of the waiting threads is waken and gets 
> > the mutex, and it doesn't matter which thread is chosen. I.e., whatever 
>
>Note that this behavior directly leads to "convoy formation": if that
>woken thread T0 does not immediately run (e.g., because there are higher
>priority threads) but still already owns the mutex, then other running
>threads contending for this mutex will block waiting for T0, forming a
>convoy.
>
I just wonder - what is the problem with this convoy formation?
It can only happen when the cpu is overloaded, and in that case
someone has to wait.  In this case, the mutex waiters. 

Aggressively handing the cpu to whoever holds a mutex will mean the
mutexes are free more of the time - but it will *not* mean less waiting in
tghe system.  You just changes who waits.

Helge Hafting

