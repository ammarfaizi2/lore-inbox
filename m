Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbWI2CJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbWI2CJn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 22:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWI2CJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 22:09:43 -0400
Received: from mxsf32.cluster1.charter.net ([209.225.28.156]:60878 "EHLO
	mxsf32.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1751296AbWI2CJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 22:09:42 -0400
X-IronPort-AV: i="4.09,232,1157342400"; 
   d="scan'208"; a="650402844:sNHT155157452"
Message-ID: <451C8070.7020801@cybsft.com>
Date: Thu, 28 Sep 2006 21:09:52 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: Ingo Molnar <mingo@elte.hu>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.18-rt1
References: <20060920141907.GA30765@elte.hu> <45118EEC.2080700@cybsft.com>	 <20060920194958.GA24691@elte.hu> <4511A57D.9070500@cybsft.com>	 <1158784863.5724.1027.camel@localhost.localdomain>	 <4511A98A.4080908@cybsft.com>	 <1158866166.12028.9.camel@localhost.localdomain>	 <20060922115854.GA12684@elte.hu>  <1159404123.5532.3.camel@localhost> <1159483731.25415.12.camel@localhost>
In-Reply-To: <1159483731.25415.12.camel@localhost>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> On Wed, 2006-09-27 at 17:42 -0700, john stultz wrote:
>> On Fri, 2006-09-22 at 13:58 +0200, Ingo Molnar wrote: 
>>> * john stultz <johnstul@us.ibm.com> wrote:
>>>
>>>> I'm seeing a similar issue. Although the log is a bit futzed. Maybe 
>>>> its the sd_mod?
>>>>
>>>>  at virtual address 75010000le kernel paging requestproc filesystem
>>> would be nice to figure out why it crashes - unfortunately i cannot 
>>> trigger it. Could it be some build tool incompatibility perhaps? Some 
>>> sizing issue (some module struct gets too large)?
>> Been looking a bit deeper into this again:
> [snip]
>> c03879e8 r __ksymtab_find_next_bit
>> c03879f0 r __ksymtab_find_next_zero_bit
>> c03879f8 R __write_lock_failed
>> c0387a18 R __read_lock_failed
>> c0387a2c r __ksymtab___delay
>> c0387a34 r __ksymtab___const_udelay
>> c0387a3c r __ksymtab___udelay
>> c0387a44 r __ksymtab___ndelay
>>
>> That __read/__write_lock_failed bit looks wrong.
> 
> 
> So it seems gcc 3.4.4 misplaces the __write_lock_failed function into
> the ksymtab. It doesn't happen w/ 4.0.3. 
> 
> Anyway, this patch explicitly defines the section and fixes the issue
> for me. Would the other reporters of this issue give it a whirl as well?
> 
> thanks
> -john
> 

John,

This fixes my problem on my fc3 box here at home. I will check my other
development boxes at work tomorrow. Nice catch and thanks for effort.


-- 
	kr
