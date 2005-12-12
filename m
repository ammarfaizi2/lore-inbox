Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbVLLHHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbVLLHHE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 02:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbVLLHHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 02:07:04 -0500
Received: from fmr20.intel.com ([134.134.136.19]:38108 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751092AbVLLHHC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 02:07:02 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8BIT
Subject: RE: [BUG] Variable stopmachine_state should be volatile
Date: Mon, 12 Dec 2005 15:06:50 +0800
Message-ID: <8126E4F969BA254AB43EA03C59F44E84042C56D5@pdsmsx404>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BUG] Variable stopmachine_state should be volatile
Thread-Index: AcX3FyKnyRKZ1LJdR+WciiNOD370YgEf3qogACRx4pAADRGN4A==
From: "Zhang, Yanmin" <yanmin.zhang@intel.com>
To: "Luck, Tony" <tony.luck@intel.com>,
       "Arjan van de Ven" <arjan@infradead.org>, "Pavel Machek" <pavel@ucw.cz>
Cc: <linux-kernel@vger.kernel.org>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       "Shah, Rajesh" <rajesh.shah@intel.com>, <linux-ia64@vger.kernel.org>
X-OriginalArrivalTime: 12 Dec 2005 07:06:52.0550 (UTC) FILETIME=[A0EB3A60:01C5FEEA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>-----Original Message-----
>>From: linux-ia64-owner@vger.kernel.org
>>[mailto:linux-ia64-owner@vger.kernel.org] On Behalf Of Luck, Tony
>>Sent: 2005Äê12ÔÂ9ÈÕ 2:53
>>To: Zhang, Yanmin; Arjan van de Ven; Pavel Machek
>>Cc: linux-kernel@vger.kernel.org; Pallipadi, Venkatesh; Shah, Rajesh;
>>linux-ia64@vger.kernel.org
>>Subject: RE: [BUG] Variable stopmachine_state should be volatile
>>
>>> The right approach is to define ia64_hint to ia64_barrier in file
>>> include/asm-ia64/intel_intrin.h. I tested the new approach and it
>>> does work.
>>
>>Does that get you a "hint@pause" instruction inside the loop?  If not, then
>>it isn't all the way to the "right" approach.

Tony,

The approach just fixes compiler scheduling barrier problem of cpu_relax, and there is no hint@pause inside the loop.

Today I tried the latest icc, 9.0.027. It provides __hint, a new intrinsic, to support hint@pause. __hint also has the meaning of compiler scheduling barrier. So the best solution is to use __hint(0). The disassembled result showed the new intrinsic did work.

