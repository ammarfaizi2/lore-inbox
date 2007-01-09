Return-Path: <linux-kernel-owner+w=401wt.eu-S932444AbXAIWP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbXAIWP3 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 17:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbXAIWP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 17:15:28 -0500
Received: from outbound-cpk.frontbridge.com ([207.46.163.16]:11844 "EHLO
	outbound2-cpk-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932444AbXAIWP1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 17:15:27 -0500
X-BigFish: VP
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [PATCH 4/4] x86_64 ioapic: Improve the heuristics for when
 check_timer fails.
Date: Tue, 9 Jan 2007 14:15:15 -0800
Message-ID: <5986589C150B2F49A46483AC44C7BCA4907376@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 4/4] x86_64 ioapic: Improve the heuristics for when
 check_timer fails.
Thread-Index: Acc0OaalLGLgN07BQpqhd3cKQl7NnAAALBrA
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: "Tobias Diedrich" <ranma+kernel@tdiedrich.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>
cc: "Linus Torvalds" <torvalds@osdl.org>, "Andrew Morton" <akpm@osdl.org>,
       "Adrian Bunk" <bunk@stusta.de>, "Andi Kleen" <ak@suse.de>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 09 Jan 2007 22:15:16.0415 (UTC)
 FILETIME=[A418C4F0:01C7343B]
X-WSS-ID: 69BACC7E1WC4247072-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: Tobias Diedrich [mailto:ranma+kernel@tdiedrich.de] 
Sent: Tuesday, January 09, 2007 2:01 PM
To: Eric W. Biederman
Cc: Linus Torvalds; Lu, Yinghai; Andrew Morton; Adrian Bunk; Andi Kleen;
Linux Kernel Mailing List
Subject: Re: [PATCH 4/4] x86_64 ioapic: Improve the heuristics for when
check_timer fails.


>Works fine with BIOS 0402.

>x86_64_io_apic_fix_eric_20060108

>..TIMER: vector=0x20 apic1=0 pin1=0 apic2=-1 pin2=-1
>..TIMER trying IO-APIC=0 PIN=0<3> .. failed
>...apic 0 pin  2n use by irq 2
>..MP-BIOS bug: 8254 timer not connected to IO-APIC
>...trying to set up timer (IRQ0) through the 8259A ...
>...ExtINT trying IO-APIC=0 PIN=0 .. success
>Using local APIC timer interrupts.

Tobias,

Can you post whole log for my patch?

I assume 8254 on apic0/pin2 with INT should work.

YH

--- dmesg-20070108-2.6.20-rc4-bios-0402	2007-01-08 01:51:57.000000000
+0100
+++ dmesg-20070108-2.6.20-rc4-bios-0609	2007-01-08 01:52:05.000000000
+0100

- IO-APIC (apicid-pin) 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23
not connected.
-..TIMER: vector=0x20 apic1=0 pin1=0 apic2=-1 pin2=-1
-..TIMER: trying IO-APIC=0 PIN=0 with 8259 IRQ0 disabled<3> .. failed
-..TIMER: trying IO-APIC=0 PIN=2 fallback with 8259 IRQ0
disabled<6>Using local APIC timer interrupts.
-result 12559465
+ IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22,
2-23 not connected.
+..TIMER: vector=0x20 apic1=0 pin1=2 apic2=-1 pin2=-1
+..TIMER: trying IO-APIC=0 PIN=2 with 8259 IRQ0 disabled<6>Using local
APIC timer interrupts.
+result 12559463


