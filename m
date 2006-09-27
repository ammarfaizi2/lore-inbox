Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbWI0OoS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbWI0OoS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 10:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbWI0OoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 10:44:18 -0400
Received: from www1.cdi.cz ([194.213.194.49]:15508 "EHLO www1.cdi.cz")
	by vger.kernel.org with ESMTP id S932433AbWI0OoR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 10:44:17 -0400
Message-ID: <451A8E38.60300@cdi.cz>
Date: Wed, 27 Sep 2006 16:44:08 +0200
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
>>
> 
> boggle.
> 
> Can you add this patch, see where it's going bad?

Ehh .. I finally learned how to code jprobe (I can't reboot the machine now),
tested, installed and ... guess what ? The overflow bug is gone :-(
It simply works now.
I will reboot it next week and try again.

thanks for a help and sorry for your wasted time,
Martin
