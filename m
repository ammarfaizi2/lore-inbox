Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbUKHSpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbUKHSpl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 13:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbUKHREh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 12:04:37 -0500
Received: from fmr06.intel.com ([134.134.136.7]:64693 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261914AbUKHQIP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 11:08:15 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [ACPI] [PATCH/RFC 0/4]Bind physical devices with ACPI devices
Date: Tue, 9 Nov 2004 00:08:03 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041AC033@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ACPI] [PATCH/RFC 0/4]Bind physical devices with ACPI devices
Thread-Index: AcTFo5CoMPlsSo+gSR2zBDtHK6GPcwAAwYtw
From: "Yu, Luming" <luming.yu@intel.com>
To: "Matthew Wilcox" <matthew@wil.cx>
Cc: "Li, Shaohua" <shaohua.li@intel.com>,
       "ACPI-DEV" <acpi-devel@lists.sourceforge.net>,
       "lkml" <linux-kernel@vger.kernel.org>,
       "Brown, Len" <len.brown@intel.com>, "Greg" <greg@kroah.com>,
       "Patrick Mochel" <mochel@digitalimplant.org>
X-OriginalArrivalTime: 08 Nov 2004 16:08:03.0751 (UTC) FILETIME=[20710B70:01C4C5AD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>On Mon, Nov 08, 2004 at 10:46:30PM +0800, Yu, Luming wrote:
>> >All we need is an acpi_get_gendev_handle that takes a 
>struct device and
>> >returns the acpi_handle for it.  Now, maybe that'd be best 
>> >done by placing
>> >a pointer in the struct device, but I bet it'd be just as 
>good to walk
>> >the namespace looking for the corresponding device.
>> 
>>   It will fail if you just simply walk namespace to find out 
>> the corresponding acpi object, because there are NO
>> hardware id or compatible id  can be passed in.
>> Please check function acpi_bus_match.
>
>It doesn't need the HID or CID.  Look at Shaohua's patches -- 
>they don't
>use HID or CID either.
>
Yes, I made a mistake, please forget that point.

But another statement I made should be valid.
That is how to use geographical address to
locate corresponding acpi object.

For example,  ACPI define IDE as the following:

Device (IDE0){ /* primary controller */
	Name (_ADR, 0)
	Method (_GTM )
	...
	Device(PRIM) /* primary adapter */
		Name (_ADR, 0)
		Method(_GTM)
		...
		Device(MSTR) /* master channel */
			Name (_ADR,0)
			Method(_GTF)

  We need not only able to locate acpi object IDE0
but also we need to locate object PRIM underneath
IDE0,  and MSTR underneath PRIM. Thus, IDE driver 
can fully take advantage from ACPI, in terms of 
configuration and power management.

  Maybe we need to invent a method called
map_device_addr_to_acpi_handle to be  generic solution.

Thanks,
Luming


  



