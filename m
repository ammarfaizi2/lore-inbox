Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbUKBRyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbUKBRyM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 12:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbUKBRyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 12:54:12 -0500
Received: from mail3.utc.com ([192.249.46.192]:15786 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S261338AbUKBRxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 12:53:19 -0500
Message-ID: <4187C95F.5030808@cybsft.com>
Date: Tue, 02 Nov 2004 11:52:31 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Thomas Gleixner <tglx@linutronix.de>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Lee Revell <rlrevell@joe-job.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.6.8
References: <1099227269.1459.45.camel@krustophenia.net> <20041031131318.GA23437@elte.hu> <20041031134016.GA24645@elte.hu> <20041031162059.1a3dd9eb@mango.fruits.de> <20041031165913.2d0ad21e@mango.fruits.de> <20041031200621.212ee044@mango.fruits.de> <20041101134235.GA18009@elte.hu> <20041101135358.GA19718@elte.hu> <20041101140630.GA20448@elte.hu> <1099324040.3337.32.camel@thomas> <20041102150634.GA24871@elte.hu>
In-Reply-To: <20041102150634.GA24871@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> 
>>>Thomas, can you confirm that this kernel fixes the irqs-off latencies? 
>>>(the priority loop indeed was done with irqs turned off.)
>>
>>The latencies are still there. I have the feeling it's worse than 0.6.2.
> 
> 
> update to others: Thomas debugged this problem today and found the place
> that kept irqs disabled for a long time: it was update_process_times(). 
> (which i recently touched to break latencies there - but forgot that the
> lock is an irqs-off lock!)
> 
> i've uploaded a fixed kernel (-V0.6.8) to:
> 
>   http://redhat.com/~mingo/realtime-preempt/
> 
> (this kernel also has the module-put-unlock-kernel fix that should solve
> the other warning reported by Thomas and Bill.)
> 
> 	Ingo
> 

This one initially booted fine on my SMP workstation at the office. Ran 
for about 1 hr. 10 mins. then locked with no indications as to why. Then 
failed reboot after hitting the reset switch. The last thing that I saw 
on the console seems to match the following that I found in the log:

Nov  2 11:21:49 swdev14 rc: Starting readahead:  succeeded
Nov  2 11:21:50 swdev14 messagebus: messagebus startup succeeded
Nov  2 11:21:50 swdev14 rhnsd[3245]: Red Hat Network Services Daemon 
starting up
.
Nov  2 11:21:50 swdev14 rhnsd: rhnsd startup succeeded
Nov  2 11:21:51 swdev14 kernel: (rc/2112/CPU#2): new 912 us 
maximum-latency wake
up.
Nov  2 11:21:51 swdev14 kernel: (ksoftirqd/1/6/CPU#1): new 3147 us 
maximum-laten
cy wakeup.
Nov  2 11:21:51 swdev14 kernel: (mingetty/3251/CPU#1): new 3916 us 
maximum-laten
cy wakeup.
Nov  2 11:21:51 swdev14 kernel: (init/3253/CPU#2): new 4321 us 
maximum-latency w
akeup.
Nov  2 11:21:51 swdev14 kernel: (init/1/CPU#0): new 5332 us 
maximum-latency wake
up.
Nov  2 11:21:51 swdev14 kernel: (init/1/CPU#0): new 5819 us 
maximum-latency wake
up.
Nov  2 11:21:51 swdev14 kernel: (hotplug/3259/CPU#2): new 6847 us 
maximum-latenc
y wakeup.
Nov  2 11:21:51 swdev14 kernel: (hotplug/3274/CPU#2): new 7378 us 
maximum-latenc
y wakeup.
Nov  2 11:31:12 swdev14 syslogd 1.4.1: restart.

After the failed reboot a subsequent reboot went fine. This behavior 
seems to be pretty much the same for a while now.

My SMP system at home has been running for for 1 hr. 23 mins. so far. No 
signs of problems.

kr


