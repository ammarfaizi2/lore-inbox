Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267478AbUIUCcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267478AbUIUCcx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 22:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267466AbUIUCcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 22:32:53 -0400
Received: from fmr12.intel.com ([134.134.136.15]:38890 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S267464AbUIUCco convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 22:32:44 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [ACPI] PATCH-ACPI based CPU hotplug[2/6]-ACPI Eject interfacesupport
Date: Tue, 21 Sep 2004 10:30:43 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84059309EF@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ACPI] PATCH-ACPI based CPU hotplug[2/6]-ACPI Eject interfacesupport
Thread-Index: AcSffD182EbWiJ6ERY6qC4IpNsQi6QAA+05g
From: "Yu, Luming" <luming.yu@intel.com>
To: "Alex Williamson" <alex.williamson@hp.com>,
       "Dmitry Torokhov" <dtor_core@ameritech.net>
Cc: <acpi-devel@lists.sourceforge.net>,
       "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>,
       "Brown, Len" <len.brown@intel.com>,
       "LHNS list" <lhns-devel@lists.sourceforge.net>,
       "Linux IA64" <linux-ia64@vger.kernel.org>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 21 Sep 2004 02:32:30.0753 (UTC) FILETIME=[3E461910:01C49F83]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > > 
>> > > Hi Anil,
>> > > 
>> > > I obviously failed to deliver my idea :) I meant that I 
>would like add eject
>> > > attribute (along with maybe status, hid and some others) 
>to kobjects in
>> > > /sys/firmware/acpi tree.
>> > > 
>> > 
>> > Dmitry,
>> > 
>> >    See the patch I just posted to acpi-devel and lkml (Subject:
>> > [PATCH/RFC] exposing ACPI objects in sysfs).  It exposes 
>acpi objects as
>> > you describe.   Something simple like:
>> > 
>> >  # cat /sys/firmware/acpi/namespace/ACPI/_SB/LSB0/_EJ0
>> > 
>> > Will call the _EJ0 method on the ACPI device.  You can 
>evaluate eject
>> > dependencies using the _EJD method.
>> > 
>> > 	Alex
>> > 
>> 
>> Alex,
>> 
>> While I think that your patch is very important and should 
>be included (maybe
>> if not as is if somebody has some objections but in some 
>other form) I see it
>> more like developer's tool. I imagined status, HID, eject 
>etc. attributes to
>> be sanitized interface to kernel's data, not necessarily 
>causing re-evaluation.
>> 
>
>Dmitry,
>
>   I imagined the sanitized interfaces would be provided via a 
>userspace
>library, similar to how lspci provides a clean interface to all of the
>PCI data.  An "lsacpi" tool could extract the information into 
>something
>more like you suggest.  If you have objects exposed as human
>readable/writable files, I think you'll quickly end up with a _STA
>driver, _HID driver, _CID driver, _ADR driver, _UID driver, 
>_EJx driver,
>etc, etc, etc...  I don't think we want that kind of bloat in 
>the kernel
>(that's what userspace is for ;^).  Providing a solid, direct interface
>to ACPI methods in the kernel seems like the most flexible, powerful
>interface IMHO.  Thanks,
>
>	Alex
>
>> So it could be like this:
>> 
>> /sys/firmware/acpi/namespace/ACPI/_SB/LSB0/status
>> /sys/firmware/acpi/namespace/ACPI/_SB/LSB0/removable
>> /sys/firmware/acpi/namespace/ACPI/_SB/LSB0/lockable
>> ..
>> /sys/firmware/acpi/namespace/ACPI/_SB/LSB0/eject
>> 
>> And your raw access to the ACPI methods could reside under raw:
>> 
>> /sys/firmware/acpi/namespace/ACPI/_SB/LSB0/raw/_STA
>> /sys/firmware/acpi/namespace/ACPI/_SB/LSB0/raw/_RNV
>> /sys/firmware/acpi/namespace/ACPI/_SB/LSB0/raw/_LCK
>> ..
>> /sys/firmware/acpi/namespace/ACPI/_SB/LSB0/raw/_EJ0
>

  This sounds like a good idea. To call the raw AML methods from
User space, just need to solve the problem of argument passing.
But, some AML methods are risky to be called directly from user space,
Not only because the side effect of its execution, but also because
it could trigger potential AML method bug or interpreter bug, or even
architectural defect.  All of these headache is due to the AML method
 is NOT intended for being used by userspace program.

Thanks,
Luming



  

