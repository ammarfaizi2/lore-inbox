Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267585AbUJHGer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267585AbUJHGer (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 02:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268029AbUJHGer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 02:34:47 -0400
Received: from mail01.syd.optusnet.com.au ([211.29.132.182]:49098 "EHLO
	mail01.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S267585AbUJHGep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 02:34:45 -0400
Message-ID: <416634FE.60108@kolivas.org>
Date: Fri, 08 Oct 2004 16:34:38 +1000
From: Con Kolivas <lkml@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: michel.mengis@epfl.ch
Cc: linux <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.6.8 and DELL's DOTHAN Processor B0
References: <1097216489.416631e91faf9@imapwww.epfl.ch>
In-Reply-To: <1097216489.416631e91faf9@imapwww.epfl.ch>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

michel.mengis@epfl.ch wrote:
> 
> Hi all,
> 
> I have a lot of trouble to bring the kernel 2.6.8-1 to detect my dothan
> processor.
> It's a Pentium M Dothan B0 version, 1.7Ghz/600Mhz.
> The BIOS is DELL's D800 Bios version 09.
> 
> I added 3 patches:
> cpufreq-speedstep-dothan-3.patch :add correct frequency table in speedstep.c
> dothan-speedstep-fix.patch : add correct Level2 cache
> bk-cpufreq.patch : from http://linux-dj.bkbits.net/cpufreq
> 
> I added a lot of output in speedstep-centrino.c, acpi/processor.c to track the
> problem.
> 
> I notice that my computer is running always in the lowest speed evenif I'm
> stressing it... All ouputs I added show me that Speedstep isn't the cause,
> neither CPUFreq but while CPUFreq calls all notifiers, acpi/processor.c's
> CPUFREQ_INCOMPATIBLE change the max speed to the lowest evenif during
> cpufreq_acpi_cpu_init the max speed is well detected.
> Seems to be like it's coz at boot time the kernel doesn't detect correctly the
> max speed.
> dmesg shows me that a 600Mhz processor has been detected only and not 1.7Ghz.
> (on my D600 pentium M not dothan, it detects correctly 1.6Ghz)
> 
> is there a fix for that ?
> is it a known bug ?
> 
> thx for all help I can get,

Sounds like you've chosen powersave as the default power governor in 
your config. Change it to performance or modify it manually in
/sys/devices.... cpufreq/scaling_governor
(cant remember the exact position; you'll find it)

cat the output of that file and see if it says powersave performance or 
ondemand. You can manually change it from one to the other, or set 
either powersave or performance in your config during kernel config.

Cheers,
Con
