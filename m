Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbUGRGgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbUGRGgc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 02:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbUGRGgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 02:36:32 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:10112 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id S262406AbUGRGg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 02:36:29 -0400
Message-ID: <40FA1A69.4090902@t-online.de>
Date: Sun, 18 Jul 2004 08:36:25 +0200
From: "Harald Dunkel" <harald.dunkel@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8a3) Gecko/20040717
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: amd64, 2.6.7: several problems
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: SmpQhqZHYejBwBnLoXvKdXIC7QgCdAKdbqW7viadZaFa2gDv2AfBrB
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I've got some questions about amd64.

/proc/cpuinfo returns

	processor       : 0
	vendor_id       : AuthenticAMD
	cpu family      : 15
	model           : 12
	model name      : AMD Athlon(tm) 64 Processor 3200+
	stepping        : 0
	cpu MHz         : 2194.366
	cache size      : 512 KB
	fpu             : yes
	fpu_exception   : yes
	cpuid level     : 1
	wp              : yes
	flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm 3dnowext 3dnow
	bogomips        : 4341.76
	TLB size        : 1088 4K pages
	clflush size    : 64
	cache_alignment : 64
	address sizes   : 40 bits physical, 48 bits virtual
	power management: ts fid vid ttp

Please check the cache size. It _should_ be 1024 kB, at least that was written
on the bill I've got. Is this correct?



Next powernow-k8 refuses to load on my PC:

# modprobe powernow-k8
FATAL: Error inserting powernow_k8 (/lib/modules/2.6.7/kernel/arch/x86_64/kernel/cpufreq/powernow-k8.ko): No such device

This is strange. AFAIK all amd64 CPUs do have Powernow.
The ACPI modules (expecially processor), freq_table and cpuid
were all loaded. Whats wrong here?



I tried to compile a static powernow-k8, but that gave me the error
message

arch/x86_64/kernel/built-in.o(.init.text+0x7d9a): In function `powernowk8_cpu_init':
: undefined reference to `acpi_processor_register_performance'
arch/x86_64/kernel/built-in.o(.init.text+0x7f39): In function `powernowk8_cpu_init':
: undefined reference to `acpi_processor_unregister_performance'
arch/x86_64/kernel/built-in.o(.exit.text+0x33): In function `powernowk8_cpu_exit':
: undefined reference to `acpi_processor_unregister_performance'
make[1]: *** [.tmp_vmlinux1] Error 1
make[1]: Leaving directory `/usr/src/kernel-source-2.6.7'
make: *** [stamp-build] Error 2

The ACPI Processor stuff was still set to "build module", so it
seems that there is a missing dependency in menuconfig.


Any help would be highly appreciated

Harri
