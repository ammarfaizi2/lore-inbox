Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266703AbUIOBQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266703AbUIOBQI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 21:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266798AbUIOBQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 21:16:07 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:36777 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266703AbUIOBP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 21:15:58 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R5
From: Lee Revell <rlrevell@joe-job.com>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: Ingo Molnar <mingo@elte.hu>, Florian Schmidt <mista.tapas@gmx.net>,
       "K.R. Foley" <kr@cybsft.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       felipe_alfaro@linuxmail.org
In-Reply-To: <37312.195.245.190.93.1094728166.squirrel@195.245.190.93>
References: <20040903120957.00665413@mango.fruits.de>
	 <20040904195141.GA6208@elte.hu> <20040905140249.GA23502@elte.hu>
	 <1094597710.16954.207.camel@krustophenia.net>
	 <1094598822.16954.219.camel@krustophenia.net>
	 <32930.192.168.1.5.1094601493.squirrel@192.168.1.5>
	 <20040908082358.GB680@elte.hu> <20040908083158.GA1611@elte.hu>
	 <37312.195.245.190.93.1094728166.squirrel@195.245.190.93>
Content-Type: text/plain
Message-Id: <1095210962.2406.79.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 14 Sep 2004 21:16:02 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-09 at 07:09, Rui Nuno Capela wrote:
> 4) Then I wandered: the problem must be in one of plugged USB devices. And
> right I was: my WACOM GRAPHIRE2 USB tablet was the culprit. Strange
> enough, the hid and wacom modules weren't compiled in yet. Some more
> iterations later, and it didn't matter if those modules are in or not: if
> the tablet is plugged in at boot time the VP+SMP combination freezes.
> 
> 5) Incidentally I found that I must unplug the tablet at boot time of
> freshly built VP+SMP kernel. Then I found that installing the linuxwacom
> project [http://linuxwacom.sourceforge.net] drivers, which adds some
> changes to mousedev (built-in), evdev and wacom kernel modules, I end up
> with a kernel that I can boot and run later already with the tablet
> plugged in.
> 
> 6) Now that had found the major showstopper, I decided to go for audio:
> among some other thingies, switched ALSA sound modules on, included the
> realtime-lsm patch and built what comes to be my latest VP+SMP working
> kernel. And it boots OK. Great.
> 
> 7) Now let's start jackd... start some client applications, hear some
> sound, and... horror! The system hangs completetly. The time it takes to
> hang is by no means deterministic. Soon or later it hangs. Hard-reboot is
> always the only way around, no magic-sysrq :( Gasp, I've seen this before.
> 
> 8) Indeed, only by disabling both softirq and hardirq preeemption I get an
> usable VP+SMP kernel. But that's no surprise either, it has been always
> like that until Q3, which was the latest VP+SMP combination that didn't
> suffer with the Wacom tablet presence at boot/init time. I only hoped the
> (soft|hard)irq trouble would be solved by R9 time.

Rui, did you ever get this working?  Other testers are not reporting
problems, it would be good to know if there are still bugs lurking.

Have you tried booting with hard and softirq preemption disabled and
enabling them one at a time?

Lee



