Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261960AbULKQed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbULKQed (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 11:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261964AbULKQed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 11:34:33 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:50369 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261960AbULKQeb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 11:34:31 -0500
Message-ID: <41BB2108.70606@colorfullife.com>
Date: Sat, 11 Dec 2004 17:32:08 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
CC: George Anzinger <george@mvista.com>, Lee Revell <rlrevell@joe-job.com>,
       dipankar@in.ibm.com, ganzinger@mvista.com,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: RCU question
References: <41B8E6F1.4070007@mvista.com> <20041210043102.GC4161@in.ibm.com>  <41B9FC3F.50601@mvista.com>  <20041210204003.GC4073@in.ibm.com> <1102711532.29919.35.camel@krustophenia.net> <41BA0ECF.1060203@mvista.com> <Pine.LNX.4.61.0412101558240.24986@montezuma.fsmlabs.com> <41BA59F6.5010309@mvista.com> <Pine.LNX.4.61.0412101943260.1101@montezuma.fsmlabs.com> <41BA698E.8000603@mvista.com> <Pine.LNX.4.61.0412110751020.5214@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.61.0412110751020.5214@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:

>On Fri, 10 Dec 2004, George Anzinger wrote:
>
>  
>
>>That is ok.  Either we have interrupts off and no softirqs are pending and we
>>proceed to the "hlt" (where the interrupt will be taken), or softirqs are
>>pending, we turn interrupts on, do the softirq, turn interrupts off and try
>>again.  Unless some tasklet (RCU?) never "gives up" or we will exit the while
>>with interrupts off and move on to the "hlt".  Or did I miss something?
>>    
>>
>
>But the point is that you cannot execute hlt with interrupts disabled.
>  
>
The trick is the sti instruction: It enables interrupt processing after 
the following instruction.

Thus
    sti
    hlt

cannot race - it atomically enables interrupts and waits.

--
    Manfred

