Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264103AbTEGQvf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 12:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264104AbTEGQvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 12:51:35 -0400
Received: from mail.microtechcomp.com ([64.214.131.229]:2102 "EHLO
	mail.Microtech") by vger.kernel.org with ESMTP id S264103AbTEGQvc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 12:51:32 -0400
Subject: x86_64 interrupts handled by CPU0 only
From: Will Dinkel <wdinkel@atipa.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Atipa Technologies
Message-Id: <1052326953.22518.184.camel@zappa>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 07 May 2003 12:02:34 -0500
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 May 2003 17:03:47.0848 (UTC) FILETIME=[A0118080:01C314BA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are all interrupts supposed to be handled by CPU0 on x86_64, or is
something amiss?  I'm getting the following on Mandrake Corporate Server
2.1:

---
[root@lab180 root]# uname -r -v -m -o
2.4.19-31mdksmp #1 SMP Thu Apr 17 09:34:46 EDT 2003 x86_64 GNU/Linux
[root@lab180 root]# cat /proc/interrupts
           CPU0       CPU1
  0:     447602          0    IO-APIC-edge  timer
  1:        424          0    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
 12:        851          0    IO-APIC-edge  PS/2 Mouse
 14:      25038          1    IO-APIC-edge  ide0
 15:       4930          1    IO-APIC-edge  ide1
 19:          0          0   IO-APIC-level  usb-ohci, usb-ohci
 24:     105196          0   IO-APIC-level  ioc0, eth0
 25:         46          0   IO-APIC-level  ioc1
NMI:       2235       3808
LOC:     447494     447555
ERR:          0
MIS:          0
---

I see this behavior on systems using either the MSI or Tyan dual-opteron
boards.  I also see it on RedHat's preview x86_64 distribution (kernel
version 2.4.20-9.2).

I'm still trying to get 2.5.69 to boot correctly, so I don't have
results there yet.  On RedHat it hangs after "Booting the kernel..."
(and yes, I have CONFIG_VT, and CONFIG_VT_CONSOLE on).  Any ideas?

System info:

---
[root@lab180 root]# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 5
model name      : AMD Opteron(TM) 64 Processor 242
stepping        : 0
cpu MHz         : 1594.727
cache size      : 1024 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov
pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm 3dnowext 3dnow
bogomips        : 3178.49
TLB size        : 1088 4K pages
clflush size    : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts ttp

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 5
model name      : AMD Opteron(TM) 64 Processor 242
stepping        : 0
cpu MHz         : 1594.727
cache size      : 1024 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov
pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm 3dnowext 3dnow
bogomips        : 3185.04
TLB size        : 1088 4K pages
clflush size    : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts ttp

[root@lab180 root]# lspcidrake
unknown         : Advanced Micro Devices|AMD-8111 PCI
unknown         : Advanced Micro Devices|AMD-8111 LPC
unknown         : Advanced Micro Devices|AMD-8111 IDE
unknown         : Advanced Micro Devices|AMD-8111 ACPI
unknown         : Advanced Micro Devices|AMD-8131 PCI-X Bridge
unknown         : Advanced Micro Devices|AMD-8131 PCI-X APIC
unknown         : Advanced Micro Devices|AMD-8131 PCI-X Bridge
unknown         : Advanced Micro Devices|AMD-8131 PCI-X APIC
unknown         : Advanced Micro Devices|K8 NorthBridge
unknown         : Advanced Micro Devices|K8 NorthBridge
unknown         : Advanced Micro Devices|K8 NorthBridge
unknown         : Advanced Micro Devices|K8 NorthBridge
unknown         : Advanced Micro Devices|K8 NorthBridge
unknown         : Advanced Micro Devices|K8 NorthBridge
unknown         : Advanced Micro Devices|K8 NorthBridge
unknown         : Advanced Micro Devices|K8 NorthBridge
usb-ohci        : Advanced Micro Devices|AMD-8111 USB
usb-ohci        : Advanced Micro Devices|AMD-8111 USB
unknown         : unknown (105a/3373/ffff/ffff)
Card:ATI Mach64 Utah: ATI|Rage XL
bcm5700         : Broadcom Corporation|BCM5704 CIOB-E 1000BaseTX
bcm5700         : Broadcom Corporation|BCM5704 CIOB-E 1000BaseTX
mptscsih        : Symbios|53c1030
mptscsih        : Symbios|53c1030
unknown         : Virtual|Hub []
unknown         : Virtual|Hub []
---

-- 
Will Dinkel <wdinkel@atipa.com>
Atipa Technologies

