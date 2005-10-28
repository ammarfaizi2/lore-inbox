Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030313AbVJ1TuB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030313AbVJ1TuB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 15:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030325AbVJ1TuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 15:50:00 -0400
Received: from amdext4.amd.com ([163.181.251.6]:62441 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S1030313AbVJ1TuA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 15:50:00 -0400
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: x86_64: calibrate_delay_direct and apic id lift for BSP
Date: Fri, 28 Oct 2005 12:49:06 -0700
Message-ID: <6F7DA19D05F3CF40B890C7CA2DB13A4201E061EC@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: x86_64: calibrate_delay_direct and apic id lift for BSP
Thread-Index: AcXb8PtaKLDe1zmXSoudARECBu7rDQAB2duA
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: "Andi Kleen" <ak@suse.de>
cc: discuss@x86-64.org, linux-kernel@vger.kernel.org, linuxbios@openbios.org
X-OriginalArrivalTime: 28 Oct 2005 19:49:40.0595 (UTC)
 FILETIME=[BC35EC30:01C5DBF8]
X-WSS-ID: 6F7C5F5F35K3323812-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have tried latest code..., except that, it works well.

YH

-----Original Message-----
From: Andi Kleen [mailto:ak@suse.de] 
Sent: Friday, October 28, 2005 11:53 AM
To: Lu, Yinghai
Cc: discuss@x86-64.org; linux-kernel@vger.kernel.org;
linuxbios@openbios.org
Subject: Re: x86_64: calibrate_delay_direct and apic id lift for BSP

On Friday 28 October 2005 20:42, Yinghai Lu wrote:
> andi,
> 
> I tried to lift apic id in LinuxBIOS for all cpus after 0x10.
> 
> When using MB with AMD8111, the jiffies was not moving. So it is
> locked at calibrate_delay_direct...

Have you tried it with 2.6.14? It has some new code to handle
high apic ids better
 
> but  MB with Nvidia ck804, jiffies is moving.

The timer is wired different on nvidia than on 8111. They can
go either through the 8259 or through the IOAPIC.  There is still
some code that falls back to the 8259 if IOAPIC doesn't work,
which may make it appear working on Nvidia.

As a warning I'm about to remove that code so don't rely on it.

> If I don't change BSP apic id ( keep it to 0), It changes....
> 
> I have no idea how the jiffies changes, there is another thread change
it....?

They change when interrupt 0 fires. So it's probably misrouted
or similar.


-Andi


