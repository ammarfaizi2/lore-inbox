Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbUCPXrR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 18:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261854AbUCPXrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 18:47:17 -0500
Received: from alt.aurema.com ([203.217.18.57]:63902 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S261822AbUCPXrK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 18:47:10 -0500
Message-ID: <405791A3.1080904@aurema.com>
Date: Wed, 17 Mar 2004 10:45:39 +1100
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bernd Petrovitsch <bernd@firmix.at>
CC: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: finding out the value of HZ from userspace
References: <1zkOe-Uc-17@gated-at.bofh.it> <1zl7M-1eJ-43@gated-at.bofh.it>	<1zn9p-3mW-5@gated-at.bofh.it> <1znj5-3wM-15@gated-at.bofh.it>	<1AaWr-655-7@gated-at.bofh.it> <m3fzc9o7bc.fsf@averell.firstfloor.org>	<40569655.2030802@aurema.com> <1079428604.32739.26.camel@tara.firmix.at>
In-Reply-To: <1079428604.32739.26.camel@tara.firmix.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Petrovitsch wrote:
> On Die, 2004-03-16 at 06:53, Peter Williams wrote:
> 
>>Andi Kleen wrote:
>>
>>>Peter Williams <peterw@aurema.com> writes:
> 
> [...]
> 
>>>Already exists for a long time - AT_CLKTCK. glibc has a nice wrapper
>>>for it too (sysconf)
>>
>>So it does and POSIX.1 (_SC_CLK_TCK) compliant as well.  Unfortunately, 
>>the presence of this functionality makes it VERY difficult to understand 
>>why ticks are being converted from HZ==1000 values to HZ=100 values when 
>>they are being exported to user space especially as this conversion 
>>throws away precision.  Can anyone enlighten me?
> 
> 
> 1) Because Linux had long time HZ=100 hardcoded (except on Alphas) and
>    lots of applications probably use that value today (as HZ in their
>    source and not sysconf(...))  - especially since 2.4 (at least most
>    of them) has HZ=100 except for 64bit CPUs).

That is not a valid reason.  The programs should be fixed.

> 2) There are patches which dynamically change the CPU speed. And it
>    probably (IMHO) makes sense to change HZ dynamically too in that
>    situations. And a over-time changing HZ value is useless in
>    user-space.

I can't see why.  Ticks are used internally for process accounting (e.g. 
utime, stime, cutime and cstime) and if HZ was changing dynamically 
you'd have to visit every task and modify these values to be consistent 
with the changed value of HZ.  Even if HZ was allowed to change 
dynamically the values reported to user space should be in units 
appropriate to the MAXIMUM possible value of HZ so that precision is not 
lost.

Peter
-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com

