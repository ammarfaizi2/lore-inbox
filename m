Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751850AbWB1QIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbWB1QIV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 11:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751851AbWB1QIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 11:08:21 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:13023 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751850AbWB1QIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 11:08:20 -0500
Message-ID: <44047565.3090202@sgi.com>
Date: Tue, 28 Feb 2006 17:08:05 +0100
From: Jes Sorensen <jes@sgi.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland Dreier <rdreier@cisco.com>
CC: "Bryan O'Sullivan" <bos@pathscale.com>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] Define wc_wmb, a write barrier for PCI write combining
References: <1140841250.2587.33.camel@localhost.localdomain>	<yq08xrvhkee.fsf@jaguar.mkp.net> <adar75nlcar.fsf@cisco.com>
In-Reply-To: <adar75nlcar.fsf@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
>     Jes> Could you explain why the current mmiowb() API won't suffice
>     Jes> for this?  It seems that this is basically trying to achieve
>     Jes> the same thing.
> 
> I don't believe mmiowb() is at all the same thing.  mmiowb() is all
> about ordering writes between _different_ CPUs without incurring the
> cost of flushing posted writes by issuing a read on the bus.

Not quite correct as far as I understand it. mmiowb() is supposed to
guarantee that writes to MMIO space have completed before continuing.
That of course covers the multi-CPU case, but it should also cover the
write-combining case.

 > wc_wmb()
> would just act like a true wmb(), even when using write-combining
> regions on x86 -- in other words, there would be no cross-CPU synchronization.

I wary of adding yet another variation unless there is a clear
distinction between them that is easy to understandn for driver authors.

Cheers,
Jes
