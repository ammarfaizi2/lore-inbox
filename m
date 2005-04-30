Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261379AbVD3Tkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbVD3Tkp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 15:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbVD3Tkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 15:40:45 -0400
Received: from usbb-lacimss3.unisys.com ([192.63.108.53]:33809 "EHLO
	usbb-lacimss3.unisys.com") by vger.kernel.org with ESMTP
	id S261379AbVD3Tki convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 15:40:38 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC][PATCH] i386 x86-64 Eliminate Local APIC timer interrupt
Date: Sat, 30 Apr 2005 14:40:18 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04B3C@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC][PATCH] i386 x86-64 Eliminate Local APIC timer interrupt
Thread-Index: AcVNIhaYl6CXroAzQxa3TZpQchPclQAiFOBw
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Zwane Mwaikambo" <zwane@arm.linux.org.uk>,
       "Venkatesh Pallipadi" <venkatesh.pallipadi@intel.com>
Cc: "Andrew Morton" <akpm@osdl.org>, "Linus Torvalds" <torvalds@osdl.org>,
       <mingo@elte.hu>, "linux-kernel" <linux-kernel@vger.kernel.org>,
       "Rajesh Shah" <rajesh.shah@intel.com>,
       "John Stultz" <johnstul@us.ibm.com>, "Andi Kleen" <ak@suse.de>,
       "Asit K Mallick" <asit.k.mallick@intel.com>
X-OriginalArrivalTime: 30 Apr 2005 19:40:19.0111 (UTC) FILETIME=[70C58370:01C54DBC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 29 Apr 2005, Venkatesh Pallipadi wrote:
> 
> > Proposed Fix: 
> > Attached is a prototype patch, that tries to eliminate the 
> dependency 
> > on local APIC timer for update_process_times(). The patch 
> gets rid of 
> > Local APIC timer altogether. We use the timer interrupt (IRQ 0) 
> > configured in broadcast mode in IOAPIC instead (Doesn't 
> work with 8259).
> > As changing anything related to basic timer interrupt is a 
> little bit 
> > risky, I have a boot parameter currently ("useapictimer") to switch 
> > back to original local APIC timer way of doing things.
> 
> I'm rather reluctant to advocate the broadcast scheme as i 
> can see it breaking on a lot of systems, e.g. SMP systems 
> which use i8259 (as you noted), IBM x440 and ES7000. If 
> anything the default mode should be APIC timer and have a 
> parameter to disable it. Regarding things like variable timer 
> ticks, reprogramming the PIT is slow, and using it 
> extensively for such sounds like a step in the wrong 
> direction. Is this feature/bug going to proliferate amongst 
> newer processor local APICs?
> 
> Thanks,
> 	Zwane

I did preliminary testing of the patch applied to the rc3 on the IA-32
ES7000, and it booted fine, without the useapictimer boot option. As
Zwane pointed out correctly, ES7000 doesn't handle IRQ broadcast. The
kernel by-passed the non-apic timer option (chose pin1 in check_timer)
and came up safely with local APIC timer.
Thanks,
--Natalie
