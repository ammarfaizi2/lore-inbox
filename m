Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261449AbUKOCZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbUKOCZJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 21:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbUKOCYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 21:24:21 -0500
Received: from relay01.pair.com ([209.68.5.15]:37902 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S261450AbUKOCWV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 21:22:21 -0500
X-pair-Authenticated: 24.241.238.70
Message-ID: <419812D8.9010609@cybsft.com>
Date: Sun, 14 Nov 2004 20:22:16 -0600
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Florian Schmidt <mista.tapas@gmx.net>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.25-1
References: <20041025104023.GA1960@elte.hu>	<20041027001542.GA29295@elte.hu>	<20041103105840.GA3992@elte.hu>	<20041106155720.GA14950@elte.hu>	<20041108091619.GA9897@elte.hu>	<20041108165718.GA7741@elte.hu>	<20041109160544.GA28242@elte.hu>	<20041111144414.GA8881@elte.hu>	<20041111215122.GA5885@elte.hu>	<20041114135656.7aa3b95b@mango.fruits.de>	<20041114141551.GA17043@elte.hu> <20041115022738.56b9e9b6@mango.fruits.de>
In-Reply-To: <20041115022738.56b9e9b6@mango.fruits.de>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Schmidt wrote:
> On Sun, 14 Nov 2004 15:15:51 +0100
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> 
>>>i just build and booted into 26-3 (w/o debugging stuff) and put a
>>>little load on the system (find /'s plus kernel compile plus
>>>rtc_wakeup -f 8192). Got this on the console:
>>>
>>>`IRQ 8` [14] is being piggy. need_resched=0, cpu=0
>>>
>>>and the machine locked. will build with debugging and try to
>>>reproduce.
>>
>>hm, i tried and couldnt reproduce this, so i'm curious what your
>>debugging build yields.
> 
> 
> not mch sadly. I tried booting into it once more and had to wait quite a
> while (around 30minutes) until the lock. I got this around 10 minutes before
> the lock though:
> 
> Nov 15 00:09:23 mango kernel: bug in rtc_read(): called in state S_IDLE!

Still don't think this has anything to do with the lock. This message is 
usually produced by reading the rtc with a program that is running at a 
higher priority than 'IRQ 8'. Did you chrt the 'IRQ 8' thread? Make sure 
the reader priority is at least 1 less than the handler.

> 
> The system locked up quitly again. no console dump. sys rq kept working (i
> could sync, remount ro and reboot). Does sys rq offer diagnosis which would
> be useful for you?

Possibly 't' for trace?

kr
> 
> flo
> 

