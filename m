Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265403AbTF1UgV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 16:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265396AbTF1UgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 16:36:21 -0400
Received: from 82-43-130-207.cable.ubr03.mort.blueyonder.co.uk ([82.43.130.207]:18560
	"EHLO efix.biz") by vger.kernel.org with ESMTP id S265406AbTF1Ufl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 16:35:41 -0400
Subject: Linux 2.4.22-pre2 and AthlonMP
From: Edward Tandi <ed@efix.biz>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1056833424.30265.39.camel@wires.home.biz>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 28 Jun 2003 21:50:24 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On the Tyan Tiger board (2460) fitted with two processors, if I use
'noapic' in the lilo boot options I get the following in messages (and
eventually a crash):


Jun 28 17:54:36 machine syslogd 1.4.1: restart.
Jun 28 17:54:36 machine kernel: klogd 1.4.1, log source = /proc/kmsg
started.
Jun 28 17:54:36 machine kernel: Inspecting /boot/System.map
Jun 28 17:54:36 machine partmon: Checking if partitions have enough free
diskspace:
Jun 28 17:54:36 machine kernel:  40(40)
Jun 28 17:54:36 machine kernel: APIC error on CPU1: 40(40)
Jun 28 17:54:36 machine last message repeated 1127 times
Jun 28 17:54:36 machine partmon: ^[[65G[
Jun 28 17:54:36 machine kernel: APIC error on CPU1: 40(40)
Jun 28 17:54:36 machine kernel: APIC error on CPU1: 40(40)
Jun 28 17:54:36 machine partmon:
Jun 28 17:54:36 machine rc: Starting partmon:  succeeded
Jun 28 17:54:36 machine kernel: APIC error on CPU1: 40(40)
Jun 28 17:54:37 machine last message repeated 18 times
Jun 28 17:54:37 machine nfslock: rpc.lockd startup succeeded
Jun 28 17:54:37 machine kernel: APIC error on CPU1: 40(40)
Jun 28 17:54:37 machine last message repeated 5 times
Jun 28 17:54:37 machine rpc.statd[744]: Version 1.0.1 Starting
Jun 28 17:54:37 machine kernel: APIC error on CPU1: 40(40)
Jun 28 17:54:37 machine nfslock: rpc.statd startup succeeded
Jun 28 17:54:37 machine kernel: APIC error on CPU1: 40(40)
Jun 28 17:54:37 machine last message repeated 66 times
...
Jun 28 17:56:12 machine smbd[1925]:   Got SIGHUP
Jun 28 17:56:12 machine kernel: APIC error on CPU1: 40(40)
Jun 28 17:56:43 machine last message repeated 3057 times
Jun 28 17:57:44 machine last message repeated 6149 times
Jun 28 17:58:01 machine last message repeated 1808 times
Jun 28 17:58:01 machine ntpd[1023]: kernel time discipline status change
41
Jun 28 17:58:01 machine kernel: APIC error on CPU1: 40(40)
Jun 28 17:58:32 machine last message repeated 3058 times


The system boots, but hangs shortly thereafter. Removing the noapic
option, I get the following new messages:


Jun 28 18:27:46 machine kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3
5 10 11, enabled at IRQ 9)
Jun 28 18:27:46 machine kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3
*5 10 11)
Jun 28 18:27:46 machine kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3
5 *10 11)
Jun 28 18:27:46 machine kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3
5 10 *11)
Jun 28 18:27:46 machine kernel:     ACPI-0352: *** Error: Looking up
[Z00Q] in namespace, AE_NOT_FOUND
Jun 28 18:27:46 machine kernel: search_node c1596ac0 start_node c1596ac0
return_node 00000000
Jun 28 18:27:46 machine kernel:     ACPI-1121: *** Error: Method
execution failed [\_SB_.PCI0.ISA_.SIO_.COM1._STA] (Node c1596ac0),
AE_NOT_FOUND
Jun 28 18:27:46 machine kernel:     ACPI-0352: *** Error: Looking up
[Z00Q] in namespace, AE_NOT_FOUND
Jun 28 18:27:46 machine kernel: search_node c1596dc0 start_node c1596dc0
return_node 00000000
Jun 28 18:27:46 machine kernel:     ACPI-1121: *** Error: Method
execution failed [\_SB_.PCI0.ISA_.SIO_.COM2._STA] (Node c1596dc0),
AE_NOT_FOUND
Jun 28 18:27:46 machine kernel:     ACPI-0352: *** Error: Looking up
[Z00Q] in namespace, AE_NOT_FOUND
Jun 28 18:27:46 machine kernel: search_node c1594300 start_node c1594300
return_node 00000000
Jun 28 18:27:46 machine kernel:     ACPI-1121: *** Error: Method
execution failed [\_SB_.PCI0.ISA_.SIO_.LPT_._STA] (Node c1594300),
AE_NOT_FOUND
Jun 28 18:27:46 machine kernel: PCI: Probing PCI hardware
Jun 28 18:27:46 machine partmon: ^[[65G[
Jun 28 18:27:46 machine kernel: PCI: Using ACPI for IRQ routing
Jun 28 18:27:46 machine kernel: PCI: if you experience problems, try
using option 'pci=noacpi' or even 'acpi=off'
Jun 28 18:27:46 machine kernel: BIOS failed to enable PCI standards
compliance, fixing this error.


I presume this last set of messages is due to the recent ACPI changes.
If I try booting with the suggested 'pci=noacpi', the machine hangs
during boot before it gets to the SCSI driver. Setting 'acpi=off' gets
rid of the messages and the box appears to run OK.

Ed-T.


