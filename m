Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262159AbULLWlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262159AbULLWlk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 17:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbULLWlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 17:41:39 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:26061 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262159AbULLWlh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 17:41:37 -0500
Message-ID: <41BCC8F8.3030102@colorfullife.com>
Date: Sun, 12 Dec 2004 23:40:56 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: george@mvista.com
CC: Andrea Arcangeli <andrea@suse.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Lee Revell <rlrevell@joe-job.com>, dipankar@in.ibm.com,
       ganzinger@mvista.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: RCU question
References: <41BA0ECF.1060203@mvista.com> <Pine.LNX.4.61.0412101558240.24986@montezuma.fsmlabs.com> <41BA59F6.5010309@mvista.com> <Pine.LNX.4.61.0412101943260.1101@montezuma.fsmlabs.com> <41BA698E.8000603@mvista.com> <Pine.LNX.4.61.0412110751020.5214@montezuma.fsmlabs.com> <41BB2108.70606@colorfullife.com> <41BB25B2.90303@mvista.com> <Pine.LNX.4.61.0412111947280.7847@montezuma.fsmlabs.com> <41BC0854.4010503@colorfullife.com> <20041212093714.GL16322@dualathlon.random> <41BC1BF9.70701@colorfullife.com> <41BC771D.6020506@mvista.com>
In-Reply-To: <41BC771D.6020506@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Anzinger wrote:

>
> The "normal" idle loop just looks at the need_resched flag and goes 
> right back to the hlt,

That's the problem: If a the tasklet does a wakeup then the reschedule 
is delayed until the next interrupt. Testing need_resched and executing 
hlt must be atomic, but it isn't - NMIs break the atomicity.
Not a big deal, except if someone implements a tickless kernel. I think 
we can ignore it for now [or was the thread started by someone who 
want's to disable the hardware timer when the system is really idle?]

--
    Manfred
