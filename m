Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262051AbUKVKt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbUKVKt5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 05:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbUKVKln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 05:41:43 -0500
Received: from smtp1.netcabo.pt ([212.113.174.28]:8499 "EHLO
	exch01smtp11.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S262027AbUKVKim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 05:38:42 -0500
Message-ID: <56781.195.245.190.93.1101119801.squirrel@195.245.190.93>
In-Reply-To: <20041122094602.GA6817@elte.hu>
References: <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu>
    <20041116125402.GA9258@elte.hu> <20041116130946.GA11053@elte.hu>
    <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu>
    <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu>
    <20041122005411.GA19363@elte.hu>
    <20041122020741.5d69f8bf@mango.fruits.de>
    <20041122094602.GA6817@elte.hu>
Date: Mon, 22 Nov 2004 10:36:41 -0000 (WET)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.30-2
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: "Florian Schmidt" <mista.tapas@gmx.net>, linux-kernel@vger.kernel.org,
       "Lee Revell" <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, "Bill Huey" <bhuey@lnxw.com>,
       "Adam Heath" <doogie@debian.org>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>,
       "Karsten Wiese" <annabellesgarden@yahoo.de>,
       "Gunther Persoons" <gunther_persoons@spymac.com>, emann@mrv.com,
       "Shane Shrybman" <shrybman@aei.ca>, "Amit Shah" <amit.shah@codito.com>,
       "Esben Nielsen" <simlo@phys.au.dk>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 22 Nov 2004 10:38:40.0905 (UTC) FILETIME=[6EA68F90:01C4D07F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>
> * Florian Schmidt wrote:
>
>>
>> > i have released the -V0.7.30-2 Real-Time Preemption patch, which can
>> > be downloaded from the usual place:
>>
>> > the biggest change in this release are fixes for priority-inheritance
>> > bugs uncovered by Esben Nielsen pi_test suite. These bugs could
>> > explain some of the jackd-under-load latencies reported.
>>
>> It seems these large load related xruns are gone :) At least i wasn't
>> able to trigger any during my uptime of 52 min. Will report if i ever
>> see any of those again.
>
> great. I now suspect that some of the xrun problems Rui was observing on
> -RT kernel could be (positively) affected by these fixes too.
>

Just made some test-runs with RT-V0.7.30-2, with my jackd-R + 8*fluidsynth
benchmark on my laptop (P4/UP), and the results don't seem to be eligible
to the hall of fame, at least when compared with RT-0.7.7 as the ones I
last posted here a few weeks ago.

I hate to say this, but the XRUN rate has increased since RT-0.7.7, and
the maximum scheduling delay reported by jackd has also degraded to 1000
usecs (was around 600 usecs).

Please note that this is not unique to latest RT-V0.7.30-2, but also
applies to each one of the previous iterations I've been testing, only not
reported until now. Again, all test conditions were kept the same
(hardware, jackd, alsa), only the kernel has changed (obviously).


OTOH, there's another thing: I don't seem to be able to build an initrd
image under the latest RT kernels. Something related to the loopback
device. When trying to run mkinitrd it stalls, somewhere under this
process:

  mount -t ext2 /root/tmp/initrd.img /root/tmp/initrd.mnt -o loop

This happens on my laptop (P4/UP, Mandrake 10.1c) but not on my desktop
(P4/SMT, SUSE 9.2pro). Speaking of which, the lockups experienced while
unloading the ALSA modules seems to be over, at least as far as I could
try with RT-V0.7.29-4 (probably not enough yet).

Bye now.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

