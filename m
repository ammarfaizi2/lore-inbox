Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbTJ0I40 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 03:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbTJ0I40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 03:56:26 -0500
Received: from fmr05.intel.com ([134.134.136.6]:65231 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S261351AbTJ0I4Y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 03:56:24 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PM][ACPI] No ACPI interrupts after resume from S1
Date: Mon, 27 Oct 2003 16:56:18 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8401720B67@pdsmsx403.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PM][ACPI] No ACPI interrupts after resume from S1
Thread-Index: AcOcCeAVLuBfEU5BRDCRJ8qzwlzWkAAXhl7g
From: "Yu, Luming" <luming.yu@intel.com>
To: "Karol Kozimor" <sziwan@hell.org.pl>
Cc: "Pavel Machek" <pavel@ucw.cz>, "M?ns Rullg?rd" <mru@users.sourceforge.net>,
       <acpi-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 27 Oct 2003 08:56:18.0959 (UTC) FILETIME=[2FD5F9F0:01C39C68]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I made a mistake in using base_number. Would you please have updated patch a try?
Thanks a lot. --Luming


-----Original Message-----
From: Karol Kozimor [mailto:sziwan@hell.org.pl]
Sent: 2003?10?27? 5:41
To: Yu, Luming
Cc: Pavel Machek; M?ns Rullg?rd; acpi-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
Subject: Re: [PM][ACPI] No ACPI interrupts after resume from S1


Thus wrote Yu, Luming:
> Would you please try patch at http://bugme.osdl.org/show_bug.cgi?id=1409

Hi,
The patch makes my kernel oops on resume:
hdc: completing PM  request, resume
  hwregs-0760 [56] hw_low_level_read     : Unsupported address space: 90
  hwregs-0760 [56] hw_low_level_read     : Unsupported address space: A0
  hwregs-0760 [56] hw_low_level_read     : Unsupported address space: 24
  hwregs-0760 [56] hw_low_level_read     : Unsupported address space: C8
  hwregs-0760 [56] hw_low_level_read     : Unsupported address space: E0
  hwregs-0760 [56] hw_low_level_read     : Unsupported address space: F0
  hwregs-0760 [56] hw_low_level_read     : Unsupported address space:  4
Unable to handle kernel paging request at virtual address 70677679
 printing eip:
c020c44c
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c020c44c>]   Not tainted
EFLAGS: 00010206
EIP is at acpi_hw_lowlevel_read+0x30/0x122
eax: c02e6344   ebx: cffd6408   ecx: cfc51e88   edx: 00000010
esi: 70677671   edi: cfc51e90   ebp: 00000008   esp: cfc51e58
ds: 007b   es: 007b   ss: 0068
Process bash (pid: 304, threadinfo=cfc50000 task=c1368a0)
Stack: 00000130 c021c9b8 00000002 c02e6499 c02e6344 c02f6720 cffd6408 cfe3b228
       000001e0 00000001 c020b6b2 00000008 cfc51e90 70677671 c0311650 00000018
       c020b9c2 cffd6408 00000010 00000000 00000000 cfc51ebc c02da521 00000001
Call Trace:
 acpi_ut_acquire_mutex+0xc0/0x16b
 acpi_hw_enable_gpe+0x1e/0x44
 acpi_hw_enable_ec_gpes+0x7f0x85
 acpi_leave_sleep_state+0x119/0x13e
 dpm_resume+0x34/0x5a
 acpi_pm_finish+0xb/0x38
 [...]

Code: 8b 56 08 8b 46 04 89 d1 09 c1 75 0a 31 c0 83 c4 18 5b 5c 5f
[hand typed, but at least the traces should be OK]

Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
