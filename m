Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbVGLH66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVGLH66 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 03:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbVGLH64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 03:58:56 -0400
Received: from mf00.sitadelle.com ([212.94.174.67]:56448 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S261256AbVGLH6v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 03:58:51 -0400
Message-ID: <42D3782F.7070104@lifl.fr>
Date: Tue, 12 Jul 2005 09:58:39 +0200
From: Eric Piel <Eric.Piel@lifl.fr>
Organization: LIFL
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: en, fr, ja, es
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, Ken Moffat <ken@kenmoffat.uklinux.net>
Subject: Re: ondemand cpufreq ineffective in 2.6.12 ?
References: <Pine.LNX.4.58.0507111702410.2222@ppg_penguin.kenmoffat.uklinux.net> <Pine.LNX.4.58.0507112044001.3450@ppg_penguin.kenmoffat.uklinux.net> <200507120755.03110.kernel@kolivas.org>
In-Reply-To: <200507120755.03110.kernel@kolivas.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

11.07.2005 23:55, Con Kolivas wrote/a écrit:
> On Tue, 12 Jul 2005 05:45, Ken Moffat wrote:
> 
>>On Mon, 11 Jul 2005, Ken Moffat wrote:
>>
>>>Hi,
>>>
>>> I've been using the ondemand governor on athlon64 winchesters for a few
>>>weeks.  I've just noticed that in 2.6.12 the frequency is not
>>>increasing under load, it remains at the lowest frequency.  This seems
>>>to be down to something in 2.6.12-rc6, but I've seen at least one report
>>>since then that ondemand works fine.  Anybody else seeing this problem ?
>>
>> And just for the record, it's still not working in 2.6.13-rc2.  Oh
>>well, back to 2.6.11 for this box.
> 
> 
> I noticed a change in ondemand on pentiumM, where it would not ramp up if the 
> task using cpu was +niced. It does ramp up if the task is not niced. This 
> seems to have been considered all round better but at my end it is not - if 
> it takes the same number of cycles to complete a task it does not save any 
> battery running it at 600Mhz vs 1700Mhz, it just takes longer. Yes I know 
> during the initial ramp up the 1700Mhz one will waste more battery, but that 
> is miniscule compared to something that burns cpu constantly for 10 mins. Now 
> I'm forced to run my background tasks at nice 0 and not get the benefit of 
> nicing the tasks, _or_ I have to go diddling with settings in /sys to disable 
> this feature or temporarily move to the performance governor.
echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/ignore_nice
Put it once for all in your initscript :-)

> Although I 
> complained lightly initially when this change was suggested, I didn't realise 
> it was actually going to become standard. 
I like it because it avoids that any background task which is ran makes 
the fans turning like hell. It's also very advantageous with tasks like 
screensavers or a la seti@home (but few people have this on their laptop).

> 
> To me the ondemand governor was supposed to not delay you at all, but cause as 
> much battery saving as possible without noticeable slowdown...
> 
> Oh well you can't please everyone all the time.
It's a tradeoff :-)

Ken, does this solve your problems (but that seems strange that all your 
tasks are nice'd) ?

Eric
