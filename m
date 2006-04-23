Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751454AbWDWVQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbWDWVQd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 17:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbWDWVQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 17:16:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43651 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751454AbWDWVQc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 17:16:32 -0400
Date: Sun, 23 Apr 2006 14:15:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kevin Baradon <kevin.baradon@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Li, Shaohua" <shaohua.li@intel.com>
Subject: Re: 2.6.17-rc1: kernel only boots one CPU on HT system
Message-Id: <20060423141519.314ae567.akpm@osdl.org>
In-Reply-To: <200604231434.59966.Kevin.Baradon@gmail.com>
References: <200604231434.59966.Kevin.Baradon@gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Baradon <kevin.baradon@gmail.com> wrote:
>
> Hello,
> 
> Starting with kernel 2.6.17-rc1 (also happens with 2.6.17-rc2), second 
> logical-CPU of my Hyperthreading system no longer boots.
> 
> I tracked up changes in APIC code, and it appears reverting commit 
> 7c5c1e427b5e83807fd05419d1cf6991b9d87247 fixes this bug.

That helps heaps, thanks.

> See both dmesgs, and kernel configuration attached.
> 
> Feel free to ask me if you need other informations.
> Please CC me as I'm not subscribed to LKML.
> 
> 
> Hardware : 
> ------------------------------
> MB: Gigabyte GA-8SINXP1394
> CPU: Intel Pentium 4 3.06Ghz HT
> RAM: Corsair 512Mo
> 
> cat /proc/cpuinfo: (patched kernel)
> ------------------------------
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 15
> model           : 2
> model name      : Intel(R) Pentium(R) 4 CPU 3.06GHz
> stepping        : 7
> cpu MHz         : 3081.400
> cache size      : 512 KB
> physical id     : 0
> siblings        : 2
> core id         : 0
> cpu cores       : 1
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
> cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
> bogomips        : 6165.74
> 
> processor       : 1
> vendor_id       : GenuineIntel
> cpu family      : 15
> model           : 2
> model name      : Intel(R) Pentium(R) 4 CPU 3.06GHz
> stepping        : 7
> cpu MHz         : 3081.400
> cache size      : 512 KB
> physical id     : 0
> siblings        : 2
> core id         : 0
> cpu cores       : 1
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
> cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
> bogomips        : 6162.10
> 
> cat /proc/interrupts :  (patched kernel)
> -----------------------------
>            CPU0       CPU1
>   0:    2143303       6647    IO-APIC-edge  timer
>   1:         15          9    IO-APIC-edge  i8042
>   4:          7          1    IO-APIC-edge  serial
>   8:      19518          1    IO-APIC-edge  rtc
>   9:          0          0   IO-APIC-level  acpi
>  15:      37053         23    IO-APIC-edge  ide1
>  16:     240872          1   IO-APIC-level  cx88[0], eth-lan
>  17:      11128         19   IO-APIC-level  ide2, ide3
>  18:      63432          4   IO-APIC-level  libata, ohci1394, CS46XX
>  19:          0          3   IO-APIC-level  ehci_hcd:usb1
>  20:     457635        195   IO-APIC-level  ohci_hcd:usb2
>  21:          0          0   IO-APIC-level  ohci_hcd:usb3
>  22:          0          0   IO-APIC-level  ohci_hcd:usb4
> NMI:    2149889    2149786
> LOC:    2150122    2150121
> ERR:          0
> MIS:          0
> 

Shaohua, I'll queue up a reversion patch so this doesn't get forgotten
about but I won't send it to Linus at this stage.
