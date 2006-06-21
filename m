Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751470AbWFUKFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbWFUKFj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 06:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbWFUKFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 06:05:39 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:1964 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751470AbWFUKFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 06:05:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:x-x-sender:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type:from;
        b=Co5/RrGu+7vlReXf76haifSdTtpSWA8D8npwHfu6JnQuE2DJAE34Zq9p9J8jR+/QzOl4LStDqus4X70LHJAtH/geeeZod9VCTfp2RQmZBopX2bH1HhwhQ95eHFYjWaoLj87eCtmQfb8x7uPkSPCiC+vBaMwkX6miKMtyRaXC+Rc=
Date: Wed, 21 Jun 2006 12:05:49 +0100 (BST)
X-X-Sender: simlo@localhost.localdomain
To: Steven Rostedt <rostedt@goodmis.org>
cc: Esben Nielsen <nielsen.esben@googlemail.com>,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: Why can't I set the priority of softirq-hrt? (Re: 2.6.17-rt1)
In-Reply-To: <Pine.LNX.4.58.0606210418160.29673@gandalf.stny.rr.com>
Message-ID: <Pine.LNX.4.64.0606211204220.10723@localhost.localdomain>
References: <20060618070641.GA6759@elte.hu>  <Pine.LNX.4.64.0606201656230.11643@localhost.localdomain>
  <1150816429.6780.222.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0606201725550.11643@localhost.localdomain> 
 <Pine.LNX.4.58.0606201229310.729@gandalf.stny.rr.com> 
 <Pine.LNX.4.64.0606201903030.11643@localhost.localdomain>
 <1150824092.6780.255.camel@localhost.localdomain>
 <Pine.LNX.4.64.0606202217160.11643@localhost.localdomain>
 <Pine.LNX.4.58.0606210418160.29673@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
From: Esben Nielsen <nielsen.esben@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 21 Jun 2006, Steven Rostedt wrote:

>
> On Tue, 20 Jun 2006, Esben Nielsen wrote:
>
>>
>>> I have to check, whether the priority is propagated when the softirq is
>>> blocked on a lock. If not its a bug and has to be fixed.
>>
>> I think the simplest solution would be to add
>>
>>          if (p->blocked_on)
>>                  wake_up_process(p);
>>
>> in __setscheduler().
>>
>
> Except that wake_up_process calls try_to_wakeup which grabs the runqueue
> lock, which unfortunately is already held when __setscheduler is called.
>

Yeah, I saw. Move it out in setscheduler() then. I'll try to fix it, but I 
am not sure I can make a test if it works.

Esben

> -- Steve
>
