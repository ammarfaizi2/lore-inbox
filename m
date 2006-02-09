Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422759AbWBIB3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422759AbWBIB3Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 20:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422760AbWBIB3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 20:29:25 -0500
Received: from fmr17.intel.com ([134.134.136.16]:64899 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1422759AbWBIB3Y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 20:29:24 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: EC interrupt mode by default breaks power button and lid button
Date: Thu, 9 Feb 2006 09:29:16 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840AE28A07@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: EC interrupt mode by default breaks power button and lid button
thread-index: AcYr8Bawd64bHHWbRiOHNX+5gkOj7ABJ4ijw
From: "Yu, Luming" <luming.yu@intel.com>
To: "Gerhard Schrenk" <deb.gschrenk@gmx.de>
Cc: "Brown, Len" <len.brown@intel.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 09 Feb 2006 01:29:18.0400 (UTC) FILETIME=[3EE07400:01C62D18]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's interesting. Could you file a bug in ACPI category on
bugzilla.kernel.org?
I don't want it be lost, because it's so interesting.

BTW, does battery work?

Thanks,
Luming

>
>* Yu, Luming <luming.yu@intel.com> [2006-02-07 13:33]:
>> >> Please don't revert that patch, and test kernel parameter 
>ec_intr=0
>> >
>> >Yes, boot option ec_initr=0 helps power/lid buttons. (Tested with
>> >yesterdays newest kernel from linus' tree.)
>> 
>> Any difference with ec_initr=1 with this kernel ?
>
>No. Neither powerbutton nor lidbutton works with ec_initr=1.
>
>> If pressing power button, can you see acpi interrupt increases?
>
>Where do I find this? Do you mean interrupt 9 "IO-APIC-edge  acpi" in
>/proc/interrupts?
>
>With ec_initr=1 I don't see that interrupt 9 increases. 
>
>--- tmp/ec1/interrupts	2006-02-07 14:31:54.000000000 +0100
>+++ tmp/ec1/interrupts-after-powerbutton	2006-02-07 
>14:33:07.000000000 +0100
>@@ -1,10 +1,10 @@
>            CPU0       
>-  0:      42181    IO-APIC-edge  timer
>-  1:        446    IO-APIC-edge  i8042
>+  0:      60423    IO-APIC-edge  timer
>+  1:        676    IO-APIC-edge  i8042
>   2:          0          XT-PIC  cascade
>   9:          1    IO-APIC-edge  acpi
>- 12:       2177    IO-APIC-edge  i8042
>- 14:       6494    IO-APIC-edge  ide0
>+ 12:       3221    IO-APIC-edge  i8042
>+ 14:       6547    IO-APIC-edge  ide0
>  16:          0   IO-APIC-level  uhci_hcd:usb5, i915@pci:0000:00:02.0
>  17:          1   IO-APIC-level  Intel ICH6, ipw2200
>  18:          0   IO-APIC-level  uhci_hcd:usb4
>@@ -12,6 +12,6 @@
>  20:          0   IO-APIC-level  yenta, Intel ICH6 Modem
>  23:          0   IO-APIC-level  ehci_hcd:usb1, uhci_hcd:usb2
> NMI:          0 
>-LOC:      42140 
>+LOC:      60383 
> ERR:          0
> MIS:          0
>
>
>With ec_initr=1 /proc/acpi/button/lid/LID0/state seems to work sane:
>
>gps@medusa:~$ cat /proc/acpi/button/lid/LID0/state # lid opened
>state:      open
>gps@medusa:~$ sleep 5 && cat /proc/acpi/button/lid/LID0/state 
># closing lid quicker than 5 seconds
>state:      closed
>
>With ec_initr=0 (and acpid *stopped*) I see interrupt 9 increases.
>
>--- tmp/ec0/acpid-off/interrupts	2006-02-07 
>14:40:55.000000000 +0100
>+++ tmp/ec0/acpid-off/interrupts-after-powerbutton	
>2006-02-07 14:42:13.000000000 +0100
>@@ -1,10 +1,10 @@
>            CPU0       
>-  0:      27910    IO-APIC-edge  timer
>-  1:        375    IO-APIC-edge  i8042
>+  0:      47228    IO-APIC-edge  timer
>+  1:        599    IO-APIC-edge  i8042
>   2:          0          XT-PIC  cascade
>-  9:         27    IO-APIC-edge  acpi
>- 12:        755    IO-APIC-edge  i8042
>- 14:       6259    IO-APIC-edge  ide0
>+  9:         28    IO-APIC-edge  acpi
>+ 12:       2105    IO-APIC-edge  i8042
>+ 14:       6465    IO-APIC-edge  ide0
>  16:          0   IO-APIC-level  uhci_hcd:usb5, i915@pci:0000:00:02.0
>  17:          1   IO-APIC-level  Intel ICH6, ipw2200
>  18:          0   IO-APIC-level  uhci_hcd:usb4
>@@ -12,6 +12,6 @@
>  20:          0   IO-APIC-level  yenta, Intel ICH6 Modem
>  23:          0   IO-APIC-level  ehci_hcd:usb1, uhci_hcd:usb2
> NMI:          0 
>-LOC:      27872 
>+LOC:      47191 
> ERR:          0
> MIS:          0
>
>With ec_initr=0 and acpid *started* I see this change in /var/log/acpid
>
>--- tmp/ec0/acpid-after-boot	2006-02-07 14:20:21.000000000 +0100
>+++ tmp/ec0/acpid-after-powerbutton-and-lid-switch	
>2006-02-07 15:01:50.000000000 +0100
>@@ -327,3 +327,20 @@
> [Tue Feb  7 14:13:41 2006] exiting
> [Tue Feb  7 14:18:44 2006] starting up
> [Tue Feb  7 14:18:44 2006] 8 rules loaded
>+[Tue Feb  7 14:20:25 2006] received event "button/power PWRF 
>00000080 00000001"
>+[Tue Feb  7 14:20:25 2006] executing action 
>"/etc/acpi/actions/my_powerbtn.sh"
>+[Tue Feb  7 14:20:25 2006] BEGIN HANDLER MESSAGES
>+[Tue Feb  7 14:20:37 2006] END HANDLER MESSAGES
>+[Tue Feb  7 14:20:37 2006] action exited with status 0
>+[Tue Feb  7 14:20:37 2006] completed event "button/power PWRF 
>00000080 00000001"
>+[Tue Feb  7 14:23:20 2006] received event "button/lid LID0 
>00000080 00000001"
>+[Tue Feb  7 14:23:20 2006] executing action 
>"/etc/acpi/actions/lm_lid.sh button/lid LID0 00000080 00000001"
>+[Tue Feb  7 14:23:20 2006] BEGIN HANDLER MESSAGES
>+[Tue Feb  7 14:23:20 2006] END HANDLER MESSAGES
>+[Tue Feb  7 14:23:20 2006] action exited with status 0
>+[Tue Feb  7 14:23:20 2006] executing action 
>"/etc/acpi/actions/my_lid.sh button/lid LID0 00000080 00000001"
>+[Tue Feb  7 14:23:20 2006] BEGIN HANDLER MESSAGES
>+[Tue Feb  7 14:24:27 2006] END HANDLER MESSAGES
>+[Tue Feb  7 14:24:27 2006] action exited with status 0
>+[Tue Feb  7 14:24:27 2006] completed event "button/lid LID0 
>00000080 00000001"
>
>Hope this helps
>-- Gerhard
>
