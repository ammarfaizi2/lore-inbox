Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262883AbVGHUW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262883AbVGHUW7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 16:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262879AbVGHUWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 16:22:38 -0400
Received: from relay03.pair.com ([209.68.5.17]:1551 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S262888AbVGHUUi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 16:20:38 -0400
X-pair-Authenticated: 209.68.2.107
Message-ID: <42CEE013.2000306@cybsft.com>
Date: Fri, 08 Jul 2005 15:20:35 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Real-Time Preemption -RT-V0.7.51-17 - Keyboard Problems
References: <42CEC7B0.7000108@cybsft.com> <20050708191326.GA6503@elte.hu>
In-Reply-To: <20050708191326.GA6503@elte.hu>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * K.R. Foley <kr@cybsft.com> wrote:
> 
> 
>>Ingo,
>>
>>I have an issue with keys VERY SPORADICALLY repeating, SOMETIMES, when 
>>running the RT patches. The problem manifests itself as if the key 
>>were stuck but happens far too quickly for that to be the case. I 
>>realize that the statements above are far from scientific, but I can't 
>>seem to narrow it down further. 2.6.12 doesn't seem to have the 
>>problem at all, only when running the RT patches. It SEEMS to have 
>>gotten worse lately. I am attaching my config as well as the output 
>>from lspci.
>>
>>Adjusting the delay in the keyboard repeat seems to help. Any ideas?
> 
> 
> hm. Would be nice to somehow find a condition that triggers it. One 
> possibility is that something else is starving the keyboard handling 
> path. Right now it's handled via workqueues, which live in keventd. Do 
> things improve if you chrt keventd up to prio 99? Also i'd chrt the 
> keyboard IRQ thread up to prio 99 too.

I would like very much to come up with a condition that causes it. 
Unfortunately, the only event that I know of that is associated with 
this typing. :-) There does not seem to be a method to the madness.

As for bumping the priorities, I tried them all, at least the ones 
mentioned above. I also tried the timer just for grins, after changing 
the keyboard repeat delay seemed to help a bit. None of them seemed to 
help, at least not for an extended period of time.

> 
> the other possibility is some IRQ handling bug - those are usually 
> specific to the IRQ controller, so try turning off (or on) the IO-APIC 
> [if the box has an IO-APIC], does that change anything?
> 

You may be on to something here. Booting with noapic SEEMS to help.

> 	Ingo
> 


-- 
    kr
