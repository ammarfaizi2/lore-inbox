Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750849AbWBWGfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbWBWGfK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 01:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbWBWGfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 01:35:09 -0500
Received: from liaag1ab.mx.compuserve.com ([149.174.40.28]:32433 "EHLO
	liaag1ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750849AbWBWGfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 01:35:08 -0500
Date: Thu, 23 Feb 2006 01:30:47 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Kernel panic when compiling with SMP support
To: "largret@gmail.com" <largret@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200602230134_MC3-1-B90B-65B0@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <1140587779.5511.14.camel@shogun.daga.dyndns.org>

On Tue, 21 Feb 2006 at 21:56:19 -0800, Chris Largret wrote:

> > You can try slowing down your CPUs by doing:
> > 
> > # echo -n "powersave" >/sys/devices/system/cpu/cpuN/cpufreq/scaling_governor
> > 
> > for each cpu (assuming you have a driver loaded, and you should.)
> 
> I have that path out to /sys/devices/system/cpu/cpuN/. I've tried
> enabling several power options in the kernel config to get cpufreq/, but
> still don't have it. Do you know which option it is off the top of your
> head?

Is PowerNow loading?  I have:

 powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.60.0)
 powernow-k8:    0 : fid 0x8 (1600 MHz), vid 0x4 (1450 mV)
 powernow-k8:    1 : fid 0x0 (800 MHz), vid 0x16 (1000 mV)


> CONFIG_CPU_FREQ=y
> CONFIG_CPU_FREQ_TABLE=y
> # CONFIG_CPU_FREQ_DEBUG is not set
> CONFIG_CPU_FREQ_STAT=m
> CONFIG_CPU_FREQ_STAT_DETAILS=y
> # CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
> CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
> CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> CONFIG_CPU_FREQ_GOV_POWERSAVE=y
> CONFIG_CPU_FREQ_GOV_USERSPACE=y
> CONFIG_CPU_FREQ_GOV_ONDEMAND=m
> CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y

> CONFIG_X86_POWERNOW_K8=y
> CONFIG_X86_POWERNOW_K8_ACPI=y
> CONFIG_X86_SPEEDSTEP_CENTRINO=m
> CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI=y
> CONFIG_X86_ACPI_CPUFREQ=y


Try:

CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_TABLE=y
# CONFIG_CPU_FREQ_DEBUG is not set
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_STAT_DETAILS is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
# CONFIG_CPU_FREQ_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set

CONFIG_X86_POWERNOW_K8=y
CONFIG_X86_POWERNOW_K8_ACPI=y
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_ACPI_CPUFREQ=y

And if it doesn't work try enabling CONFIG_CPU_FREQ_DEBUG

-- 
Chuck
"Equations are the Devil's sentences."  --Stephen Colbert

