Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbULLKXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbULLKXk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 05:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbULLKXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 05:23:40 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:33224 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261763AbULLKXi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 05:23:38 -0500
Message-ID: <41BC1BF9.70701@colorfullife.com>
Date: Sun, 12 Dec 2004 11:22:49 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       George Anzinger <george@mvista.com>, Lee Revell <rlrevell@joe-job.com>,
       dipankar@in.ibm.com, ganzinger@mvista.com,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: RCU question
References: <41BA0ECF.1060203@mvista.com> <Pine.LNX.4.61.0412101558240.24986@montezuma.fsmlabs.com> <41BA59F6.5010309@mvista.com> <Pine.LNX.4.61.0412101943260.1101@montezuma.fsmlabs.com> <41BA698E.8000603@mvista.com> <Pine.LNX.4.61.0412110751020.5214@montezuma.fsmlabs.com> <41BB2108.70606@colorfullife.com> <41BB25B2.90303@mvista.com> <Pine.LNX.4.61.0412111947280.7847@montezuma.fsmlabs.com> <41BC0854.4010503@colorfullife.com> <20041212093714.GL16322@dualathlon.random>
In-Reply-To: <20041212093714.GL16322@dualathlon.random>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

>On Sun, Dec 12, 2004 at 09:59:00AM +0100, Manfred Spraul wrote:
>  
>
>>It means that our NMI irq return path should check if it points to a hlt 
>>instruction and if yes, then increase the saved EIP by one before doing 
>>the iretd, right?
>>    
>>
>
>I don't think we'll ever post any event through nmi, so it doesn't
>matter. We only care to be waken by real irqs, not nmi/smi. Idle loop is
>fine to ignore the actions of the nmi handlers and to hang into the
>"hlt".
>  
>
No, You misunderstood the problem:

sti
** NMI handler
** normal interrupt arrives, is queued by the cpu
** irqd from NMI handler
** cpu notices the normal interrupt, handles it.
** normal interrupt does a wakeup, schedules a tasklet, whatever
** irqd from normal interupt
hlt << cpu sleeps.

Thus: lost wakeup.

--
    Manfred
**
