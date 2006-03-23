Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751474AbWCWRz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbWCWRz3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 12:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbWCWRz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 12:55:28 -0500
Received: from 213-140-2-71.ip.fastwebnet.it ([213.140.2.71]:58546 "EHLO
	aa004msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1751474AbWCWRzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 12:55:07 -0500
Date: Thu, 23 Mar 2006 18:55:58 +0100
From: Mattia Dongili <malattia@linux.it>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Alejandro Bonilla <abonilla@linuxwireless.org>,
       Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org
Subject: Re: Dual Core on Linux questions
Message-ID: <20060323175558.GA4386@inferi.kami.home>
Mail-Followup-To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
	Alejandro Bonilla <abonilla@linuxwireless.org>,
	Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org
References: <88056F38E9E48644A0F562A38C64FB6007A24C46@scsmsx403.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88056F38E9E48644A0F562A38C64FB6007A24C46@scsmsx403.amr.corp.intel.com>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.16-rc6-mm1-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 22, 2006 at 07:36:42PM -0800, Pallipadi, Venkatesh wrote:
[...]
> minima changes required in cpufreqd if any.
> Options:
> 1) Multiple core can manage frequency independently: In this case,
> cpufreq exports separate interfaces for each cpu in
> /sys/devices/system/cpu/cpuX. So, cpufreqd should work as it would work
> on an SMP system (Assuming that cpufreqd works fine on an SMP system
> today ;-))

hehe, this is exactely where cpufreqd needs some work as it doesn't
distinguish between UP and MP currently, it just applies the same
cpufreq policy  to all available processors.
But I'm already working on this.

> 2) Multiple cores can be at a single frequency, but hardware will
> coordinate between two cores internally (pick the highest frequency
> request from two cores and run both of them at that frequency). This
> will be very much similar to 1, in the way in which cpufreq and kernel
> handles it.

cpufreqd has no problems here.

> 3) Multiple cores can be at a single frequency and hardware depends on
> OS to do the coordination, pick the maximum of all the requests from the
> cores and set the frequency using appropriate hardware interface. This
> is the case, where cpufreqd may need a change. In this case, say CPU 0
> and 1 are two different cores on same package and they share frequency
> and OS has to coordinate the freq request from these two CPUs. In this
> case, /sys/devices/system/cpu/cpu1/cpufreq will be kind of a symbolic
> link to /sys/devices/system/cpu/cpu0/cpufreq. Cpufreq tells that these
> two are dependent by using "affected_cpus" in the same sysfs directory

yes, cpufreqd needs some work on this, but it will be easily handled
once 1) is done and anyway it is't that bad here currenlty, it will
just write to both .../cpu0 and .../cpu1 the same profile.

> (in this case "0 1"). Now, if cpufreqd does a set_speed on cpu0 and
> cpu1, both CPUs will be affected. Cpufreqd should be aware that these
> CPUs are dependent and change freq based on maximum utilization of these
> two CPUs.

Oh, there's the ondemand governor for this. 
A little digression though just to point out that cpufreqd works
differently from cpuspeed, speedfreq et al.
It collects system status data (acpi/apm/pmu data, cpu load,
sensors data,...) and applies a cpufreq policy based on user defined
rules (eg: when battery is between 5% and 50% and ac is unplugged run
with ondemand @ 40%-70% - quite like the old speestep applet I found on
win2k on this laptop some years ago).
No best frequency caclulation is done, too many parameters and for just
the cpu load we have the excellent ondemand governor.

Thanks for the useful insight!
-- 
mattia
:wq!
