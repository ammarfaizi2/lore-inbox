Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261877AbVCGWVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbVCGWVG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 17:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbVCGVZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 16:25:36 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:43406 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261557AbVCGUul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 15:50:41 -0500
Message-ID: <422CBE9F.1090906@acm.org>
Date: Mon, 07 Mar 2005 14:50:39 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [PATCH] NMI/CMOS RTC race fix for x86-64
References: <422CA1FA.1010903@acm.org> <m1ll8zmfzc.fsf@muc.de>
In-Reply-To: <m1ll8zmfzc.fsf@muc.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>Corey Minyard <minyard@acm.org> writes:
>
>  
>
>>This patch fixes a race between the CMOS clock setting and the NMI
>>code.  The NMI code indiscriminatly sets index registers and values
>>in the same place the CMOS clock is set.  If you are setting the
>>CMOS clock and an NMI occurs, Bad values could be written to or
>>read from the CMOS RAM, or the NMI operation might not occur
>>correctly.
>>
>>    
>>
>
>In general you should send all x86-64 patches to me. I would have
>eventually merged it from i386 anyways if it was good.
>
>But in this case it isnt. Instead of all this complexity 
>just remove the NMI reassert code from the NMI handler.
>It is oudated and mostly useless on modern systems anyways.
>  
>
"mostly useless" and "completely useless" are two different things.

If you run with nmi_watchdog=0, then this code actually does something
useful, which is what I assume you mean by "mostly useless".  I'm all for
removing useless code, so I'd be fine with just removing the code.  But
something really needs to be done.

Do you want me to submit a patch that simply removes this?

-Corey

>Since the NMI watchdog runs regularly even if an NMI is missed
>it will be eventually handled. And even when it doesn't run
>it doesn't matter much because NMI does nothing essential.
>
>-Andi
>  
>

