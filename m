Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263868AbUE1UNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263868AbUE1UNa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 16:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263869AbUE1UN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 16:13:29 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:52374 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263868AbUE1UNP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 16:13:15 -0400
Message-ID: <40B79DB0.6090209@us.ibm.com>
Date: Fri, 28 May 2004 13:14:40 -0700
From: Nivedita Singhvi <niv@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Arjan van de Ven <arjanv@redhat.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Andrew Morton <akpm@osdl.org>,
       Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_IRQBALANCE for AMD64?
References: <7F740D512C7C1046AB53446D372001730182BAE2@scsmsx402.amr.corp.intel.com> <40B7797F.2090204@pobox.com> <17750000.1085766378@flay> <20040528175724.GC9898@devserv.devel.redhat.com> <40B7984E.7040208@us.ibm.com> <40B799EB.8060000@pobox.com>
In-Reply-To: <40B799EB.8060000@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Nivedita Singhvi wrote:

> Network is one of the areas where you _don't_ want to be constantly 
> pointing your NIC's irq to different CPUs.
> 
> Cache affinity, packet re-ordering problems, and other fun ensue.
> 
>     Jeff

I agree that there is a tradeoff point - we need the cache
affinity, but you also want to employ the other CPUs which
might be idle in the system - so there is a timeframe that
is ideal to have one CPU pick up interrupts, and then move
on to another - but that timeframe is surely shorter than
then every 5 mins or so that the irq daemon might run,
correct?

Also, yep, packet re-ordering is an issue for TCP connections,
and we do have mechanisms in the kernel to address it to some
extent - so we don't trigger fast retransmit unnecessarily.
And if you have a lot of UDP and other traffic, or short lived
connections, then you are unnecessarily subjecting them to
a less ideal environment.

I agree that this is very tricky stuff to optimize, and I
certainly don't know how to go about picking the best
heuristic here, but I am wondering how the frequency with
which a user space daemon might run (and you don't want it
to run too often given the cost) would be able to handle
something that does require finer granularity. Or is it
everybody's understanding that fine grained balancing is
not needed?

thanks,
Nivedita



