Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932630AbVLQSZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932630AbVLQSZK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 13:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932647AbVLQSZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 13:25:10 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:55584 "EHLO
	pd5mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932630AbVLQSZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 13:25:08 -0500
Date: Sat, 17 Dec 2005 12:24:33 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Help: Using cpufreq from kernel level
In-reply-to: <5kOPa-5vo-23@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <43A457E1.9090909@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <5kOPa-5vo-23@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Claudio Scordino wrote:
> Hi all,
> 
>    I'm writing a kernel module that needs to get info about the available 
> frequencies on the current processor and to periodically change the current 
> frequency.
> 
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
> 
> Please, can somebody tell me how this can be done ?

For one thing, you cannot put such a huge buffer on the kernel stack.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

