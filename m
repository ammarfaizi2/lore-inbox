Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318757AbSG0Nsx>; Sat, 27 Jul 2002 09:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318756AbSG0Nsx>; Sat, 27 Jul 2002 09:48:53 -0400
Received: from cpe-24-221-212-80.co.sprintbbd.net ([24.221.212.80]:55033 "EHLO
	servidor.linux-ha.org") by vger.kernel.org with ESMTP
	id <S318757AbSG0Nsx>; Sat, 27 Jul 2002 09:48:53 -0400
Message-ID: <3D42A540.7000904@unix.sh>
Date: Sat, 27 Jul 2002 07:50:56 -0600
From: Alan Robertson <alanr@unix.sh>
Organization: IBM Linux Technology Center
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Isabelle, Francois" <Francois.Isabelle@ca.kontron.com>,
       "Linux-Ha (E-mail)" <linux-ha@muc.de>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Handling NMI in a kernel module
References: <5009AD9521A8D41198EE00805F85F18F219A7E@sembo111.teknor.com>	<3D41C544.9090702@unix.sh>	<1027735557.15951.3.camel@irongate.swansea.linux.org.uk> 	<3D4213D4.6020705@unix.sh> <1027773582.17404.2.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Sat, 2002-07-27 at 04:30, Alan Robertson wrote:
> 
>>Alan Cox wrote:
>>
>>>I've been tracking other lists. The current state is very much that we
>>>need the dual notifier. I now have some draft code that allows us to do
>>>this even on hardware that doesn't support it, and where the read()
>>>function gets told when an event is about to occur
>>>
>>I know what had been requested from the telco crowd was the ability to 
>>register a function to get called (in the kernel) when an event was about to 
>>occur.
>>
> 
> They can already do that anyway. Its called add_timer() 8)

Given how vaguely I stated it, I guess that's what I deserve ;-)
However, it's not quite what I had in mind. ;-)

You'd like to see the driver add a timer when someone opens the device, and 
removes and readds it each time they tickle the watchdog timer.  It's this 
interaction which the driver has to provide support for.

Also, you'd like to specify how long before the watchdog timer goes off that 
it "pops".

So, you really want something like register_watchdog_pretimeout() and pass 
it a function and a pretimeout time in ticks or milliseconds, or whatever. 
You'd also need an unregister_watchdog_pretimeout() function of course as 
well...  IIRC, this is what I mentioned on the watchdog timer list.

	-- Alan Robertson
	   alanr@unix.sh

