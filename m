Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264085AbUFPQMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264085AbUFPQMn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 12:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263984AbUFPQMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 12:12:43 -0400
Received: from smtp.infonegocio.com ([213.4.129.150]:8338 "EHLO
	telesmtp4.mail.isp") by vger.kernel.org with ESMTP id S264085AbUFPQLX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 12:11:23 -0400
Message-ID: <40D07123.1040701@telefonica.net>
Date: Wed, 16 Jun 2004 18:11:15 +0200
From: Miguelanxo Otero Salgueiro <miguelanxo@telefonica.net>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.7: ehci_hcd prevents system from suspending properly
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just compiled 2.6.7 and found that having ehci_hcd loaded (I've 
compiled it as a module) prevents system from suspending properly. I've 
got this dmesg messages:

PM: Preparing system for suspend
Stopping tasks: 
=======================================================================|
PCI: Setting latency timer of device 0000:00:1d.7 to 64
Could not suspend device 0000:00:1d.7: error -5
PCI: Setting latency timer of device 0000:00:1f.5 to 64
PCI: Setting latency timer of device 0000:00:1f.6 to 64

looks like device 0000:00:1d.7 can't be suspended. From lspci I get this:

0000:00:1d.7 USB Controller: Intel Corp. 82801DB (ICH4) USB2 EHCI 
Controller (rev 03)

If I remove the module (modprobe -r ehci_hcd) the system suspends properly:

PM: Preparing system for suspend
Stopping tasks: 
========================================================================|
PCI: Setting latency timer of device 0000:00:1d.0 to 64
PCI: Setting latency timer of device 0000:00:1d.0 to 64
PCI: Setting latency timer of device 0000:00:1d.7 to 64
PCI: Setting latency timer of device 0000:00:1f.5 to 64
PCI: Setting latency timer of device 0000:00:1f.6 to 64
PM: Entering state.

2.6.6 does suspend properly, as does 2.6.5 and 2.4.26. This
2.6.7 compilation is just a make oldconfig from the 2.6.6 settings I 
have, nothing more, nothing less.

My system: Toshiba A10

root@nemo:/home/miguel# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Mobile Intel(R) Celeron(R) CPU 2.40GHz
stepping        : 9
cpu MHz         : 2394.737
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 4751.36

