Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261659AbUL3Ph2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbUL3Ph2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 10:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbUL3Ph1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 10:37:27 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:652 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261659AbUL3PhM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 10:37:12 -0500
Message-ID: <41D42096.3020708@colorfullife.com>
Date: Thu, 30 Dec 2004 16:36:54 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oleg Nesterov <oleg@tv-sign.ru>
CC: linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] rcu: speed up quiescent state detection
References: <41D429C5.F32D7161@tv-sign.ru>
In-Reply-To: <41D429C5.F32D7161@tv-sign.ru>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov wrote:

>On top of Manfred's 'rcu: simplify quiescent state detection', see
>http://marc.theaimsgroup.com/?l=linux-kernel&m=110433412126392
>
>Let's suppose that cpu is running idle thread or user level process,
>and the grace period was started.
>
>Afaics, currently we need 2 local timer interrupts to happen before
>this cpu can end its grace period.
>
>  
>
I agree with you that the design is not optimal, but I must think about 
it a bit more.
Right now the grace period handling consists out of three steps for each 
cpu:
- start grace period (from timer irq)
- log quiescent state in ->passed_quiesc (from timer or schedule())
- end grace period (from timer irq)

This requires at least two timer ticks. Your patch would reduce that to 
one timer tick, without changing the approach. I'm still thinking about 
the design change I proposed: In each quiescent state: check if there is 
a running grace period and if there is one, then mark the current cpu as 
done.

Dipankar: What do you think?

--
    Manfred
