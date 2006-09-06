Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751472AbWIFTOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbWIFTOi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 15:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbWIFTOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 15:14:38 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:48019 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751472AbWIFTOh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 15:14:37 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: 2.6.18-rc5-mm1: strange /proc/interrupts contents on HPC nx6325
Date: Wed, 6 Sep 2006 21:17:30 +0200
User-Agent: KMail/1.9.1
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609062117.31125.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[I'm not quite sure who should be on the Cc list.]

The contents of /proc/interrupts look strange on the HPC nx6325 I'm currently using
(2.6.18-rc5-mm1, 64-bit kernel):

           CPU0       CPU1       
  0:      18073          0    <NULL>-edge     timer
  1:        163          0   IO-APIC-edge     i8042
  8:          0          0   IO-APIC-edge     rtc
  9:        120          0   IO-APIC-fasteoi  acpi
 12:        149          0   IO-APIC-edge     i8042
 14:         24          0   IO-APIC-edge     ide0
 16:       4796          0   IO-APIC-fasteoi  libata
 19:         75          0   IO-APIC-fasteoi  ehci_hcd:usb1, ohci_hcd:usb2, ohci_hcd:usb3
 20:          7          0   IO-APIC-fasteoi  yenta, ohci1394, sdhci:slot0
 23:        672          0   IO-APIC-fasteoi  eth0
4348:        188          0   PCI-MSI-<NULL>  HDA Intel
NMI:         89         59 
LOC:      18036      18171 
ERR:          0

Still, the timer and the sound card seem to work in spite of the NULLs.

On 2.6.18-rc6 /proc/interrupts looks saner to me:

           CPU0       CPU1       
  0:     489283          0  local-APIC-edge  timer
  1:       2596          0    IO-APIC-edge  i8042
  8:          0          0    IO-APIC-edge  rtc
 12:        148          0    IO-APIC-edge  i8042
 14:      17261          0    IO-APIC-edge  ide0
169:       5147          0   IO-APIC-level  acpi
177:          4          0   IO-APIC-level  sdhci:slot0, yenta, ohci1394
217:      82575          0   IO-APIC-level  libata, HDA Intel
225:      29230          0   IO-APIC-level  ehci_hcd:usb1, ohci_hcd:usb2, ohci_hcd:usb3
233:      37655          0   IO-APIC-level  eth0
NMI:        674       1052 
LOC:     489293     489595 
ERR:          1
MIS:          0

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
