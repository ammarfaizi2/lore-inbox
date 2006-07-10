Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422764AbWGJSsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422764AbWGJSsE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 14:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422766AbWGJSsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 14:48:04 -0400
Received: from mga03.intel.com ([143.182.124.21]:61264 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1422764AbWGJSsB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 14:48:01 -0400
X-IronPort-AV: i="4.06,221,1149490800"; 
   d="scan'208"; a="63796282:sNHT5068477589"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Subject: RE: [linux-pm] [BUG] sleeping function called from invalid context during resume
Date: Mon, 10 Jul 2006 14:44:22 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6ED003F@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [linux-pm] [BUG] sleeping function called from invalid context during resume
Thread-Index: AcakNzIaEt8gxdPFTdCuRgv7/pvyDAAGRYCQ
From: "Brown, Len" <len.brown@intel.com>
To: "Alan Stern" <stern@rowland.harvard.edu>
Cc: "Pavel Machek" <pavel@ucw.cz>, "Andrew Morton" <akpm@osdl.org>,
       <johnstul@us.ibm.com>, <linux-pm@lists.osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 10 Jul 2006 18:44:24.0584 (UTC) FILETIME=[DD6C5080:01C6A450]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
>> ACPI: acpi_os_allocate() fixes
>> 
>> Replace acpi_in_resume with a more general hack
>> to check irqs_disabled() on any kmalloc() from ACPI.
>> While setting (system_state != SYSTEM_RUNNING) on resume
>> seemed more general, Andrew Morton preferred this approach.
>> 
>> http://bugzilla.kernel.org/show_bug.cgi?id=3469
>> 
>> Make acpi_os_allocate() into an inline function to
>> allow /proc/slab_allocators to work.
>
>Another problem with this patch; it doesn't compile.
>
>Along with the other changes to 
>include/acpi/platform/aclinux.h, you need 
>to define acpi_size.  The easiest way is to #include 
><acpi/actypes.h> and then remove the unneeded definitions of
acpi_cpu_flags and 
>acpi_thread_id.

oops, looks like I e-mailed and attached a diff that was
from before I built and tested.  The version in git
has one line different -- includes actypes.h as you suggest.
I've updated the attachment in the bug report above to match git.

note that the definitions of acpi_cpu_flags
and acpi_thread_id are not un-needed.  Indeed,
they must occur in aclinux.h above where actypes.h
is included or the ACPICA defaults would be used
and that would break the Linux build.

thanks,
-Len
