Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbUCBXWS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 18:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbUCBXWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 18:22:18 -0500
Received: from fmr09.intel.com ([192.52.57.35]:25744 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S261274AbUCBXWL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 18:22:11 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: Intel vs AMD x86-64
Date: Tue, 2 Mar 2004 15:22:05 -0800
Message-ID: <7F740D512C7C1046AB53446D37200173EA2F06@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Intel vs AMD x86-64
Thread-Index: AcP62b+YNygft82KT92E/c3K4V11cAAUNEzQAV5olwA=
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 02 Mar 2004 23:22:06.0228 (UTC) FILETIME=[2D486D40:01C400AD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: Nakajima, Jun
>Sent: Tuesday, February 24, 2004 3:15 PM
>To: 'Pavel Machek'
>Cc: Linus Torvalds; Adrian Bunk; Herbert Poetzl; Mikael Pettersson;
Kernel
>Mailing List
>Subject: RE: Intel vs AMD x86-64
...
>Other than the standard IA-32 differences (eg. HT, SSE3, Intel Enhanced
>SpeedStep, etc.), there are few differences between the implementations
of
>IA-32e and AMD64. The software visible ones are:

Clarification to the BSF/BSR behavior when source is 0.

IA-32e inherits the existing behavior, which is "if the contents source
operand are 0, the contents of the destination operand is undefined."
One needs to check the ZF to detect such a condition. The defined
behavior for 64-bit mode is consistent with the one for 32-bit mode,
i.e. if the operand size is 64-bit, the whole destination is undefined
if the contents source operand are 0.

>BSF/BSR when source is 0 & operand size is 32:
>  In 64-bit mode, the processor sets ZF, and the upper 32 bits of
>  the destination are undefined. Should always check the ZF or do not
use
>  32-bit operand size.
>

So in this case, the lower 32 bits of the destination are undefined as
well, thus, the whole destination is undefined.

The advice is: Always check the ZF. You can use BSF/BSR with the 32-bit
operand size as long as you check the ZF. 

Jun

