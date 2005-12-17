Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932638AbVLQSKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932638AbVLQSKq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 13:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932646AbVLQSKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 13:10:46 -0500
Received: from maggie.cs.pitt.edu ([130.49.220.148]:64151 "EHLO
	maggie.cs.pitt.edu") by vger.kernel.org with ESMTP id S932638AbVLQSKp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 13:10:45 -0500
From: Claudio Scordino <cloud.of.andor@gmail.com>
To: cpufreq@lists.linux.org.uk
Subject: Help: Using cpufreq from kernel level
Date: Sat, 17 Dec 2005 13:10:33 -0500
User-Agent: KMail/1.8
Cc: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512171310.34014.cloud.of.andor@gmail.com>
X-Spam-Score: -1.665/8 BAYES_00 SA-version=3.000002
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

   I'm writing a kernel module that needs to get info about the available 
frequencies on the current processor and to periodically change the current 
frequency.

At user level it can be done through

/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq
/sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed

but I have no idea how to implement it at kernel level. 

I tried to declare

extern struct cpufreq_driver    *cpufreq_driver;
extern struct cpufreq_policy    *cpufreq_cpu_data[NR_CPUS];
extern spinlock_t cpufreq_driver_lock;
extern ssize_t show_available_freqs (struct cpufreq_policy *policy, char 
*buf);

and to do

char buffer [100000] = "\n";
spin_lock_irqsave(&cpufreq_driver_lock, flags);
show_available_freqs(cpufreq_cpu_data[0], buffer);
spin_unlock_irqrestore(&cpufreq_driver_lock, flags);

but it crashes the system.

Please, can somebody tell me how this can be done ?

Many thanks,

        Claudio Scordino
