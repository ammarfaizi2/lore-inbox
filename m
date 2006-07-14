Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422742AbWGNUb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422742AbWGNUb3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 16:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161298AbWGNUb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 16:31:29 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:3832 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161292AbWGNUb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 16:31:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:x-x-sender:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type:from;
        b=DteOkJHv2zwqKsN4BxtyxKFUNplBgulZ6p4vno0brL3sTJE2icoxNQJ66I67HCtCpnQsOnw1be4rbzIPAC8DO7pSWwSfR84eyViTOpfYL6XvRZt8qDAXtvkjO4Mj6blo3yNf/ywMS9pYYr47g6eKyTkdohm55Fb0rd7lxFA+X40=
Date: Fri, 14 Jul 2006 22:31:41 +0100 (BST)
X-X-Sender: simlo@localhost.localdomain
To: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: Where is RLIMIT_RT_CPU?
In-Reply-To: <1152869952.6374.8.camel@idefix.homelinux.org>
Message-ID: <Pine.LNX.4.64.0607142037110.13100@localhost.localdomain>
References: <1152663825.27958.5.camel@localhost>  <1152809039.8237.48.camel@mindpipe>
 <1152869952.6374.8.camel@idefix.homelinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
From: Esben Nielsen <nielsen.esben@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 14 Jul 2006, Jean-Marc Valin wrote:

>> It was not merged.
>>
>> This problem should be addressed by a userspace RT watchdog.  Ubuntu
>> should not have shipped their system with unlimited non-root realtime
>> enabled and no watchdog.
>
> Does such a daemon currently exist? Even then, is there any way to
> police all unprivileged RT apps without introducing an O(N) operation
> running continuously at max rt priority? Sort of defeats the purpose of
> having an O(1) scheduler, no? I assume the RT check can be some in O(1)
> time in the kernel, right?
>

Can't you just make a prio 1 task which signals a prio 99 once say every 
second. If the priority 99 task doesn't get the signal after say 2 
seconds, it will look for a rt task running wild. At worst it will have to do
an O(n) algorith when things have gone wrong, not when everything is 
working.

Esben

> About Ubuntu, I agree it wasn't a smart thing to do (I'm not an Ubuntu
> devel, so I don't know what the reason was), but it would be nice if
> this could be fixed without having to entirely remove the unprivileged
> real-time feature. In the end, I'm not sure what the best solution is
> (just an RT audio developer).
>
> 	Jean-Marc
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
