Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbTEMMb5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 08:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbTEMMb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 08:31:57 -0400
Received: from kunde0838.tromso.alfanett.no ([62.16.131.79]:59872 "EHLO shogun")
	by vger.kernel.org with ESMTP id S261171AbTEMMbz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 08:31:55 -0400
Message-ID: <3EC0E885.9070306@thule.no>
Date: Tue, 13 May 2003 14:43:49 +0200
From: Troels Walsted Hansen <troels@thule.no>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.3.1) Gecko/20030425
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew McGregor <andrew@indranet.co.nz>
CC: Tuncer M zayamut Ayaz <tuncer.ayaz@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.69 strange high tone on DELL Inspiron 8100
References: <1405.1052575075@www9.gmx.net> <3191078.1052695705@[192.168.1.249]>
In-Reply-To: <3191078.1052695705@[192.168.1.249]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew McGregor wrote:
> Try this (which will make no difference to the effectiveness of APM on 
> this machine):
> 
>> CONFIG_PM=y
>>
>> CONFIG_APM=y
>> CONFIG_APM_DO_ENABLE=n
>> CONFIG_APM_CPU_IDLE=n
>> CONFIG_APM_DISPLAY_BLANK=y
>> CONFIG_APM_REAL_MODE_POWER_OFF=y
>>
>> CONFIG_CPU_FREQ=n
>> CONFIG_CPU_FREQ_TABLE=n
>>
>> CONFIG_X86_SPEEDSTEP=n
> 
> 
> Reasoning:
> cpufreq and speedstep don't work on Dell P3 laptops anyway, and the 
> *internal power supplies* of the i8x00 series make wierd noises when APM 
> tries to idle the CPU.  The board will do this anyway, without making 
> noise, so linux need not.

My Dell Latitude C600 shows the exact same problem. I noticed it after 
upgrading to from RH7.x to RH8 with kernel 2.4.18-27.8.0. I believe this 
kernel is customized by RH to use HZ=500 or something in that region.

With your analysis of the problem I was able to remove the noise by 
using the "apm=idle-threshold=100" parameter on the kernel commandline. 
This turns off APM idle calls without requiring kernel recompilation.

Using the "i8k" kernel module, I have verified that the temperature of 
the CPU is unchanged with APM idle turned off. I have not tried to 
measure power consumption or battery use.

Thanks for the tip!

-- 
Troels Walsted Hansen

