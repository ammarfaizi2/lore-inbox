Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317862AbSGKRFo>; Thu, 11 Jul 2002 13:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317863AbSGKRFn>; Thu, 11 Jul 2002 13:05:43 -0400
Received: from [195.63.194.11] ([195.63.194.11]:20486 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317862AbSGKRFm> convert rfc822-to-8bit; Thu, 11 Jul 2002 13:05:42 -0400
Message-ID: <3D2DBB7B.9020600@evision-ventures.com>
Date: Thu, 11 Jul 2002 19:08:11 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: "Grover, Andrew" <andrew.grover@intel.com>, "'CaT'" <cat@zip.com.au>,
       Benjamin LaHaise <bcrl@redhat.com>, Andrew Morton <akpm@zip.com.au>,
       Linux <linux-kernel@vger.kernel.org>
Subject: Re: HZ, preferably as small as possible
References: <59885C5E3098D511AD690002A5072D3C02AB7F94@orsmsx111.jf.intel.com> <3D2CF4FB.5030600@mandrakesoft.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Jeff Garzik napisa³:
> Grover, Andrew wrote:
> 
>> So, a changing tick *can* be done. If Linux does the same thing, seems 
>> like
>> everyone is happy. What are the obstacles to this for Linux? If code is
>> based on the assumption of a constant timer tick, I humbly assert that 
>> the
>> code is broken.
> 
> 
> Unfortunately code in Linux has traditionally compiled in a constant HZ 
> all over the place, and jiffies instead of real time units are at the 
> heart of all Linux timer-related activities.
> 
> I don't see that making 'HZ' a variable is really an option, because 
> many drivers and scheduler-related code will be wildly inaccurate as 
> soon as HZ actually changes values.
> 
> So that leaves us with the option of changing all the code related to 
> waiting to be based on msecs and usecs.  Which I would love to do, but 
> that's a lot of work, both code- and audit-wise.

vmstat.c:

hz = sysconf(_SC_CLK_TCK);	/* get ticks/s from system */

And yes I know the libproc is *evil* in this area.
The rest should be an implementation detail of sysconf().
Changing this value during the runtime of vmstat is interresting story
anyway, but it should be up to the sysadmin to do this kind
of stuff only at runtlevel 1.
sysconf can be indeed imeplemented as a single global
file containing configuration data. But sysctl is another story
of course.



