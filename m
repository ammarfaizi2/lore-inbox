Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbUJ1Qgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbUJ1Qgu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 12:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbUJ1Qgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 12:36:50 -0400
Received: from smtp2.netcabo.pt ([212.113.174.29]:57755 "EHLO
	exch01smtp10.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S261723AbUJ1Qfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 12:35:39 -0400
Message-ID: <43163.195.245.190.94.1098981230.squirrel@195.245.190.94>
In-Reply-To: <20041028093215.GA27694@elte.hu>
References: <5225.195.245.190.94.1098880980.squirrel@195.245.190.94>
    <20041027135309.GA8090@elte.hu>
    <12917.195.245.190.94.1098890763.squirrel@195.245.190.94>
    <20041027205126.GA25091@elte.hu> <20041027211957.GA28571@elte.hu>
    <33083.192.168.1.5.1098919913.squirrel@192.168.1.5>
    <20041028063630.GD9781@elte.hu>
    <20668.195.245.190.93.1098952275.squirrel@195.245.190.93>
    <20041028085656.GA21535@elte.hu>
    <26253.195.245.190.93.1098955051.squirrel@195.245.190.93>
    <20041028093215.GA27694@elte.hu>
Date: Thu, 28 Oct 2004 17:33:50 +0100 (WEST)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       "Bill Huey" <bhuey@lnxw.com>, "Adam Heath" <doogie@debian.org>,
       "Florian Schmidt" <mista.tapas@gmx.net>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>,
       "Karsten Wiese" <annabellesgarden@yahoo.de>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 28 Oct 2004 16:35:37.0923 (UTC) FILETIME=[27DC6930:01C4BD0C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>
> * Rui Nuno Capela wrote:
>
>> OK. That was it. After switching off CONFIG_RWSEM_DEADLOCK_DETECT on
>> RT-V0.4.3, I can say that it's now on par to RT-U3.
>
> great!
>
>> Later today, I will conduct some extendeded testing, where I'll able
>> to compare the jackd performance between vanilla, RT-U3 and RT-V0.4.3,
>> on my UP laptop. All kernel configurations will be stripped off from
>> all the debug options.
>>
>> I will take note of xrun rate, jackd scheduling delay histogram, and
>> cpu usage. Context switch rate will be also acquainted.
>>
>> Anything else?
>
> yeah, that's good enough.


OK. Here are my early consolidated results. Feel free to comment.

                                    2.6.9     RT-U3   RT-V0.4.3
                                  --------- --------- ---------
  XRUN Rate . . . . . . . . . . .     424         8         4    /hour
  Delay Rate (>spare time)  . . .     496         0         0    /hour
  Delay Rate (>1000 usecs)  . . .     940         8         4    /hour
  Maximum Delay . . . . . . . . .    6904       921       721    usecs
  Maximum Process Cycle . . . . .    1449      1469      1590    usecs
  Average DSP CPU Load  . . . . .      38        39        40    %
  Average Context-Switch Rate . .    7480      8929      9726    /sec

Note: all tests were carried out running jackd -v -dalsa -dhw:0 -r44100
-p128 -n2 -S -P, loaded with 9 (nine) fluidsynth instances, on a
P4@2.533Ghz laptop, against the onboard sound device (snd-ali5451).

On the RT kernels only, the following optimizations were issued:

   chrt --pid --fifo 90 2                (pidof "ksoftirqd/0" = 2)
   chrt --pid --fifo 60 `pidof "IRQ 5"`  (snd-ali5451)

Take care.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org


