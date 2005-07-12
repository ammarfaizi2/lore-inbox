Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbVGLLMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbVGLLMI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 07:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbVGLLJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 07:09:43 -0400
Received: from nproxy.gmail.com ([64.233.182.201]:16030 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261334AbVGLLH5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 07:07:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=prGrGG4JtTNHjzKkZkBYtwWwtLD+R/yfsUknf3vLmDPCqbw0qsFDTYCI2QRcH75FM3mOg+LUCBXjLkpacIdKsd7niL17OaE1t/dWre5nGpJVNI3E1RFtA5Y673L7/ZXb9NeNvi/shHRkDwVxjCnrqEK5EcJ/qDuEE4TPqeyGIBM=
Message-ID: <6278d22205071204073a6de1a2@mail.gmail.com>
Date: Tue, 12 Jul 2005 12:07:56 +0100
From: Daniel J Blueman <daniel.blueman@gmail.com>
Reply-To: Daniel J Blueman <daniel.blueman@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ondemand cpufreq ineffective in 2.6.12 ?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I find the ondemand governor works as expected with 2.6.12 on my
Athlon64 Winchester [1]; as soon as I bzip2 a file, processor freq is
pinned at 1.8GHz and drops to 1GHz when idle.

--- [1]

$ cat /proc/cpuinfo 
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 31
model name      : AMD Athlon(tm) 64 Processor 3000+
stepping        : 0
cpu MHz         : 1004.646
cache size      : 512 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext
fxsr_opt lm 3dnowext 3dnow
bogomips        : 1988.83
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

Ken Moffat wrote:
> Hi,
> 
>  I've been using the ondemand governor on athlon64 winchesters for a few
> weeks.  I've just noticed that in 2.6.12 the frequency is not
> increasing under load, it remains at the lowest frequency.  This seems
> to be down to something in 2.6.12-rc6, but I've seen at least one report
> since then that ondemand works fine.  Anybody else seeing this problem ?
> 
>  Testcase: boot (my bootscripts set the governor to ondemand), set the
> governor to ondemand, performance, powersave and untar a nice big
> bzip2'd tarball (gcc-3.4.1) from an nfs mount. All using the config from
> 2.6.11.9 and defaults for new options.
> 
> kernel		2.6.11.9	2.6.12-rc5	2.6.12-rc6	2.6.12
> 
> ondemand	20.8 sec	21.3 sec	33.9 sec	34.1 sec
> performance	21.3 sec	22.0 sec	22.6 sec	20.1 sec
> powersave	32.4 sec	33.1 sec	33.6 sec	33.9 sec
> 
> I don't have confidence that the numbers are more repeatable than +/- 2
> seconds on this, they just illustrate that ondemand used to give a
> similar time to performance, but now doesn't.  Other intermediate and
> later tests have been omitted for clarity, but 2.6.12.2 does show the
> same problem.
> 
> Since 2.6.12-rc6, 'ondemand' appears to be still accepted (the echo to
> scaling_governor returns 0, and the displayed frequency drops back if
> I try going from performance to ondemand).
> 
> When ondemand appears to work properly, /proc/cpuinfo shows the speed
> jumping to 2 GHz, then falling back to 1.8 after the untar ends, then
> back to 1.0 GHz.  In the problem cases, the speed remains at 1GHz.
> 
> As far as I can see, nothing untoward shows in the logs.  Any
> suggestions, please ?
> 
> Ken
___
Daniel J Blueman
