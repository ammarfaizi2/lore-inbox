Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932456AbWDOJrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbWDOJrm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 05:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbWDOJrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 05:47:42 -0400
Received: from dd6424.kasserver.com ([83.133.49.41]:48313 "EHLO
	dd6424.kasserver.com") by vger.kernel.org with ESMTP
	id S932456AbWDOJrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 05:47:41 -0400
Message-ID: <4440C137.90901@feuerpokemon.de>
Date: Sat, 15 Apr 2006 11:47:35 +0200
From: dragoran <dragoran@feuerpokemon.de>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: forcedeth broken powermanagement/irq handling ?
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello
I am runnig a 2.6.16.1 kernel on a DFI LP NF4 SLI-DR Expert mobo, which 
has an nvidia chipset with onboard nic. The nic works fine with the 
forcedeth driver, perfomance is ok (good). The system is a x86_64 FC5 
install on a dual core opteron 170 cpu with 2GB (2x1GB in dual channel) 
of Ram installed.
When I suspend the machine using ACPI S3 or swsup and resume it the 
network is dead. I cannot recive an packages. ifdown / ifup does not 
help. Restarting the network using /sbin/service network restart also 
does not get network working. Unloading and loading the driver (modprobe 
-r forcedeth;modprobe forcedeth) has the same result-> dead network.
I have to reboot in order to get the network working again. I have a 
static IP so no dhcp issue.
This makes suspend useles on my box, because I have to reboot anyway to 
get my network working.
What could be causing this? If there is any info that I can provide to 
help fixing this bug tell me.
I also noticed this (don't know if it is related or not but doubt it):
 cat /proc/interrupts
           CPU0       CPU1
  0:     640968     628532    IO-APIC-edge  timer
  1:       4763       4745    IO-APIC-edge  i8042
  8:          0          0    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi
 14:       1552       1082    IO-APIC-edge  ide0
 15:      44443      44261    IO-APIC-edge  ide1
 16:      57625      44633   IO-APIC-level  libata
 17:     972904          0   IO-APIC-level  eth0
...
why does all interupts of eth0 (forcedeth) goes to cpu 0 and never to 1 
? irqbalance is running.
lspci output:
00:00.0 Memory controller: nVidia Corporation CK804 Memory Controller 
(rev a3)
00:01.0 ISA bridge: nVidia Corporation CK804 ISA Bridge (rev a3)
00:01.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)
00:02.0 USB Controller: nVidia Corporation CK804 USB Controller (rev a2)
00:02.1 USB Controller: nVidia Corporation CK804 USB Controller (rev a3)
00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev a2)
00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller 
(rev a3)
00:09.0 PCI bridge: nVidia Corporation CK804 PCI Bridge (rev a2)
00:0a.0 Bridge: nVidia Corporation CK804 Ethernet Controller (rev a3)
00:0b.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
00:0c.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
00:0d.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
00:0e.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
Miscellaneous Control
01:09.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host 
Controller (rev 80)
01:0a.0 Ethernet controller: Marvell Technology Group Ltd. 88E8001 
Gigabit Ethernet Controller (rev 13)
01:0b.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 0a)
01:0b.1 Input device controller: Creative Labs SB Live! MIDI/Game Port 
(rev 0a)
05:00.0 VGA compatible controller: nVidia Corporation GeForce 7800 GTX 
(rev a1)put:
PS: please CC me as a I am not suscriped to this list.
