Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268322AbUH2V0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268322AbUH2V0o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 17:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268326AbUH2V0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 17:26:43 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49892 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268322AbUH2V0a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 17:26:30 -0400
Message-ID: <413249F7.50904@pobox.com>
Date: Sun, 29 Aug 2004 17:26:15 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Love <rml@ximian.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>
Subject: Re: interrupt cpu time accounting?
References: <41323FA8.80203@pobox.com> <1093814102.2595.8.camel@localhost>
In-Reply-To: <1093814102.2595.8.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> On Sun, 2004-08-29 at 16:42 -0400, Jeff Garzik wrote:
> 
>>Does the kernel scheduler notice when a CPU spends a lot of time doing 
>>interrupt processing?
>>
>>For many network configurations you get the best cache affinity, etc. if 
>>you lock network interrupts to a single CPU.  However, on a box with 
>>high network load, that could mean that that CPU is spending more time 
>>processing interrupts than doing Real Work(tm).
>>
>>Will the scheduler "notice" this, and increasingly schedule processes 
>>away from the interrupt-heavy CPU?
> 
> 
> Nope, not explicitly anyhow.
> 
> Implicitly, at least, the load balancer will ensure that the runnable
> processes on the processor do not get "backed up" due to the delayed
> processing but you will still have the balanced minimum number of
> processes there.

What piece of code defines "balanced"?  :)


> I don't know whether the answer is to use cpu affinity and not schedule
> processes on that processor when you bind interrupts to it, or an
> automatic algorithm in the load balance for doing it, but that is a neat
> idea.

Less a neat idea, and more IMHO recognition of a problem that needs solving.

I am worried that processes will get starved if one CPU is _heavily_ 
loaded servicing interrupts, and the others are not.

Regards,

	Jeff


