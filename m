Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932690AbVLBBJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932690AbVLBBJZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 20:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932692AbVLBBJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 20:09:25 -0500
Received: from smtpout.mac.com ([17.250.248.70]:18684 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932690AbVLBBJY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 20:09:24 -0500
In-Reply-To: <Pine.LNX.4.61.0512020146310.1609@scrub.home>
References: <1133395019.32542.443.camel@tglx.tec.linutronix.de> <Pine.LNX.4.61.0512010118200.1609@scrub.home> <23CA09D3-4C11-4A4B-A5C6-3C38FA9C203D@mac.com> <Pine.LNX.4.61.0512011352590.1609@scrub.home> <2c0942db0512010822x1ae20622obf224ce9728e83f8@mail.gmail.com> <20051201165144.GC31551@flint.arm.linux.org.uk> <Pine.LNX.4.61.0512011828150.1609@scrub.home> <1133464097.7130.15.camel@localhost.localdomain> <Pine.LNX.4.61.0512012048140.1609@scrub.home> <Pine.LNX.4.58.0512011619590.32095@gandalf.stny.rr.com> <Pine.LNX.4.61.0512020120180.1609@scrub.home> <91D50CB6-A9B0-4501-AAD2-7D80948E7367@mac.com> <Pine.LNX.4.61.0512020146310.1609@scrub.home>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <53ECF38B-8E27-4289-9DEA-06CA8374D97D@mac.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, johnstul@us.ibm.com,
       george@mvista.com, mingo@elte.hu, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       ray-gmail@madrabbit.org, Russell King <rmk+lkml@arm.linux.org.uk>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [patch 00/43] ktimer reworked
Date: Thu, 1 Dec 2005 20:09:19 -0500
To: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 01, 2005, at 20:01, Roman Zippel wrote:
> Hi,
>
> On Thu, 1 Dec 2005, Kyle Moffett wrote:
>>> I'm not against HR timer, I have a problem with using them as  
>>> timer for
>>> everything.
>>
>> This is _exactly_ why there is the timer/timeout distinction.   
>> Some things don't care, and as a result use a timer wheel exactly  
>> like they always have. For the things that do, however, the new  
>> timer API provides it using the fastest hardware interface available.
>
> This is about kernel programming - people should care.

My _point_ is that some code doesn't care about accuracy.  If a  
networking timeout occurs a half-second later than it should, nothing  
bad happens.  We have configurable SCSI drive timeouts, precisely  
because it doesn't really matter all that much if we deliver it now  
or give the drive a couple seconds extra time to try to respond  
before signalling a reset.  And I agree with you that people should  
care, this distinction is important.

> We have enough crap as it is. timer wheel is fast as well, but  
> everything has its limits, putting this focus completely to  
> delivery is nonsense. It can't be that difficult to put together a  
> decent list of criteria, where to use which timer.

A ktimer should be used where the common case is the timer being  
added and expiring.  A ktimeout should be used where the common case  
is the timer being added and removed before it expires.  Simple enough?

Cheers,
Kyle Moffett

--
I lost interest in "blade servers" when I found they didn't throw  
knives at people who weren't supposed to be in your machine room.
   -- Anthony de Boer


