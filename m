Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262372AbUBYDH3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 22:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbUBYDH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 22:07:29 -0500
Received: from fmr06.intel.com ([134.134.136.7]:59885 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S262372AbUBYDH1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 22:07:27 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: Intel vs AMD x86-64
Date: Tue, 24 Feb 2004 19:07:17 -0800
Message-ID: <7F740D512C7C1046AB53446D37200173EA2716@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Intel vs AMD x86-64
Thread-Index: AcP7MNj7HE8/az3ISS+mvhBZlchwmwAGaPVQ
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 25 Feb 2004 03:07:18.0367 (UTC) FILETIME=[7A40F6F0:01C3FB4C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think we have a bug in the inline function. Actually this behavior is 
consistent with the IA-32, which says "if the contents source operand
are 0, 
the contents of the destination operand is undefined." So the code in
32-bit 
also has a bug there. Today it is set to zero fortunately, and the code 
happens to be working.

Jun

>-----Original Message-----
>From: ak@suse.de [mailto:ak@suse.de]
>Sent: Tuesday, February 24, 2004 3:49 PM
>To: Nakajima, Jun
>Cc: linux-kernel@vger.kernel.org
>Subject: Re: Intel vs AMD x86-64
>
>"Nakajima, Jun" <jun.nakajima@intel.com> writes:
>
>> Other than the standard IA-32 differences (eg. HT, SSE3, Intel
Enhanced
>> SpeedStep, etc.), there are few differences between the
implementations
>> of
>> IA-32e and AMD64. The software visible ones are:
>
>Thanks for the detailed list.
>
>> BSF/BSR when source is 0 & operand size is 32:
>>   In 64-bit mode, the processor sets ZF, and the upper 32 bits of
>>   the destination are undefined. Should always check the ZF or do not
>> use
>>   32-bit operand size.
>
>This one sounds a bit scary. I think it could hurt the
>asm-x86_64/bitops.h:find_first_zero_bit if there is a race that
>changes the value in memory between the last scasl and the bsfl
>and the inliner assumes the edx output argument is zero extended.
>Hopefully that case should be unlikely enough. I guess best would
>be to change the function to use 64bit accesses to avoid this
completely.
>
>-Andi
