Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbUCHHo2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 02:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbUCHHo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 02:44:28 -0500
Received: from fmr06.intel.com ([134.134.136.7]:43974 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S262422AbUCHHoY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 02:44:24 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PATCH] fix PCI interrupt setting for ia64
Date: Mon, 8 Mar 2004 15:44:16 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8401B1A017@PDSMSX403.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] fix PCI interrupt setting for ia64
Thread-Index: AcQE1vfzwKg8SNN1QV+SivHm8tzP3wAAoR7A
From: "Liu, Benjamin" <benjamin.liu@intel.com>
To: "Grant Grundler" <iod00d@hp.com>,
       "Kenji Kaneshige" <kaneshige.kenji@jp.fujitsu.com>
Cc: <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 Mar 2004 07:44:16.0827 (UTC) FILETIME=[2895B8B0:01C404E1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant,

Both ISA and PCI device drivers would call arch/ia64/kernel/irq.c:request_irq()-->arch/ia64/kernel/irq.c:setup_irq() -->arch/ia64/kernel/iosapic.c:iosapic_startup_level_irq() or  arch/ia64/kernel/iosapic.c:iosapic_startup_edge_irq() function to unmask the IRQ. I believe the ISA can be handled gracefully, if any.

ISA is legacy to IA64. The configuration script of 2.4.23 has CONFIG_ISA off explicitly for IA64, 2.6.2 doesn't have this option for IA64. I just wonder whether the legacy probing method still exists on IA64.

Thanks,
Pingping (Benjamin) Liu
Intel China Software Center


>-----Original Message-----
>From: linux-ia64-owner@vger.kernel.org 
>[mailto:linux-ia64-owner@vger.kernel.org] On Behalf Of Grant Grundler
>Sent: 2004Äê3ÔÂ8ÈÕ 14:31
>To: Kenji Kaneshige
>Cc: linux-ia64@vger.kernel.org; linux-kernel@vger.kernel.org
>Subject: Re: [PATCH] fix PCI interrupt setting for ia64
>
>
>On Mon, Mar 08, 2004 at 11:49:10AM +0900, Kenji Kaneshige wrote:
>> In ia64 kernel, IOSAPIC's RTEs for PCI interrupts are unmasked at the
>> boot time before installing device drivers. I think it is 
>very dangerous.
>
>Hi Kenji,
>I think this behavior exists to support "legacy" IRQ probing.
>I'm wondering if it would be sufficient to wrap the patch in
>"#ifndef CONFIG_ISA" or something like that.
>
>grant
>-
>To unsubscribe from this list: send the line "unsubscribe 
>linux-ia64" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
