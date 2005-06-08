Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbVFHWzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbVFHWzU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 18:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbVFHWzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 18:55:20 -0400
Received: from fmr15.intel.com ([192.55.52.69]:7362 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S261261AbVFHWzI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 18:55:08 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: Dell BIOS and HPET timer support
Date: Wed, 8 Jun 2005 15:55:29 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB6004EBD1B0@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Dell BIOS and HPET timer support
Thread-Index: AcVsZtiwRBHLIFSLT+6RJjI3cUT+8QAFK5uQ
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Jon Smirl" <jonsmirl@gmail.com>, "lkml" <linux-kernel@vger.kernel.org>
Cc: "Bob Picco" <Robert.Picco@hp.com>
X-OriginalArrivalTime: 08 Jun 2005 22:54:52.0887 (UTC) FILETIME=[14FE9E70:01C56C7D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


HPET timer will be useful for different purposes:
1) Kernel uses it for timer interrupt and time source (gettimeofday).
Kernel will use one particular timer among available HPET timers
(typically 3).
2) The HPET driver exports the HPET device in /dev which can be used by
other kernel drivers or user programs.

In this particular case, with forcing of HPET, (1) above seems to be
working fine.
But, (2) is printing 0ns. Probably because missing HPET information in
ACPI. You may need to do some more changes in drivers/char/hpet.c in
case BIOS doesn not support HPET.

But, this will not affect normal kernel functioning. This will only
affect is someone wants to use /dev/hpet interface.

Thanks,
Venki


>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Jon Smirl
>Sent: Wednesday, June 08, 2005 1:12 PM
>To: lkml
>Subject: Dell BIOS and HPET timer support
>
>After several communications with Dell support I have determined that
>most Dell BIOSs don't include the ACPI entry for the HPET timer. The
>official reason for this is that no version of Windows uses the HPET
>and adding the ACPI entry might cause compatibility problems.
>
>So I added this to force the HPET on:
>   extern unsigned long hpet_address;
>   hpet_address = 0xfed00000ULL;
>
>Now my HPET seems to be working:
>hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
>hpet0: 0ns tick, 3 64-bit timers
>Using HPET for base-timer
>Using HPET for gettimeofday
>
>What does the 0ns tick mean, is this bad? Is there any way to verify
>my HPET is working correctly? My date/time is advancing.
>
>If my HPET is working correctly is it ok to add a probe to 
>find the timer?
>
>-- 
>Jon Smirl
>jonsmirl@gmail.com
>-
>To unsubscribe from this list: send the line "unsubscribe 
>linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
