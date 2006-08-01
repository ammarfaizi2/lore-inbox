Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbWHAW2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWHAW2q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 18:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750703AbWHAW2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 18:28:46 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:44207 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750700AbWHAW2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 18:28:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:x-x-sender:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type:from;
        b=M/usexvifh0/p070N2JBGNXxZEOlwe5/KoTRJlw61sjyDDTlAnJLD5hmkP+QE72vQM7ZTZeM7xA4FpfrSp2GJubjhy36PT4VnTmEIHPJxELX2Mhkb2awN4jWGolRbVRDe/lrZj/sOjzDL2gk8UKR8DoMXVtMNqHn2D7KKbU/SNU=
Date: Wed, 2 Aug 2006 00:28:58 +0100 (BST)
X-X-Sender: simlo@localhost.localdomain
To: Steven Rostedt <rostedt@goodmis.org>
cc: Darren Hart <dvhltc@us.ibm.com>,
       Esben Nielsen <nielsen.esben@googlemail.com>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [-rt] Fix race condition and following BUG in PI-futex
In-Reply-To: <1154466456.30391.12.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0608020007350.10605@localhost.localdomain>
References: <Pine.LNX.4.64.0608011931560.10605@localhost.localdomain> 
 <1154456580.25983.25.camel@localhost.localdomain>  <200608011322.53638.dvhltc@us.ibm.com>
 <1154466456.30391.12.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
From: Esben Nielsen <nielsen.esben@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 1 Aug 2006, Steven Rostedt wrote:

> On Tue, 2006-08-01 at 13:22 -0700, Darren Hart wrote:
>
>>>>
>>>>   	list_del_init(&pi_state->owner->pi_state_list);
>>>>   	list_add(&pi_state->list, &new_owner->pi_state_list);
>>>>   	pi_state->owner = new_owner;
>>>> +	atomic_inc(&pi_state->refcount);
>>>
>>> There really needs to be a get_pi_state() or some variant. Having to do
>>> a manual atomic_inc is very dangerous.
>>
>> I understand the need to grab the wait_lock in order to serialize
>> rt_mutex_next_owner(), but why the addition of of the atomic_inc() and the
>> free_pi_state() ?  And if we do need them, shouldn't we place them around the
>> use of the pi_state, rather than just before the unlock calls?
>
> Hmm, is the inc really needed?  The hb->lock is held through this and
> the pi_state can't go away while that lock is held.

I was going to ask about that... If you say so they can go. I just added 
the inc/dec to be sure.

Esben

>
> -- Steve
>
>
