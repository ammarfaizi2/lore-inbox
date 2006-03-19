Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbWCSBiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbWCSBiX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 20:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbWCSBiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 20:38:23 -0500
Received: from smtp.osdl.org ([65.172.181.4]:24008 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751198AbWCSBiW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 20:38:22 -0500
Date: Sat, 18 Mar 2006 17:35:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org
Subject: Re: 2.6.16-rc6-mm2 uninitialized online_policy_cpus.bits[0]
Message-Id: <20060318173512.313a3453.akpm@osdl.org>
In-Reply-To: <200603191209.54946.kernel@kolivas.org>
References: <20060318044056.350a2931.akpm@osdl.org>
	<200603191209.54946.kernel@kolivas.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> Wonder if this is related to rc6's oops?
>  gcc 4.0.3
> 
>    CC [M]  arch/i386/kernel/cpu/cpufreq/speedstep-centrino.o
>  arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c: In function 
>  'centrino_target':
>  include/linux/bitmap.h:170: warning: 'online_policy_cpus.bits[0]' is used 
>  uninitialized in this function
>    CC [M]  arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.o
>  arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c: In function 
>  'acpi_cpufreq_target':
>  include/linux/bitmap.h:170: warning: 'online_policy_cpus.bits[0]' is used 
>  uninitialized in this function

Well conceivably.  That warning is a consequence of my quick hack to make
the ACPI tree compile on uniprocessor.

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc6/2.6.16-rc6-mm2/broken-out/git-acpi-up-fix.patch

My patch is, as the compiler points out, wrong.

I've sent that patch two or three times to the APCI maintainers, to the
ACPI mailing list and to the author of the original buggy patch.  The
response thus far has been dead silence.

IOW, despite my efforts, the ACPI tree has been in a non-compiling state on
uniprocessor since February 11.

This is pathetic.  People are trying to get things done here and ACPI is
getting in the way.  But *need* to get the ACPI development tree out for
people to test else we'll never be able to take another ACPI update into
mainline.

