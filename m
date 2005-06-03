Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbVFCQOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbVFCQOY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 12:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbVFCQOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 12:14:17 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:18641 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261361AbVFCQNm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 12:13:42 -0400
Subject: Re: [PATCH 1/4] new timeofday core subsystem (v. B1)
From: john stultz <johnstul@us.ibm.com>
To: Frank Sorenson <frank@tuxrocks.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Nishanth Aravamudan <nacc@us.ibm.com>, Darren Hart <darren@dvhart.com>,
       "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org
In-Reply-To: <42A006E8.9000601@tuxrocks.com>
References: <1117667378.6801.80.camel@cog.beaverton.ibm.com>
	 <42A006E8.9000601@tuxrocks.com>
Content-Type: text/plain
Date: Fri, 03 Jun 2005 09:13:30 -0700
Message-Id: <1117815210.3674.6.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-06-03 at 01:29 -0600, Frank Sorenson wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> john stultz wrote:
> > Andrew, All,
> > 	I'm just re-spinning this to resolve a conflict w/ the CPUFREQ changes
> > Linus accepted last night.
> <snip>
> 
> John,
> 
> I have found an issue with these TOD subsystem patches, and I
> think it's only an issue on systems that use CPUFREQ.  Whenever
> the frequency changes, at least some portions of the kernel
> get confused about their notion of time.  Here are some
> example entries from my syslog:
> 
> Jun  3 00:33:40 moebius kernel: [  145.023201] cpufreq-core: target for CPU 0: 800000 kHz, relation 0
> Jun  3 00:33:47 moebius kernel: [  114.838909] cpufreq-core: target for CPU 0: 1000000 kHz, relation 0
> Jun  3 00:33:47 moebius kernel: [  114.838977] freq-table: request for target 1000000 kHz (relation: 0) for cpu 0
> Jun  3 00:33:47 moebius kernel: [   92.161872] codec_semaphore: semaphore is not ready [0x1][0x700300]
> Jun  3 00:33:52 moebius kernel: [   97.433279] cpufreq-core: target for CPU 0: 1200000 kHz, relation 0
> Jun  3 00:33:58 moebius kernel: [   66.352233] cpufreq-core: target for CPU 0: 1400000 kHz, relation 0
> Jun  3 00:34:08 moebius kernel: [   85.547260] cpufreq-core: target for CPU 0: 1200000 kHz, relation 0
> Jun  3 00:34:16 moebius kernel: [  211.791738] cpufreq-core: target for CPU 0: 800000 kHz, relation 0
> Jun  3 00:34:27 moebius kernel: [  112.941898] cpufreq-core: target for CPU 0: 1000000 kHz, relation 0
> Jun  3 00:34:31 moebius kernel: [  231.793121] cpufreq-core: target for CPU 0: 800000 kHz, relation 0
> Jun  3 00:34:41 moebius kernel: [  147.122593] cpufreq-core: target for CPU 0: 1200000 kHz, relation 0
> Jun  3 00:34:42 moebius kernel: [  123.906802] cpufreq-core: target for CPU 0: 1000000 kHz, relation 0
> Jun  3 00:34:46 moebius kernel: [  251.342116] cpufreq-core: target for CPU 0: 800000 kHz, relation 0
> Jun  3 00:34:51 moebius kernel: [  192.985214] cpufreq-core: target for CPU 0: 1000000 kHz, relation 0
> 
> The printk times are taken from sched_clock(), which now
> varies depending on the cpu frequency.  Without these patches,
> the printk times appear to consistently increase at the right rate.
> I'm not sure what other portions of the kernel are affected by
> this (watchdogs firing, or other issues?).

Yep, looks like something isn't right between sched_clock and the
cpufreq changes. I'll let you know when I've sorted it out.

Thanks for the great testing!
-john

