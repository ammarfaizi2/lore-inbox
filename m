Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265916AbUKAOm6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265916AbUKAOm6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 09:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265913AbUKAOm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 09:42:58 -0500
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:45716 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S266468AbUKAO2p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 09:28:45 -0500
X-Ironport-AV: i="3.86,113,1096866000"; 
   d="scan'208"; a="119909328:sNHT2018038472"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6527.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [BUG][2.6.8.1] serial driver hangs SMP kernel, but not the UP kernel
Date: Mon, 1 Nov 2004 08:28:35 -0600
Message-ID: <4B0A1C17AA88F94289B0704CFABEF1AB0B4CC7@ausx2kmps304.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BUG][2.6.8.1] serial driver hangs SMP kernel, but not the UP kernel
Thread-Index: AcS+mej7vFxr1xu+S3+h/fqjm2e/6ABgqpAQ
From: <Tim_T_Murphy@Dell.com>
To: <rmk+lkml@arm.linux.org.uk>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 01 Nov 2004 14:28:36.0898 (UTC) FILETIME=[13074820:01C4C01F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok, could you check whether this patch automatically detects 
> the serial port please?

Yes, other than fixing a couple typos: 
	uart_offest -> uart_offset
	PCI_ID_ANY -> PCI_ANY_ID
I now get ttyS4 in my /proc/tty/driver/serial output, on bootup:

serinfo:1.0 driver revision:
0: uart:16550A port:000003F8 irq:4 tx:22 rx:0 RI
1: uart:16550A port:000002F8 irq:3 tx:22 rx:0 RI
2: uart:unknown port:000003E8 irq:4
3: uart:unknown port:000002E8 irq:3
4: uart:16550A port:0000EC40 irq:201 tx:0 rx:0 CTS|DSR|CD
5: uart:unknown port:00000000 irq:0
6: uart:unknown port:00000000 irq:0
7: uart:unknown port:00000000 irq:0

Also: the removal of "low_latency" does avoid the hang with the SMP
kernel; I am removing this setting from our service startup script.  In
addition, I will be changing the script to only perform the setserial
commands against an unused tty if it cannot first identify a tty that
already describes our virtual uart (ala Russell's 8250_pci fix).

Thanks to all who replied, much appreciated!
Tim
