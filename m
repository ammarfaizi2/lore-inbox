Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992550AbWJTRvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992550AbWJTRvK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 13:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbWJTRvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 13:51:10 -0400
Received: from smtp101.plus.mail.re2.yahoo.com ([206.190.53.26]:21082 "HELO
	smtp101.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S964826AbWJTRvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 13:51:08 -0400
Message-ID: <45390C85.3070604@tungstengraphics.com>
Date: Fri, 20 Oct 2006 18:51:01 +0100
From: Keith Whitwell <keith@tungstengraphics.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Ryan Richter <ryan@tau.solarneutrino.net>
CC: Keith Packard <keithp@keithp.com>, dri-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Intel 965G: i915_dispatch_cmdbuffer failed (2.6.19-rc2)
References: <20061013194516.GB19283@tau.solarneutrino.net>	<1160849723.3943.41.camel@neko.keithp.com>	<20061017174020.GA24789@tau.solarneutrino.net>	<1161124062.25439.8.camel@neko.keithp.com>	<4535CFB1.2010403@tungstengraphics.com>	<20061019173108.GA28700@tau.solarneutrino.net>	<4538B670.2030105@tungstengraphics.com> <20061020164008.GA29810@tau.solarneutrino.net>
In-Reply-To: <20061020164008.GA29810@tau.solarneutrino.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Richter wrote:
> On Fri, Oct 20, 2006 at 12:43:44PM +0100, Keith Whitwell wrote:
>> Ryan Richter wrote:
>>> On Wed, Oct 18, 2006 at 07:54:41AM +0100, Keith Whitwell wrote:
>>>> This is all a little confusing as the driver doesn't really use that 
>>>> path in normal operation except for a single command - MI_FLUSH, which 
>>>> is shared between the architectures.  In normal operation the hardware 
>>>> does the validation for us for the bulk of the command stream.  If there 
>>>> were missing functionality in that ioctl, it would be failing 
>>>> everywhere, not just in this one case.
>>>>
>>>> I guess the questions I'd have are
>>>> 	- did the driver work before the kernel upgrade?
>>>> 	- what path in userspace is seeing you end up in this ioctl?
>>>> 	- and like Keith, what commands are you seeing?
>>>>
>>>> The final question is interesting not because we want to extend the 
>>>> ioctl to cover those, but because it will give a clue how you ended up 
>>>> there in the first place.
>>> Here's a list of all the failing commands I've seen so far:
>>>
>>> 3a440003
>>> d70003
>>> 2d010003
>>> e5b90003
>>> 2e730003
>>> 8d8c0003
>>> c10003
>>> d90003
>>> be0003
>>> 1e3f0003
>> Ryan,
>>
>> Those don't look like any commands I can recognize.  I'm still confused 
>> how you got onto this ioctl in the first place - it seems like something 
>> pretty fundamental is going wrong somewhere.  What would be useful to me 
>> is if you can use GDB on your application and get a stacktrace for how 
>> you end up in this ioctl in the cases where it is failing?
>>
>> Additionally, if you're comfortable doing this, it would be helpful to 
>> see all the arguments that userspace thinks its sending to the ioctl, 
>> compared to what the kernel ends up thinking it has to validate.  There 
>> shouldn't ever be more than two dwords being validated at a time, and 
>> they should look more or less exactly like {0x02000003, 0}, and be 
>> emitted from bmSetFence().
>>
>> All of your other wierd problems, like the assert failures, etc, make me 
>> wonder if there just hasn't been some sort of build problem that can 
>> only be resolved by clearing it out and restarting.
>>
>> It wouldn't hurt to just nuke your current Mesa and libdrm builds and 
>> start from scratch - you'll probably have to do that to get debug 
>> symbols for gdb anyway.
> 
> I had heard something previously about i965_dri.so maybe getting
> miscompiled, but I hadn't followed up on it until now.  I rebuilt it
> with an older gcc, and now it's all working great!  Sorry for the wild
> goose chase.

Out of interest, can you try again with the original GCC and see if the 
problem comes back?  Which versions of GCC are you using?

Keith
