Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbWC3OvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWC3OvX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 09:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbWC3OvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 09:51:22 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:56045 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1750718AbWC3OvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 09:51:21 -0500
Message-ID: <442BF083.2070104@bull.net>
Date: Thu, 30 Mar 2006 16:51:47 +0200
From: Pierre PEIFFER <pierre.peiffer@bull.net>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] 2.6.16 - futex: small optimization (?)
References: <4428E7B7.8040408@bull.net> <a36005b50603280702n2979d8ddh97484615ea9d4f3a@mail.gmail.com> <442A8933.6090408@bull.net> <442AA708.3030802@cosmosbay.com>
In-Reply-To: <442AA708.3030802@cosmosbay.com>
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 30/03/2006 16:53:27,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 30/03/2006 16:53:27,
	Serialize complete at 30/03/2006 16:53:27
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet a écrit :
> I think your analysis is correct Pierre, but you speak of 
> 'task-switches', where there is only a spinlock involved :
> 
> On UP case : a wake_up_all() wont preempt current thread : it will 
> task-switch only when current thread exits kernel mode.
> 
> On PREEMPT case : wake_up_all() wont preempt current thread (because 
> current thread is holding bh->lock).
> 
> On SMP : the awaken thread will spin some time on bh->lock, but not 
> task-switch again.

Ok, yes, you're right, thanks.

> 
> On RT kernel, this might be different of course...

So, I confirm it only happens on RT kernel ...
... but my patch does not work on those kernels :-/

In fact, I don't really see what's wrong ?

-- 
Pierre

