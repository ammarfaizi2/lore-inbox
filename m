Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751074AbWHVTIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbWHVTIx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 15:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbWHVTIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 15:08:53 -0400
Received: from mga01.intel.com ([192.55.52.88]:4964 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751049AbWHVTIw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 15:08:52 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,156,1154934000"; 
   d="scan'208"; a="119706042:sNHT38521518196"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.18-rc4-mm2
Date: Tue, 22 Aug 2006 12:07:51 -0700
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A4CE6E90@orsmsx415.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.18-rc4-mm2
Thread-Index: AcbGHRq5XbBR02HsSZ+/k6Awk9nZiAAAG8yA
From: "Moore, Robert" <robert.moore@intel.com>
To: "Grant Wilson" <grant.wilson@zen.co.uk>, "Len Brown" <lenb@kernel.org>
Cc: "Maciej Rutecki" <maciej.rutecki@gmail.com>,
       "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 22 Aug 2006 19:07:51.0765 (UTC) FILETIME=[43EE5850:01C6C61E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If the status returned by the user function called from
acpi_walk_resources returns non-zero status, this status is returned
immediately.

I would guess that this is the origin of the unknown exception.
Bob

> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Grant Wilson
> Sent: Tuesday, August 22, 2006 11:59 AM
> To: Len Brown
> Cc: Maciej Rutecki; Andrew Morton; linux-kernel@vger.kernel.org;
linux-
> acpi@vger.kernel.org
> Subject: Re: 2.6.18-rc4-mm2
> 
> On Mon, Aug 21, 2006 at 07:22:09PM -0400, Len Brown wrote:
> > Please dump the stack so we can find the secretive caller to
> > acpi_format_exception().
> 
> I get three of these when booting and the output from dump_stack
> is the same for each.  I've observed no problems as a result of
> these reported failures.  Here is the output from the first call
> of dump_stack:
> 
> Aug 22 19:39:33 tlg kernel: ACPI Error (utglobal-0125): Unknown
exception
> code: 0xFFFFFFEA [20060707]
> Aug 22 19:39:33 tlg kernel:
> Aug 22 19:39:33 tlg kernel: Call Trace:
> Aug 22 19:39:33 tlg kernel:  [<ffffffff80267cb8>]
dump_trace+0xba/0x39e
> Aug 22 19:39:33 tlg kernel:  [<ffffffff80267fd8>] show_trace+0x3c/0x52
> Aug 22 19:39:33 tlg kernel:  [<ffffffff80268003>] dump_stack+0x15/0x17
> Aug 22 19:39:33 tlg kernel:  [<ffffffff803c8d10>]
> acpi_format_exception+0xc0/0xcb
> Aug 22 19:39:33 tlg kernel:  [<ffffffff803c54e5>]
> acpi_ut_status_exit+0x38/0x73
> Aug 22 19:39:33 tlg kernel:  [<ffffffff803c11a0>]
> acpi_walk_resources+0x12e/0x140
> Aug 22 19:39:33 tlg kernel:  [<ffffffff803d85e5>]
> acpi_motherboard_add+0x26/0x32
> Aug 22 19:39:33 tlg kernel:  [<ffffffff803d73d7>]
> acpi_bus_driver_init+0x3a/0x98
> Aug 22 19:39:33 tlg kernel:  [<ffffffff803d796c>]
> acpi_bus_register_driver+0xbd/0x144
> Aug 22 19:39:33 tlg kernel:  [<ffffffff807dcbd4>]
> acpi_motherboard_init+0x10/0x130
> Aug 22 19:39:33 tlg kernel:  [<ffffffff802668f1>] init+0x13b/0x313
> Aug 22 19:39:33 tlg kernel:  [<ffffffff8025dba8>] child_rip+0xa/0x12
> Aug 22 19:39:33 tlg kernel: DWARF2 unwinder stuck at
child_rip+0xa/0x12
> Aug 22 19:39:33 tlg kernel: Leftover inexact backtrace:
> Aug 22 19:39:33 tlg kernel:  [<ffffffff802632ae>]
> _spin_unlock_irq+0x2b/0x53
> Aug 22 19:39:33 tlg kernel:  [<ffffffff8025d300>]
restore_args+0x0/0x30
> Aug 22 19:39:33 tlg kernel:  [<ffffffff80215fed>]
> release_console_sem+0x4d/0x238
> Aug 22 19:39:33 tlg kernel:  [<ffffffff802667b6>] init+0x0/0x313
> Aug 22 19:39:33 tlg kernel:  [<ffffffff8025db9e>] child_rip+0x0/0x12
> 
> Cheers,
> Grant
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
