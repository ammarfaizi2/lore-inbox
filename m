Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbWG0UtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWG0UtI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 16:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWG0UtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 16:49:07 -0400
Received: from terminus.zytor.com ([192.83.249.54]:38063 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750778AbWG0UtG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 16:49:06 -0400
Message-ID: <44C92630.403@zytor.com>
Date: Thu, 27 Jul 2006 13:46:40 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: lockdep: results on ARM
References: <20060727142425.GA5178@flint.arm.linux.org.uk> <1154010723.3039.59.camel@laptopd505.fenrus.org>
In-Reply-To: <1154010723.3039.59.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Thu, 2006-07-27 at 15:24 +0100, Russell King wrote:
>> +#ifdef __ARCH_WANT_INTERRUPTS_ON_CTXSW
>> +	p->hardirqs_enabled = 1;
>> +#else
>>  	p->hardirqs_enabled = 0;
>> +#endif
> 
> if __ARCH_WANT_INTERRUPTS_ON_CTXSW is set to 1 for arm you can turn this
> into
> 
> p->hardirqs_enabled = __ARCH_WANT_INTERRUPTS_ON_CTXSW + 0;
> 
> and save the ifdef ;)
> 

#ifdef is actually really evil.  It's much cleaner to use #if and make 
sure everything defines either 0 or 1.  Partially because it often makes 
you not have to add an #if at all, but also because it makes it 
immediately obvious if some definition was missed.

	-hpa
