Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262469AbTIELgb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 07:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262472AbTIELgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 07:36:31 -0400
Received: from mta05-svc.ntlworld.com ([62.253.162.45]:43224 "EHLO
	mta05-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S262469AbTIELgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 07:36:19 -0400
From: Robert Davies <rob_davies@ntlworld.com>
To: linux-kernel@vger.kernel.org
Subject: Regression?  2.6.0-test4{,-mm5} SMP interrupt distribution according to /proc/interrupts
Date: Fri, 5 Sep 2003 12:36:16 +0100
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309051236.17259.rob_davies@ntlworld.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please personally Cc: to me, for any additional information or responses to 
this post, I am not subscribed to kernel list.

Hardware is dual Athlon-MP, AMD762 chipset for most part 2.6.0-test has 
performed well for me.  I've noticed however according to /proc/interrupts, 
CPU0 is getting all the interrupt service action (like when noapic is set), 
is this expected?

516rob@ash$ cat proc_interrupts-2.6.0-test4-mm5
+ uname -a
Linux oak 2.6.0-test4-mm5 #2 SMP Thu Sep 4 18:13:52 BST 2003 i686 AMD 
Athlon(tm) MP 2000+ AuthenticAMD GNU/Linux
+ cat /proc/interrupts
           CPU0       CPU1
  0:     354719         93    IO-APIC-edge  timer
  1:        457          1    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  8:         52          1    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi
 12:      20562          1    IO-APIC-edge  i8042
 14:       6053          1    IO-APIC-edge  ide0
 16:       7689          1   IO-APIC-level  ide2
 17:        203          1   IO-APIC-level  eth0, mga@PCI:1:5:0
 18:       2270          0   IO-APIC-level  EMU10K1
 19:          0          0   IO-APIC-level  ohci-hcd
NMI:          0          0
LOC:     354664     354663
ERR:          0
MIS:          0

The CPU1 numbers don't seem to change, except 0: and LOC:.  I have ACPI active 
in both Gentoo with vanilla 2.6.0-test, 2.6.0-test-mm5 and 2.4.22, and also 
under SuSE with their  2.4.20 kernel, 2.4 and 2.6 are consistent.

/proc/cmdline shows root=/dev/hde5 reboot=warm, using acpi=off option makes no 
change in 2.6.

Under 2.4 kernels the interrupts are distributed :

515rob@ash$ cat proc_interrupts-2.4*
           CPU0       CPU1
  0:      25148     137206    IO-APIC-edge  timer
  1:          6       1076    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:         65        153    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi
 14:       6619      22404    IO-APIC-edge  ide0
 16:         12        373   IO-APIC-level  ide2
 17:     192602      49262   IO-APIC-level  eth0, eth1
 18:          0          0   IO-APIC-level  EMU10K1
 19:          0          0   IO-APIC-level  usb-ohci
NMI:          0          0
LOC:     162293     162274
ERR:          0
MIS:          0
           CPU0       CPU1
  0:      70700      62464    IO-APIC-edge  timer
  1:       2210       2328    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:         92         91    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi
 14:       2652        934    IO-APIC-edge  ide0
 16:       8964       8723   IO-APIC-level  ide2
 17:       1057       1048   IO-APIC-level  eth0
NMI:          0          0
LOC:     133097     133096
ERR:          0
MIS:          0

Regards Rob

