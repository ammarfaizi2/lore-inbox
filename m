Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266276AbUFPMxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266276AbUFPMxm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 08:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266283AbUFPMxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 08:53:42 -0400
Received: from enz.schiach.de ([213.239.192.71]:21520 "EHLO schiach.de")
	by vger.kernel.org with ESMTP id S266276AbUFPMtS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 08:49:18 -0400
Date: Wed, 16 Jun 2004 14:47:08 +0200
From: Michael Ablassmeier <abi@grinser.de>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: [2.6.7] irq 3: nobody cared!
Message-ID: <20040616124708.GD21984@jail.schiach.de>
Reply-To: abi@grinser.de
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Accept-Language: de en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hi kernel Volks,

2.6.7 runs into problems while setting up usb stuff and disables IRQ#3,
(at least, for me) see kern.log:

 kernel: tg3.c:v3.6 (June 12, 2004)
 kernel: PCI: Found IRQ 3 for device 0000:05:02.0
 kernel: eth0: Tigon3 [partno(BCM95782A50) rev 3003 PHY(5705)]
 (PCI:33MHz:32-bit) 10/100/1000BaseT Ethernet 00:40:ca:68:64:0d
 kernel: eth0: HostTXDS[1] RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[0] TSOcap[1]
	[..]
 kernel: PCI: Found IRQ 3 for device 0000:00:1d.7
 kernel: ehci_hcd 0000:00:1d.7: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller
 kernel: PCI: Setting latency timer of device 0000:00:1d.7 to 64
 kernel: ehci_hcd 0000:00:1d.7: irq 3, pci mem e0097000
 kernel: ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
 kernel: irq 3: nobody cared!
 kernel:  [__report_bad_irq+42/139] __report_bad_irq+0x2a/0x8b
 kernel:  [note_interrupt+111/159] note_interrupt+0x6f/0x9f
 kernel:  [do_IRQ+295/310] do_IRQ+0x127/0x136
 kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
 kernel:  [__do_softirq+47/128] __do_softirq+0x2f/0x80
 kernel:  [do_softirq+38/40] do_softirq+0x26/0x28
 kernel:  [do_IRQ+259/310] do_IRQ+0x103/0x136
 kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
 kernel:  [ehci_start+700/854] ehci_start+0x2bc/0x356
 kernel:  [printk+272/362] printk+0x110/0x16a
 kernel:  [usb_register_bus+311/346] usb_register_bus+0x137/0x15a
 kernel:  [usb_hcd_pci_probe+685/1248] usb_hcd_pci_probe+0x2ad/0x4e0
 kernel:  [do_coredump+78/484] do_coredump+0x4e/0x1e4
 kernel:  [pci_device_probe_static+82/97] pci_device_probe_static+0x52/0x61
 kernel:  [__pci_device_probe+59/78] __pci_device_probe+0x3b/0x4e
 kernel:  [pci_device_probe+44/74] pci_device_probe+0x2c/0x4a
 kernel:  [bus_match+63/106] bus_match+0x3f/0x6a
 kernel:  [driver_attach+86/128] driver_attach+0x56/0x80
 kernel:  [bus_add_driver+145/163] bus_add_driver+0x91/0xa3
 kernel:  [driver_register+47/51] driver_register+0x2f/0x33
 kernel:  [register_sysctl_table+104/143] register_sysctl_table+0x68/0x8f
 kernel:  [pci_register_driver+92/132] pci_register_driver+0x5c/0x84
 kernel:  [init+35/48] init+0x23/0x30
 kernel:  [do_initcalls+39/179] do_initcalls+0x27/0xb3
 kernel:  [init_workqueues+23/48] init_workqueues+0x17/0x30
 kernel:  [init+0/339] init+0x0/0x153
 kernel:  [init+56/339] init+0x38/0x153
 kernel:  [kernel_thread_helper+0/11] kernel_thread_helper+0x0/0xb
 kernel:  [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb
 kernel:
 kernel: handlers:
 kernel: [usb_hcd_irq+0/103] (usb_hcd_irq+0x0/0x67)
 kernel: Disabling IRQ #3

using 2.6.6, it works, /proc/interrupts shows:

 	    CPU0       
   0:   10248130          XT-PIC  timer
   2:          0          XT-PIC  cascade
   3:     147782          XT-PIC  ehci_hcd, eth0
   5:     213155          XT-PIC  uhci_hcd
  10:          0          XT-PIC  uhci_hcd, Intel ICH5
  11:          0          XT-PIC  libata, uhci_hcd
  14:      15207          XT-PIC  ide0
 NMI:          0 
 ERR:          0

for more information regarding the system and its hardware, see 
attached lspci output. Both, 2.6.6 and 2.6.7 are using the same
configuration, hope this helps.

bye,
    - michael

--Qxx1br4bt0+wmkIi
Content-Type: application/x-gunzip
Content-Description: /proc/ioports
Content-Disposition: attachment; filename="ioports.gz"
Content-Transfer-Encoding: base64

H4sICNFA0EACA2lvcG9ydHMAbZBBboMwEEX3PoX3VaIZcMDNtqvueoPKsT0JatNEUVKpt+98
IDGlSAjBe8+DMRHRiojFbm06BjZEFUDFCs5dBHAAGxTX7pgvShqQBuQj/+xO4ZIUekA/DrLn
sM/2kvcqAkQYB1YKIkAaSwABEAA534zuRt9ZWn3vUiZDNVbU/YrvfXhSIM0Kt0cRxa/0huLt
5dXG05ewYfwcD4P1kbZ6saw3hh2EqxeEg9j8EWlNxtqpuh1i936ISfsGsJ313PdFTXoP+Dzr
q74vatJHwDjb6DB/UI9T6pG/14r0AFxCk2bLh88V9dntwjVonYFyO6mp0p9nJ5gri2OKuo/x
OFxP7UI9UY+agbheqosqtQNanF3UWAs+J76d7ZuMBIhQ/xO/UXLNIQ8DAAA=

--Qxx1br4bt0+wmkIi
Content-Type: application/x-gunzip
Content-Description: /proc/iomem
Content-Disposition: attachment; filename="iomem.gz"
Content-Transfer-Encoding: base64

H4sICNRA0EACA2lvbWVtAG2QQW6DMBBF9z6F91WiGXDAzbar7nqDyrE9CWrTRFFSqbfvfCAx
pUgIwXvPgzER0YqIxW5tOgY2RBVAxQrOXQRwABsU1+6YL0oakAbkI//sTuGSFHpAPw6y57DP
9pL3KgJEGAdWCiJAGksAARAAOd+M7kbfWVp971ImQzVW1P2K7314UiDNCrdHEcWv9Ibi7eXV
xtOXsGH8HA+D9ZG2erGsN4YdhKsXhIPY/BFpTcbaqbodYvd+iEn7BrCd9dz3RU16D/g866u+
L2rSR8A42+gwf1CPU+qRv9eK9ABcQpNmy4fPFfXZ7cI1aJ2BcjupqdKfZyeYK4tjirqP8Thc
T+1CPVGPmoG4XqqLKrUDWpxd1FgLPie+ne2bjASIUP8Tv1FyzSEPAwAA

--Qxx1br4bt0+wmkIi
Content-Type: application/x-gunzip
Content-Disposition: attachment; filename="lspci.gz"
Content-Transfer-Encoding: base64

H4sICG080EACA2xzcGNpAO2YbW/aSBDHX8OnGKkvjshxWRsbXNRUMoYG1JC60OROinix2Gti
1dhovW5LP/3NmofwHHIhvfZ0TQU23lnvzv+3OzNLCCH1/P9rAu0kFTDkoT9idejEgkXgJHzy
GizdqpqXZbdVdqHZs7v4cyx4EkWMl6WR2s6GuQEPqMegxNlXIPpZsdDPhuk0FWxchzb7FjEh
VJd6Xyj3sYvxhMbTOtzEX+LkWww++xqisaYP/WJh/gIcRvmjCl02VqCRpV2KfXEF+hPmOVMv
YvmjPzvXtyrcXtr9OEkmKriUtzhXoS/YZBLGI7xq9XoKvEfrht5QcViCiiytg0MnClSr3fYP
FW6a79VFE2XZR7N1229dXQT4O7z7bA8TLlR4u7zo5hcKvJNvwHtXfhULV1Sw2MO5kWKhx0Zh
EgOpy6EmfApUACOzf1Cq6OowFOcw4Sxgwrunw4ih33BgdBhGoQgZDvOOGQN4Rd7AHdFIdVAs
koVqOqqGEwdPOlOEaIyXC2l2aZj/NOI4Ph8uOZ3ch14KzZnnF7JBacKTkRoGgCO8w+4Hp1JS
OYmS6sspqR5SMgecZxNRBxwM2MCTTPpRJNDpfQJzt9bBY1rPjbQ1I8vYMIqTWF0zhLs0/MEu
TE3/MFh2ouduhglOJZX9aAYj84bWYAsrnwzATb4xDl0a0xEbs1jAV8bTfDzFQuF9REfY0O22
nOgLurDfUaCp4YWugp19dzLO0eSCjG3ZptQk6jk+PsfH583KfSLkl5dEvorTXErVJLKx2orl
NGSnLLog+OXRiF3Mnj0QrvlI+E2/sbLjbGFNtFaj3OpBqeO0zbL86J3lNjdtpwOvtD1gy6en
JVt9IbLVo8geMz/Mxi/NtrFFmLEgrKIP1oTTnimc/r9wTxausSGcRg4oV92nnP5M5Sr/K/dk
5ZxN5bQDyln7lKv9U+V0aEnpHix3SKjjW1unlPAXyOxOKWFzQ8LKnozAQv0OB/etUG0eCtX6
zlCt7grVlZq5DNbKerBW5sFaeWqw3hqrJbNVCnc6oWQVT4ax3EXI9pQYRGvYZccuNxHQnFFZ
VYTLqgKdKo0bufGMTm9zg7lO+JhGCJyX+ExievrsU3nOhvGM7LMhXzTh4Zjy6QUh55DiJGM/
vzPxLsMe/DBGi9k989RoZn5RNRBV3ECG7D6M/aX7pS4yO1XzVDMIgmJhDulGw8Ay8yZqYNWC
IG/ortAK491WwSz1VWedS6uZdo5APdAxoZguXHqddPq2In2PSix80WMpEyv78wNIAYKEBvtB
2rHHXbnOGjt5fXokHspPwuM5m9GqdzToNFsPS+fIIBAJTsH+bGPSQHBWCcd95nBAsHCRz5wF
fea54PLQ/T2KxX8/pV6J72Qjvr8NR3HCmf9utTh8pIX+aIvKoy228wxvkWdo1Yci01wNZvpW
ebuvUtU+DNYg1Y+AdEboGdLFQ9zXczjNY+EM1uHEj485ofLj42+Vhiq/JKaaEVh7CdUsbcGO
ceB8wiKr5xN7SMW+jO2+tmn1V2ldRc2EbhaJUPqJAs38MDl0TLZzd7SdP97UMJOStjuw++8c
kP2kanQLJlRrP0zGEpPqOk0bWbVx5JHZGmsbfVSP6UM3q4PfKkmfLwdzdmbcEveMx0ysLYMG
T6jvJeN8JeAGK+Swr5n4S3CcCjScrlmzdLgMRzhp8dDHbA1UjloD0HbBNysEnO5nKDUva0bV
Pvv5ReGLbahVA0oaEkTiFMZhfHaOL/XuGVyFMYM+koPL5DvujCVsOJwKlp49ugPvrSLNeeCt
GsdWkYZ1GkD3Hvg+HU9tTw2JS+k2FBjzXZ74mSegSQXdWWp2WZrKZKCP+QxFkn1YOjSVgqBv
FPiUsQzXQrkC82Hg+Gzf52hbByark+EwqOV/gQf5y/IKZlgs/g0MbA05IxsAAA==

--Qxx1br4bt0+wmkIi--
