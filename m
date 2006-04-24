Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751255AbWDXUmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbWDXUmu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 16:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWDXUmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 16:42:50 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:48087 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751255AbWDXUmt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 16:42:49 -0400
Message-ID: <444D3846.7090006@watson.ibm.com>
Date: Mon, 24 Apr 2006 16:42:46 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hirokazu Takahashi <taka@valinux.co.jp>
CC: sekharan@us.ibm.com, akpm@osdl.org, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Subject: Re: [ckrm-tech] [RFC] [PATCH 00/12] CKRM after a major overhaul
References: <1145638722.14804.0.camel@linuxchandra>	<20060421155727.4212c41c.akpm@osdl.org>	<1145670536.15389.132.camel@linuxchandra> <20060424.104701.10576428.taka@valinux.co.jp>
In-Reply-To: <20060424.104701.10576428.taka@valinux.co.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hirokazu Takahashi wrote:

>  
>
>>i/o controller: This controller is not ported to the framework posted,
>>but can be taken for a prototype version. New version would be simpler
>>though.
>>    
>>
>
>I think controlling I/O bandwidth is right way to go.
>  
>
Thanks. Obviously we agree heartily :-)

>However, I think you need to change the design of the controller a bit.
>A lot of I/O requests processes issue will be handled by other contexts.
>There are AIO, journaling, pdflush and vmscan, which some kernel threads
>treat instead of the processes.
>
>The current design looks not to care about this.
>  
>
Yes. The current design, which builds directly on top of the CFQ 
scheduler, does not attempt to treat kernel
threads specially in order to account the I/O they're doing on behalf of 
others properly. This was mainly because
of the desire to keep the controller simple.

I suspect pdflush and vmscan I/O is never going to be properly 
attributable and journaling may be possible but
unlikely to be worth it given the risks of throttling it ?  AIO is 
likely to be something we can address if there is
consensus that one is willing to pay the price of tracking the source 
through the I/O submission layers.

I suppose this would be a good time to dust off the I/O controller and 
post it so discussions can become more
concrete.

But as always, changes in the design and implementation are always 
welcome....

Regards,
Shailabh


>Thanks,
>Hirokazu Takahashi.
>  
>

