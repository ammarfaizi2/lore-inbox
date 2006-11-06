Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753250AbWKFPn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753250AbWKFPn6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 10:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753247AbWKFPn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 10:43:58 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:16070 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1753244AbWKFPn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 10:43:56 -0500
From: Christian <christiand59@web.de>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [discuss] Linux 2.6.19-rc4: known unfixed regressions (v2)
Date: Mon, 6 Nov 2006 16:43:13 +0100
User-Agent: KMail/1.9.5
Cc: Dave Jones <davej@redhat.com>,
       Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org> <200611051832.13285.christiand59@web.de> <20061106060021.GD5778@stusta.de>
In-Reply-To: <20061106060021.GD5778@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611061643.14217.christiand59@web.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:176b6e6b41629db5898eee8167b5e3a0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 6. November 2006 07:00 schrieb Adrian Bunk:
> On Sun, Nov 05, 2006 at 06:32:12PM +0100, Christian wrote:
> > Am Freitag, 3. November 2006 16:56 schrieb Dave Jones:
> > > On Fri, Nov 03, 2006 at 11:25:37AM +0300, Alexey Starikovskiy wrote:
> > >  > Could this be a problem?
> > >  > --------------------
> > >  > ...
> > >  > CONFIG_ACPI_PROCESSOR=m
> > >  > ...
> > >  > CONFIG_X86_POWERNOW_K8=y
> > >
> > > Hmm, possibly.  Christian, does it work again if you set them both to
> > > =y ?
> >
> > Yes, it works now! Only the change to CONFIG_ACPI_PROCESSOR=y made it
> > work again!
>
> You said 2.6.18 worked for you.
>
> Did you have CONFIG_ACPI_PROCESSOR=y in 2.6.18, or did
> CONFIG_ACPI_PROCESSOR=m, CONFIG_X86_POWERNOW_K8=y work for you in 2.6.18?

It worked with CONFIG_ACPI_PROCESSOR=m in 2.6.18-rc7. Since 2.6.19-rc1 it 
doesn't work anymore with CONFIG_ACPI_PROCESSOR=m.

user@ubuntu:~/Projekte/linux-2.6.18-rc7$ uname -a
Linux ubuntu.localnet 2.6.18-rc7 #2 SMP Wed Sep 13 11:28:41 CEST 2006 x86_64 
GNU/Linux

user@ubuntu:~/Projekte/linux-2.6.18-rc7$ lsmod | grep -Ei "processor|acpi|
power"
powernow_k8            16096  1
freq_table              6848  2 powernow_k8,cpufreq_stats
cpufreq_powersave       3584  0
asus_acpi              20644  0
processor              36872  2 powernow_k8,thermal


user@ubuntu:~/Projekte/linux-2.6.18-rc7$ grep -i 
ACPI_PROCESSOR /boot/config-2.6.18-rc7
CONFIG_ACPI_PROCESSOR=m

user@ubuntu:~/Projekte/linux-2.6.18-rc7$ 
grep -Ei "POWERNOW_K8" /boot/config-2.6.18-rc7
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_POWERNOW_K8_ACPI=y

+++ There's a difference in 2.6.19! CONFIG_X86_POWERNOW_K8_ACPI is gone +++

user@ubuntu:~/Projekte/linux-2.6.18-rc7$ 
grep -Ei "POWERNOW_K8" /boot/config-2.6.19-rc1
CONFIG_X86_POWERNOW_K8=y

user@ubuntu:~/Projekte/linux-2.6.18-rc7$ grep -Ei "CPUFREQ|
CPU_FREQ" /boot/config-2.6.18-rc7
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_TABLE=m
# CONFIG_CPU_FREQ_DEBUG is not set
CONFIG_CPU_FREQ_STAT=m
CONFIG_CPU_FREQ_STAT_DETAILS=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=m
CONFIG_CPU_FREQ_GOV_USERSPACE=m
CONFIG_CPU_FREQ_GOV_ONDEMAND=m
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
# CPUFreq processor drivers
CONFIG_X86_ACPI_CPUFREQ=m
# CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set

-Christian

