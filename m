Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932598AbVLQS1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932598AbVLQS1d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 13:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932655AbVLQS1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 13:27:33 -0500
Received: from 213-140-2-69.ip.fastwebnet.it ([213.140.2.69]:29657 "EHLO
	aa002msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932598AbVLQS1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 13:27:32 -0500
Date: Sat, 17 Dec 2005 19:27:45 +0100
From: Mattia Dongili <malattia@linux.it>
To: Claudio Scordino <cloud.of.andor@gmail.com>
Cc: cpufreq@lists.linux.org.uk, kernelnewbies@nl.linux.org,
       linux-kernel@vger.kernel.org
Subject: Re: Help: Using cpufreq from kernel level
Message-ID: <20051217182744.GB7339@inferi.kami.home>
Mail-Followup-To: Claudio Scordino <cloud.of.andor@gmail.com>,
	cpufreq@lists.linux.org.uk, kernelnewbies@nl.linux.org,
	linux-kernel@vger.kernel.org
References: <200512171310.34014.cloud.of.andor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512171310.34014.cloud.of.andor@gmail.com>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.15-rc5-mm3-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2005 at 01:10:33PM -0500, Claudio Scordino wrote:
> Hi all,
> 
>    I'm writing a kernel module that needs to get info about the available 
> frequencies on the current processor and to periodically change the current 
> frequency.

So it seems you're writing a governor. See
Documentation/cpu-freq/governors.txt and
drivers/cpufreq/cpufreq_conservative.c
drivers/cpufreq/cpufreq_ondemand.c
drivers/cpufreq/cpufreq_performance.c
drivers/cpufreq/cpufreq_powersave.c
drivers/cpufreq/cpufreq_userspace.c

for a first reference.

> At user level it can be done through
> 
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
> /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
> 
> but I have no idea how to implement it at kernel level. 
> 
> I tried to declare
> 
> extern struct cpufreq_driver    *cpufreq_driver;
> extern struct cpufreq_policy    *cpufreq_cpu_data[NR_CPUS];
> extern spinlock_t cpufreq_driver_lock;
> extern ssize_t show_available_freqs (struct cpufreq_policy *policy, char 
> *buf);
> 
> and to do
> 
> char buffer [100000] = "\n";
> spin_lock_irqsave(&cpufreq_driver_lock, flags);
> show_available_freqs(cpufreq_cpu_data[0], buffer);
> spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
> 
> but it crashes the system.

of course it does, this is just the sysfs -show function and you're
passing it a null pointer as first parameter. If you look at
show_available_freqs code you'll see that cpufreq_cpu_data is
dereferenced and this happening with interrupts disabled..

hth
-- 
mattia
:wq!
