Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262582AbUKRC31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262582AbUKRC31 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 21:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262393AbUKRC3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 21:29:00 -0500
Received: from fmr12.intel.com ([134.134.136.15]:39133 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S262543AbUKRB7t convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 20:59:49 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch] Fix GDT re-load on ACPI resume
Date: Thu, 18 Nov 2004 09:59:30 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD3057594611D@pdsmsx402.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] Fix GDT re-load on ACPI resume
Thread-Index: AcTM11hJDU7oWzFPQqWuBjevYgyQkgAOoqog
From: "Li, Shaohua" <shaohua.li@intel.com>
To: "Pavel Machek" <pavel@ucw.cz>
Cc: "Nickolai Zeldovich" <kolya@MIT.EDU>, <linux-kernel@vger.kernel.org>,
       <csapuntz@stanford.edu>, <hiroit@mcn.ne.jp>
X-OriginalArrivalTime: 18 Nov 2004 01:59:33.0839 (UTC) FILETIME=[3FE675F0:01C4CD12]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > 	movw	_0x0e00 + 'i', %fs:(0x12)
>> >
>> > 	# need a gdt
>> >+	.byte	0x66			# force 32-bit operands in case
>> >+					# the GDT is past 16 megabytes
>> > 	lgdt	real_save_gdt - wakeup_code
>> >
>> > 	movl	real_save_cr0 - wakeup_code, %eax
>> There is a patch from hiroit@mcn.ne.jp to fix the GDT issue. You can
try
>> it.
>
>Well, replacing lgdt with lgdtl (above) seems like nicer solution than
>attachment...
Copy GDT to low mem seems safer. Now the GDT table is in per-cpu region,
possibly it's not in low memory. Or am I missing anything?

Shaohua
