Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268090AbUJSJL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268090AbUJSJL3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 05:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268092AbUJSJL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 05:11:29 -0400
Received: from fmr12.intel.com ([134.134.136.15]:2535 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S268090AbUJSJL0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 05:11:26 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: PATCH/RFC: driver model/pmcore wakeup hooks (1/4)
Date: Tue, 19 Oct 2004 17:11:12 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD3057559A042@pdsmsx402.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PATCH/RFC: driver model/pmcore wakeup hooks (1/4)
Thread-Index: AcS1jenjibOno0l9QOiEjavtxWaFsQALIJiQ
From: "Li, Shaohua" <shaohua.li@intel.com>
To: "David Brownell" <david-b@pacbell.net>, "Brown, Len" <len.brown@intel.com>
Cc: "Pavel Machek" <pavel@ucw.cz>, <linux-kernel@vger.kernel.org>,
       "ACPI Developers" <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 19 Oct 2004 09:11:12.0954 (UTC) FILETIME=[949549A0:01C4B5BB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A final solution is device core adds an ACPI layer. That is we can link
ACPI device and physical device. This way, the PCI device can know which
ACPI is linked with it, so the PCI API can use specific ACPI method. 
You are right, we currently haven't a method to reach the goal. To match
a physical device and ACPI device, we need to know the ACPI device's
_ADR and bus.
I have a toy to link the PCI device and ACPI device, and some PCI
function can use _SxD method and _PSx method to get some information for
suspend/resume.

Thanks,
Shaohua
>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
>owner@vger.kernel.org] On Behalf Of David Brownell
>Sent: Tuesday, October 19, 2004 11:41 AM
>To: Brown, Len
>Cc: Pavel Machek; linux-kernel@vger.kernel.org; ACPI Developers
>Subject: Re: PATCH/RFC: driver model/pmcore wakeup hooks (1/4)
>
>On Friday 15 October 2004 11:03 pm, Len Brown wrote:
>> > - ACPI (this should probably replace the new /proc/acpi/wakeup)
>>
>> Agreed.  That file is a temporary solution.
>> The right solution is for the devices to appear in the right
>> place in the device tree and to hang the wakeup capabilities
>> off of them there.
>
>So what would that patch need before ACPI could convert to use it?
>
>I didn't notice any obvious associations between the strings in
>the acpi/wakeup file and anything in sysfs.  Which of USB1..USB4
>was which of the three controllers shown by "lspci" (and which
>one was "extra"!), as one head-scratcher.
>
>For PCI, I'd kind of expect pci_enable_wake() to trigger the
>additional ACPI-specific work to make sure the device can
>actually wake that system.   Seems like dev->platform_data
>might need to combine with some platform-specific API hook.
>
>- Dave
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
