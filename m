Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261473AbULAWHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbULAWHt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 17:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbULAWHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 17:07:39 -0500
Received: from smtp3.netcabo.pt ([212.113.174.30]:48835 "EHLO
	exch01smtp09.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S261469AbULAWHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 17:07:15 -0500
Message-ID: <32792.192.168.1.8.1101938686.squirrel@192.168.1.8>
In-Reply-To: <20041201215837.GA24809@elte.hu>
References: <17532.195.245.190.94.1101829198.squirrel@195.245.190.94>
    <20041201103251.GA18838@elte.hu>
    <32831.192.168.1.5.1101905229.squirrel@192.168.1.5>
    <20041201154046.GA15244@elte.hu> <20041201160632.GA3018@elte.hu>
    <20041201162034.GA8098@elte.hu>
    <33059.192.168.1.5.1101927565.squirrel@192.168.1.5>
    <20041201212925.GA23410@elte.hu> <20041201213023.GA23470@elte.hu>
    <32788.192.168.1.8.1101938057.squirrel@192.168.1.8>
    <20041201215837.GA24809@elte.hu>
Date: Wed, 1 Dec 2004 22:04:46 -0000 (WET)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-19
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       "Bill Huey" <bhuey@lnxw.com>, "Adam Heath" <doogie@debian.org>,
       "Florian Schmidt" <mista.tapas@gmx.net>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>,
       "Karsten Wiese" <annabellesgarden@yahoo.de>,
       "Gunther Persoons" <gunther_persoons@spymac.com>, emann@mrv.com,
       "Shane Shrybman" <shrybman@aei.ca>, "Amit Shah" <amit.shah@codito.com>,
       "Esben Nielsen" <simlo@phys.au.dk>, "Andrew Morton" <akpm@osdl.org>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 01 Dec 2004 22:07:09.0888 (UTC) FILETIME=[1A70E400:01C4D7F2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>
> * Rui Nuno Capela <rncbc@rncbc.org> wrote:
>
>> >> up. (can the soundcard period size / buffering be reduced further, to
>> >> make it more sensitive to scheduling latencies?)
>> >
>>
>> OK.
>>
>> A couple of hours later, as I thrown in some more jack clients into
>> the picture, the XRUNs started to appear, but very discrete still.
>
> just curious, what type of CPU load did this create - over 50%?
>

At this very moment? About 75%. Here's a top snapshot:

top - 22:03:48 up  3:36,  4 users,  load average: 1.91, 2.73, 2.16
Tasks:  86 total,   1 running,  85 sleeping,   0 stopped,   0 zombie
Cpu(s): 33.9% us, 39.7% sy,  0.0% ni, 26.5% id,  0.0% wa,  0.0% hi,  0.0% si
Mem:    500900k total,   411308k used,    89592k free,    12680k buffers
Swap:   506008k total,        0k used,   506008k free,   209300k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
18300 rncbc     16   0 89128  87m  14m S 30.8 17.8  13:02.31 qsynth
18288 rncbc     20   0 28148  27m 2316 S 10.8  5.6   4:29.60 jackd
 3078 root     -71  -5     0    0    0 S  8.9  0.0  16:33.69 IRQ 5
16701 rncbc     15   0 26988  26m  14m S  7.3  5.4   4:05.01 qjackctl
 3587 root      15   0 24288  13m 2696 S  3.8  2.8   9:27.28 X
 4291 rncbc     15   0 28240  15m  12m S  1.9  3.1   1:44.69 kdeinit
 4356 rncbc     15   0 21312 7832 5952 S  1.6  1.6   2:45.78 gkrellm
 4346 rncbc     15   0 23744  12m 9.9m S  0.6  2.5   0:19.92 krandrtray
 4347 rncbc     15   0 24260  12m   9m S  0.6  2.5   0:19.62 kdeinit
 4355 rncbc     15   0 23684  11m 9504 S  0.6  2.3   0:16.15 kdeinit
 4361 rncbc     15   0 24948  13m  11m S  0.6  2.8   0:38.53 kscd
 4453 rncbc     16   0 27168  15m  12m S  0.6  3.1   0:28.73 kdeinit
24504 rncbc     17   0  2064  996  780 R  0.6  0.2   0:00.25 top
 4323 rncbc     15   0 29280  13m  11m S  0.3  2.8   0:14.93 kdeinit
 4330 rncbc     16   0 32296  19m  15m S  0.3  3.9   0:30.49 kdeinit
 4333 rncbc     15   0 26880  14m  12m S  0.3  3.1   0:25.56 kdeinit
 4337 rncbc     15   0 24680  13m  10m S  0.3  2.7   0:25.52 kamix
 4345 rncbc     15   0 26500  14m  12m S  0.3  2.9   0:26.77 korgac

Bye.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

