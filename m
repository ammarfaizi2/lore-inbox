Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263594AbTKDCdI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 21:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263596AbTKDCdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 21:33:08 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:49570 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263594AbTKDCdD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 21:33:03 -0500
Message-ID: <3FA70FDA.2000502@cyberone.com.au>
Date: Tue, 04 Nov 2003 13:32:58 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Erwin Telser <erwin.telser@pop.agri.ch>
CC: linux-kernel@vger.kernel.org
Subject: Re: Responsiveness of 2.6.0-Test9
References: <200311022345.08192.erwin.telser@pop.agri.ch> <3FA5DD01.1070109@cyberone.com.au> <200311032353.16570.erwin.telser@pop.agri.ch>
In-Reply-To: <200311032353.16570.erwin.telser@pop.agri.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Erwin Telser wrote:

>>Erwin Telser wrote:
>>
>>>Are there things to observe when switching from 2.4 to 2.6, if I want the
>>>same responsiveness? I'm asking because I' ve made the following
>>>observation. (I always had the feeling, 2.4 seems to faster, but this is
>>>the first time it' s very obvious)
>>>
>>>I' ve connected two monitors on a Matrox G550. One runs with DRI the other
>>>one doesn't (not possible with the current driver). The Monitor with DRI
>>>I'm using as a TV Set, watching movies with xawtv. (With a bttv 878 tuner
>>>card).
>>>
>>>Now with the 2.4.22 kernel (preemptible patch aplied) I can play the
>>>little game kbounce on the other monitor, without to notice any slowdown,
>>>no matter, whether xawtv is running or not.
>>>
>>>But with the 2.6 Kernel (compiled with preemptible option) the bouncing
>>>balls slow down considerably, as soon as I move the mouse.
>>>
>>>I know the whole thing is a little foolish. But anyway, are there some
>>>tricks to get the same responsiveness?
>>>
>>Hi,
>>Your report is not foolish at all ;)
>>Please make sure your X process is at default static priority, 0.
>>Report back if you are still having problems. What sort of processor
>>do you have? Is your 2.6 video driver running with the same sort of
>>acceleration as your 2.4 one (do you get the same frame rate in glxgears)?
>>
>
>I installed X from scratch and didn't edit any start script. so I assume, that 
>it runs with priority 0. The processor is an Intel P4 2000MHz in an ASUS 
>P4B266 Board. If I compare the frames per second with glxgears there is a 
>slight advantage for 2.4
>

renice 0 `pidof X`

>
>2.4: 
>with DRI 358 - 364
>without DRI 181 - 198
>
>2.6
>with DRI 350 - 362
>without DRI 180 - 187
>
>An even better way to show the differenze between 2.4 and 2.6 is to change the 
>size of the xawtv window. If I do that, the slowdown is quite significant. 
>But it happens only with xawtv. If I do the same with konqueror or MPlayer, 
>nothing happens. A very strange thing are the values I get from ksysguard
>
>Kernel 2.4, glxgears
>user load: 3% - 4%
>system load: 95%
>IRQ per second: ~100
>
>Kernel 2.6, glxgears
>user load: 15%
>system load: 85%
>IRQ per second: ~1100 
>
>Kernel 2.4, xawtv
>user load: 2%
>system load: 0%
>IRQ per second: ~100
>
>Kernel 2.6, xawtv
>user load: 9%
>system load: 0%
>IRQ per second: ~1060 
>
>Kernel 2.4, MPlayer
>user load: 35%
>system load: 2%
>IRQ per second: ~1170
>
>Kernel 2.6, MPlayer
>user load: 42%
>system load: 2%
>IRQ per second: ~2130
>
>Something is causing a high IRQ load with kernel 2.6. Probably an APIC 
>problem?
>

It is the timer interrupt. Now happens 1000 per second instead of 100.
This might just be the reason why you are seeing a different balance, the
collection of cpu statistics is more precise.


