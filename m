Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932586AbVLBAlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932586AbVLBAlv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 19:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932587AbVLBAlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 19:41:51 -0500
Received: from smtpout.mac.com ([17.250.248.97]:4338 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932586AbVLBAlu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 19:41:50 -0500
In-Reply-To: <Pine.LNX.4.61.0512020120180.1609@scrub.home>
References: <1133395019.32542.443.camel@tglx.tec.linutronix.de> <Pine.LNX.4.61.0512010118200.1609@scrub.home> <23CA09D3-4C11-4A4B-A5C6-3C38FA9C203D@mac.com> <Pine.LNX.4.61.0512011352590.1609@scrub.home> <2c0942db0512010822x1ae20622obf224ce9728e83f8@mail.gmail.com> <20051201165144.GC31551@flint.arm.linux.org.uk> <Pine.LNX.4.61.0512011828150.1609@scrub.home> <1133464097.7130.15.camel@localhost.localdomain> <Pine.LNX.4.61.0512012048140.1609@scrub.home> <Pine.LNX.4.58.0512011619590.32095@gandalf.stny.rr.com> <Pine.LNX.4.61.0512020120180.1609@scrub.home>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <91D50CB6-A9B0-4501-AAD2-7D80948E7367@mac.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, johnstul@us.ibm.com,
       george@mvista.com, mingo@elte.hu, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       ray-gmail@madrabbit.org, Russell King <rmk+lkml@arm.linux.org.uk>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [patch 00/43] ktimer reworked
Date: Thu, 1 Dec 2005 19:41:41 -0500
To: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 01, 2005, at 19:29, Roman Zippel wrote:
> Hi,
>
>> As for portablility, I believe John Stultz has some nice plugins  
>> coming to what timer source you want to use, so if there's a  
>> better way to get a time, these should make things easy to add.
>
> These plugins can do no magic, if the hardware timer is slow, the  
> whole thing gets slow.

The point is that you could switch both the timer and timeout  
implementations to jiffies if you wanted to, at the expense of the  
accuracy that a lot of people care about.

>>> - resolution: how precise must the timer be? jiffies can't  
>>> represent time values less than 1ms, but if time is e.g. measured  
>>> in 10th of a second, jiffies may be enough.
>>
>> And they would be if that is all you need. But coming from an  
>> embedded point of view, that is not nearly enough.  I really see  
>> HighRes making it into the kernel soon, and any new code in this  
>> area really needs to take that into account.
>
> I'm not against HR timer, I have a problem with using them as timer  
> for everything.

This is _exactly_ why there is the timer/timeout distinction.  Some  
things don't care, and as a result use a timer wheel exactly like  
they always have.  For the things that do, however, the new timer API  
provides it using the fastest hardware interface available.

Cheers,
Kyle Moffett

--
I didn't say it would work as a defense, just that they can spin that  
out for years in court if it came to it.
   -- Rob Landley



