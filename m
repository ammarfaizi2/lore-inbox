Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271317AbTGQBdj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 21:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271318AbTGQBdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 21:33:39 -0400
Received: from smtp.netcabo.pt ([212.113.174.9]:48061 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S271317AbTGQBdi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 21:33:38 -0400
Message-ID: <3F16006A.8070202@netcabo.pt>
Date: Thu, 17 Jul 2003 02:48:26 +0100
From: Miguel Sousa Filipe <m3thos@netcabo.pt>
Organization: IST-RNL
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.4) Gecko/20030713
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Mundt <lethal@linux-sh.org>
CC: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1  doesn't compile on PPC iBook2.2
References: <200307170015.h6H0FRBX019953@harpo.it.uu.se> <3F15EEB7.2060008@netcabo.pt> <3F15F471.3000004@netcabo.pt> <20030717012858.GA11672@linux-sh.org>
In-Reply-To: <20030717012858.GA11672@linux-sh.org>
X-Enigmail-Version: 0.76.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Jul 2003 01:43:41.0780 (UTC) FILETIME=[DA044940:01C34C04]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mundt wrote:
> On Thu, Jul 17, 2003 at 01:57:21AM +0100, Miguel Sousa Filipe wrote:
> 
>>> CC      arch/ppc/platforms/pmac_nvram.o
>>> CC      arch/ppc/platforms/pmac_cpufreq.o
>>>arch/ppc/platforms/pmac_cpufreq.c: In function `do_set_cpu_speed':
>>>arch/ppc/platforms/pmac_cpufreq.c:179: `CPUFREQ_ALL_CPUS' undeclared 
>>>(first use in this function)
>>>arch/ppc/platforms/pmac_cpufreq.c:179: (Each undeclared identifier is 
>>>reported only once
>>>arch/ppc/platforms/pmac_cpufreq.c:179: for each function it appears in.)
>>>make[1]: *** [arch/ppc/platforms/pmac_cpufreq.o] Error 1
>>>make: *** [arch/ppc/platforms] Error 2
>>>
> 
> 
> This means that the driver hasn't been updated for the new cpufreq API changes.
> 
> CPUFREQ_ALL_CPUS is deprecated, as is the /proc interface (which is what
> proc_intf.c references), since now the sysfs interface is preferred.
> 
> The pmac_cpufreq.c driver will likely need to be updated a bit (which may
> already be done in the LinuxPPC trees) in order to build or function.
> 
> Notably, the verify stuff needs to be changed around quite a bit, since instead
> of doing the range validation and wrapping to cpufreq_verify_within_limits(), a
> frequency table is built up instead and subsequently passed through
> cpufreq_frequency_table_verify(). Take a look at some of the existing cpufreq
> drivers that are up-to-date for ideas on how to do this (most of the i386 ones,
> the SuperH one, and probably others).
> 
> As such, you can either look at updating the driver (if this hasn't already
> been done by the LinuxPPC folk), or you can just not build it in. Probably no
> good things will happen if you hack it to the point of building and then
> attempt to use it.
> 

Thanks for the feedback, where do i find the LinuxPPC 2.6.x tree?
Would like to have a look before everything else...


Miguel Sousa Filipe

