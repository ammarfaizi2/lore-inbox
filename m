Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbWDYSYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbWDYSYA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 14:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbWDYSX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 14:23:59 -0400
Received: from mga01.intel.com ([192.55.52.88]:18730 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S932279AbWDYSX6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 14:23:58 -0400
X-IronPort-AV: i="4.04,154,1144047600"; 
   d="scan'208"; a="28422606:sNHT1495193973"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] reverse pci config space restore order
Date: Tue, 25 Apr 2006 14:22:08 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6466300@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] reverse pci config space restore order
Thread-Index: AcZoVimKfyIzOZkCRFq7XazB7+zxKgAPX90Q
From: "Brown, Len" <len.brown@intel.com>
To: "Arjan van de Ven" <arjan@infradead.org>,
       "Matthew Garrett" <mjg59@srcf.ucam.org>, <abelay@MIT.EDU>
Cc: "Yu, Luming" <luming.yu@intel.com>, "Andrew Morton" <akpm@osdl.org>,
       <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 25 Apr 2006 18:22:10.0226 (UTC) FILETIME=[2AB07120:01C66895]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>On Tue, 2006-04-25 at 11:48 +0100, Matthew Garrett wrote:
>> On Tue, Apr 25, 2006 at 02:50:57PM +0800, Yu, Luming wrote:
>> 
>> > -	for (i = 0; i < 16; i++)
>> > +	for (i = 15; i >= 0 ; i--)
>> 
>> We certainly need to do /something/ here, but I'm not sure 
>> this is it. 
>> Adam Belay has code to limit PCI state restoration to the 
>> PCI-specified 
>> registers, with the idea being that individual drivers fix things up 
>> properly. While this has the obvious drawback that almost every PCI 
>> driver in the tree would then need fixing up, it's also probably the 
>> right thing.
>
>it has a second drawback: it assumes all devices HAVE a driver, which
>isn't normally the case...

Adam mentioned earlier, and I agree, that it is probably a bad
idea for this code to blindly scribble on the BIST field at i=3.
Probably we should clear that field before restoring it.

Re: this patch
I think that this patch is likely a positive forward step.
It seems logical to restore the BARs before the CMD/STATUS in general,
nothing specific to the ICH here.

But yes, this is a helper routine and devices where it hurts
instead of helps should have their own routine.  Complex devices
need to handle the device-specific config space state above these
1st 16 locations anyway.

-Len
