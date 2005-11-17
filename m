Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030562AbVKQAEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030562AbVKQAEY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 19:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030566AbVKQAEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 19:04:23 -0500
Received: from numenor.qualcomm.com ([129.46.51.58]:749 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id S1030562AbVKQAEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 19:04:23 -0500
Message-ID: <437BC8D6.4040402@qualcomm.com>
Date: Wed, 16 Nov 2005 16:03:34 -0800
From: Max Krasnyansky <maxk@qualcomm.com>
User-Agent: Thunderbird 1.4.1 (X11/20051006)
MIME-Version: 1.0
To: george@mvista.com
CC: john stultz <johnstul@us.ibm.com>, Greg KH <greg@kroah.com>,
       ganzinger@mvista.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Calibration issues with USB disc present.
References: <43750EFD.3040106@mvista.com>	 <1131746228.2542.11.camel@cog.beaverton.ibm.com>	 <20051112050502.GC27700@kroah.com> <4376130D.1080500@mvista.com>	 <20051112213332.GA16016@kroah.com> <4378DDC5.80103@mvista.com>	 <20051114184940.GA876@kroah.com> <1131998339.4668.16.camel@leatherman> <4379070C.8090709@mvista.com>
In-Reply-To: <4379070C.8090709@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Anzinger wrote:

>>> Oh well, publicly mock the manufacturer for doing horrible things in
>>> their BIOS and then no one will buy the boxes, and we will not have
>>> problems :)
> 
> Long term, maybe, but it will not close the bug report I have in hand...
>>
>>
>> I suspect the right fix is in-between. We should try to push hardware
>> makers away from using SMIs recklessly, but we should also do our best
>> to work around those that don't. The same problems crop up w/
>> virtualization where time-based calibration may be interrupted.
>>
>> George, again, there has been some SMI resistant delay calibration code
>> added recently. You mentioned this problem was seen on 2.4 kernel, so
>> you could verify that the new code in 2.6.14 works and if so, try
>> backporting it.
>>
>> If not we need to see what else we can do about improving delay
>> calibration (its a similar tick-based problem to what I'm addressing
>> with the timeofday rework) or reducing the use of delay by using
>> something else.
>>
> I will look at that code, but we also need to address the same problem 
> in the TSC calibration area.

I think in the short term your best bet is to globally disable SMI at early
boot stage (ie before TSC calibration).
Some people might argue that it's not the most graceful solution because it might
brake some BIOS features but it's a very common trick that is used by RT folks
(for example RTAI has configurable option to enable SMI workaround) because
on some chipset/BIOS combinations SMIs introduce horrible latencies. And you
cannot do much about that other than disabling SMI.
I have not seen any reports of negative side effects of disabling SMI yet. But
if you're worried about that you could re-enable it later when you're done with
TSC calibration and stuff.

Max

