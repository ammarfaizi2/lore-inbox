Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965595AbWJCIlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965595AbWJCIlW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 04:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965594AbWJCIlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 04:41:22 -0400
Received: from www1.cdi.cz ([194.213.194.49]:20960 "EHLO www1.cdi.cz")
	by vger.kernel.org with ESMTP id S965593AbWJCIlV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 04:41:21 -0400
Message-ID: <452221FF.70405@cdi.cz>
Date: Tue, 03 Oct 2006 10:40:31 +0200
From: Martin Devera <devik@cdi.cz>
User-Agent: Thunderbird 1.5.0.5 (X11/20060729)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: stat of /proc fails after CPU hot-unplug with EOVERFLOW in 2.6.18
References: <451A2E83.5000806@cdi.cz> <20060927011348.36818f83.akpm@osdl.org>
In-Reply-To: <20060927011348.36818f83.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Wed, 27 Sep 2006 09:55:47 +0200
> Martin Devera <devik@cdi.cz> wrote:
> 
>> Hello,
>>
>> I have 2way Opteron machine. I've done this:
>> echo 0 > /sys/devices/system/cpu/cpu1/online
>>
>> and then strace stat /proc:
>>
>> [snip]
>> personality(PER_LINUX)                  = 4194304
>> getpid()                                = 14926
>> brk(0)                                  = 0x804b000
>> brk(0x804b1a0)                          = 0x804b1a0
>> brk(0x804c000)                          = 0x804c000
>> stat("/proc", 0xbf8e7490)               = -1 EOVERFLOW
>>
>> When I do echo 1 > ... to start cpu again then the stat starts
>> to work again ... Weird.

Hello,
I just want to make more info public. It seems that the problem is deeper.
The 2.6.18 kernel crashed the machine 4 times till now. Symptoms are - working
net, ssh was functional but I was not able to run single binary except "cat",
others giving me permission denied of Bus error.
I was doing no experiments with cpu hotplug this time. The machine was up
with 2.6.17.1 for six months and no problems.
Also I found weird errors like tg3 watchdog timeout, sata read errors (on all
sectors) etc. on console. Seems like memory corruption to me. It is worth to
note that the lockup always occured after high load.
We use MSI Far2 dual opteron MoBo.

All related info is at http://luxik.cdi.cz/~devik/files/2618-corrupt/ along
with 2.6.17.1 config (for comparison).
The main problem is that I have no similar server to simulate the problem
off-site. Thus take this report mainly as informative, I hope to replace
the server in a few weeks to investigate it more. For now we are back on
2.6.17.1.

Martin
