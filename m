Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265622AbUBJFVE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 00:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265629AbUBJFVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 00:21:04 -0500
Received: from smtp04.web.de ([217.72.192.208]:22560 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S265622AbUBJFU6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 00:20:58 -0500
Message-ID: <40286A37.2010104@web.de>
Date: Tue, 10 Feb 2004 06:20:55 +0100
From: Todor Todorov <ttodorov@web.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>, davej@codemonkey.org.uk
Subject: [2.6.2] CPU-FREQ with speedstep-ich BUG
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list & DaveJ,

I wanted to test the cpu frequency scaling on my laptop with a P4 mobile 
processor. This is my corresponding kernel configuration:
#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
# CONFIG_CPU_FREQ_PROC_INTF is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
# CONFIG_CPU_FREQ_24_API is not set
CONFIG_CPU_FREQ_TABLE=y

#
# CPUFreq processor drivers
#
# CONFIG_X86_ACPI_CPUFREQ is not set
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_POWERNOW_K7 is not set
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_GX_SUSPMOD is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_SPEEDSTEP_ICH=m
CONFIG_X86_SPEEDSTEP_SMI=m
CONFIG_X86_P4_CLOCKMOD=m
CONFIG_X86_SPEEDSTEP_LIB=m
# CONFIG_X86_LONGRUN is not set
# CONFIG_X86_LONGHAUL is not set

My processor has max freq 2 GHz and min freq 1.2 GHz. After loading the 
speedstep_ich module all relevant files under 
/sys/devices/system/cpu/cpu0/cpufreq appear just fine. Doing an `echo 
"powersave" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor` 
works fine too and the cpu starts working at 1.2 GHz. But echo-ing 
"performance" back to the scaling_governor file doesn't seem to work - 
/proc/cpuinfo still shows cpu MHz : 1200 (before the first change to 
powersave it shows normal 2 GHz)

My only source of information is the /proc/cpuinfo file. The acpi stuff 
under /proc doesn't show any change in cpu state or throtling at all, no 
matter of the governor (I suppose because the acpi states module is not 
being used as a driver instead of speedstep-ich, but the acpi mod desn't 
load on my dell i8500)

I hope someone can fix this. TIA

Regards,
Todor
