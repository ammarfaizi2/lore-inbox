Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269820AbUJMUae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269820AbUJMUae (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 16:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269824AbUJMUa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 16:30:29 -0400
Received: from hqemgate00.nvidia.com ([216.228.112.144]:25353 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S269820AbUJMUaN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 16:30:13 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Clock inaccuracy seen on NVIDIA nForce2 systems
Date: Wed, 13 Oct 2004 13:30:11 -0700
Message-ID: <8E5ACAE05E6B9E44A2903C693A5D4E8A01C45AC2@hqemmail02.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Clock inaccuracy seen on NVIDIA nForce2 systems
thread-index: AcSxY3AxDm9gItz6QWeYbmjDUcMDiA==
From: "Andy Currid" <ACurrid@nvidia.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 13 Oct 2004 20:30:11.0839 (UTC) FILETIME=[705F50F0:01C4B163]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Various users on this and other Linux forums have reported inaccuracy
in the Linux system clock when running on NVIDIA nForce2 hardware. This
inaccuracy is often characterized as "clock drift" or "noisiness", such
that the clock gains as much as twenty minutes per week. The problem is
evident when running in IOAPIC mode, with the programmable interval
timer
(PIT) interrupt routed through the IOAPIC. The problem is not evident
when the PIT interrupt is routed through the legacy PIC hardware.

A possible cause of this behavior is a clock synchronization issue that
can arise on some nForce2 systems when interrupts are routed through the
IOAPIC, and Spread Spectrum (SS) clocking is enabled. Under certain
conditions, this can cause the IOAPIC to issue multiple interrupts to
the CPU when it should have issued only one.

If you are experiencing clock inaccuracy on nForce2 hardware, take the
following steps to determine if this issue may be the cause:

1. Determine if the hardware you are using may be affected by this
   problem. The problem is limited to MCP2 and MCP2-T hardware; it does
   not affect MCP2-S or any nForce3 hardware. MCP2 and MCP2-T hardware
   may be identified by the PCI device ID of the ISA bridge, which is
   0x0060 for these devices.

   To read the bridge device ID, use 'lspci -n -s 0:1.0' . The output
   should be of the form '0000:00:01.0 Class 0601: 10de:0060 (rev a3)'.
   The device ID of the bridge in this example is "0060" following the
   NVIDIA PCI vendor ID "10de".

   If your ISA bridge device ID is not 0x0060, then this issue is not
   the cause of any clock inaccuracy you are experiencing.

2. Otherwise, examine the output from 'cat /proc/interrupts'. If IRQ0
   (the timer) is shown to be in PIC mode rather than IOAPIC mode, then
   this issue is not the cause of any clock inaccuracy you are
   experiencing.

3. Otherwise, reboot your system and enter BIOS SETUP. Check if your
   BIOS has a Front Side Bus (FSB) Spread Spectrum (SS) clocking option.
   On many systems, this option is located in the "Advanced Chipset
   Features" menu. If the option is present and enabled, disable it.
   Boot Linux and observe the system clock over several hours to verify
   if this has improved its accuracy.

Regards

Andy
--
Andy Currid, NVIDIA Corporation 
acurrid@nvidia.com
