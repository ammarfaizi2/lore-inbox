Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268199AbUHQMSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268199AbUHQMSy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 08:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268192AbUHQMSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 08:18:54 -0400
Received: from [195.23.16.24] ([195.23.16.24]:25486 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S268199AbUHQMOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 08:14:37 -0400
Message-ID: <4121F6A8.7030503@grupopie.com>
Date: Tue, 17 Aug 2004 13:14:32 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
Cc: Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
References: <8634.1092485844@ocs3.ocs.com.au>
In-Reply-To: <8634.1092485844@ocs3.ocs.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.27.0.4; VDF: 6.27.0.13; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> On Sat, 14 Aug 2004 05:50:50 +0100, 
> Paulo Marques <pmarques@grupopie.com> wrote:
> 
>>Well, I found some time and decided to give it a go :)
> 
> 
> This patch regresses some recent changes to kallsyms which handle
> aliased symbols, IOW symbols with the same address.  The speed up is
> very good, but it has two problems with repeated addresses.

Hi,

I've been messing with scripts/kallsyms.c to try to follow Andi Kleen's 
suggestion of calculating the markers at compile time. This would make 
the code in kernel/kallsyms.c much simpler.

In the process I could get rid of the aliased symbols at compile time 
also. There are only 2 places where they might matter:

  - the kallsyms_lookup_name function. GREP'ing through the code shows 
that this function is only used in arch/ppc64/xmon/xmon.c. Does xmon 
need to know about aliased symbols?

  - /proc/kallsyms. Of course this is a problem, because since this is 
available in user space we can break applications that rely on having 
aliased symbols there. Are there any?

I have no problem in keeping the aliased symbols as the code to handle 
them is not that big anyway. Is just that it hurts my programmer 
instincts to leave completely useless code hanging around. If it is not 
completely useless, then it's another story :)

Any comments will be greatly appreciated,

-- 
Paulo Marques - www.grupopie.com

