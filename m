Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264189AbTKSXLc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 18:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264190AbTKSXLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 18:11:32 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:44942 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S264189AbTKSXL0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 18:11:26 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: john stultz <johnstul@us.ibm.com>
Date: Thu, 20 Nov 2003 00:10:50 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Losing too many ticks! TSC cannot be used as time sourc
Cc: lkml <linux-kernel@vger.kernel.org>
X-mailer: Pegasus Mail v3.50
Message-ID: <3A9BE1FAD@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Nov 03 at 14:37, john stultz wrote:
> On Wed, 2003-11-19 at 03:21, Petr Vandrovec wrote:
> > Hi,
> >   today morning my kernel (2.6.0-test9-something) said that
> > TSC became unusable. There are no other messages around this
> > time in the log. It could be thermal throttling, but it should
> > print some message when X86_MCE_P4THERMAL is enabled, yes?
> > It happened after 17hrs 56min of uptime. System never produced
> > this message before. 
> 
> Hmmm. Interesting. You haven't seen it before and you've been running
> 2.6.0-testX for awhile?

I do not know when this monitoring entered kernel, but system is running
2.6.0-testX kernels since July 22, when it booted 2.6.0-test1-c1534...
 
> Any heavy cron jobs running at that time? 

atsar says:
         cpu %usr %sys %nice %idle pswtch/s runq nrproc lavg1 ..5 ..15
08:30:01 all 3    1    0     95    134      3    125    0.03 0.03 0.00
08:40:01 all 3    1    0     95    108      4    125    0.07 0.05 0.01
08:50:01 all 3    1    0     95     83      4    123    0.03 0.03 0.00

High process switch rate is caused by running teletext grabber. There is
peak at 6:30-6:50 caused by cron.daily.
 
> The message is caused after 100 consecutive timer ticks where it appears
> that the system has lost ticks. The assumption is that something has
> gone wrong and we can no longer trust the TSC as a time source
> (speedstep, for instance). Thermal throttling is a possibility, but I've
> not actually seen it occur. I'd have to defer to the cpufreq folks on
> that one. 

bash# grep FREQ .config 
# CONFIG_CPU_FREQ is not set
bash#

> If we're getting false positives, we may have to bump that
> 100-consecutive-ticks number up. 
> 
> Anything else quirky about the system?

I'm not aware of any problem. Three or four months ago I reported memory
corruption in one of bitkeeper files (32bits replaced with something
else), but it did not occured again since then.
 
> >   Are there some more information I could supply, or should I
> > simple live with fact that TSC stopped working on my P4 today
> > morning?
> 
> Well, the TSC didn't stop working, we just stopped using it as a time
> source. Things should work fine using just the PIT, although I'd be
> interested to hear if ntpd finally settled down after the change. If it
> cannot stay synced it may be an issue w/ your system's PIT. 

It did not produce any message since 9:54 (>14 hrs ago). Only difference
is that in the past /var/lib/ntp/ntp.drift listed value 4.496 to 4.967
(looking at all values I have logged in /var/log/syslog), but now
it says 45.662. But what I can expect from PIT...

> You may also want to check the ACPI PM timesource code in -mm4, and see
> how that works for you. 

Sometime ;-) Maybe if it will hit Linus kernel ;-)
                                                    Petr Vandrovec
                                                    

