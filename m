Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261775AbUK2UXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbUK2UXM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 15:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbUK2UXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 15:23:12 -0500
Received: from moutng.kundenserver.de ([212.227.126.176]:29417 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261775AbUK2UW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 15:22:28 -0500
Message-ID: <41AB853D.8010909@akik-ffm.de>
Date: Mon, 29 Nov 2004 21:23:25 +0100
From: Christoph Zimmermann <cz@akik-ffm.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Potential race condition in SMP version of 2.6.9?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:81682f751c3aefccc5fcfa92aabe61f9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm having severe problems getting the SMP version of 2.6.9 up
and running. I'm using a stock-version of FC2 without
modificiation bar the kernel and the kudzu modification / removal
as suggested in linux.redhat.install on 2004-9-25/26 when facing
similar problems.

The problem manifests during the level 5 boot phase when certain scripts 
in /etc/rc5.d are executed, more precisely the S90xfs and S96readahead
scripts. I first observed the problem when booting the SMP version
of the kernel (configuration: all experimental features switched off,
SMP enabled with 2 CPUs and hyperthreading scheduler support enabled).
The font server apparently never returns and thus the init sequence
seems to hang. So I moved the execution of the script to S98xfs just
to check. Now S96readahead stalls with the same symptoms and
boot sequence hangs again. Trying any of the sys-rq features
(although enabled in the kernel config) to get some initial debug info
does not work. I'm using a single-CPU Pentium 4 system with
ACPI and HT enabled in the BIOS (see copy of /proc/cpuinfo below).

The initialisation sequence works perfectly well when using the
kernel that came with FC2 or 2.6.9 without SMP support. Thus,
I'm suspecting a race condiition / deadlock within the kernel.

Any thoughts on this or pointers to hints? I'd be glad to
provide any additional information (strace dumps, etc.) as required.

This is my cpuinfo data:

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Pentium(R) 4 CPU 3.20GHz
stepping	: 9
cpu MHz		: 3200.961
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
bogomips	: 6324.22

     Cheers, Christoph
