Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262745AbUJ1EFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262745AbUJ1EFE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 00:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262747AbUJ1EFD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 00:05:03 -0400
Received: from fmr12.intel.com ([134.134.136.15]:47571 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S262745AbUJ1EEz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 00:04:55 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Userspace ACPI interpreter ( was RE: [ACPI] [RFC] dev_acpi: support for userspace access to acpi)
Date: Thu, 28 Oct 2004 12:04:31 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041ABFFA@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Userspace ACPI interpreter ( was RE: [ACPI] [RFC] dev_acpi: support for userspace access to acpi)
Thread-Index: AcS8fSFIbZUGHmuaT46OW+2p8Vx9EAAIIHqg
From: "Yu, Luming" <luming.yu@intel.com>
To: "Bjorn Helgaas" <bjorn.helgaas@hp.com>, "Brown, Len" <len.brown@intel.com>,
       "Moore, Robert" <robert.moore@intel.com>
Cc: "Alex Williamson" <alex.williamson@hp.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 28 Oct 2004 04:04:32.0689 (UTC) FILETIME=[3AE36A10:01C4BCA3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Wednesday 27 October 2004 11:17 am, Yu, Luming wrote:
>>   If don't use acpi_early_init , acpi is initialized in 
>do_basic_setup() in kernel thread --init.
>> It is very close to launch first user space 
>process(/sbin/init ..). So, if we can invent 
>> acpi_later_init, it is possible to move interpreter out of kernel.
>
>It's true that some early init stuff is based on the static tables
>and doesn't require the interpreter.  But there is a lot of stuff
>that DOES require the interpreter, like finding PCI root bridges,
>PRTs, PCI interrupt link devices, etc.  It's not clear to me that
>it's feasible to deal with all these from userspace.

On IA64 platform, ACPI interpreter seems to be mandatory for those
stuff, but IA32 is not.  So, the ram disk is the generic solution 
for loading user space interpreter for boot. 

>
>>   The difficulty for inventing userspace interpreter is to 
>eliminate the ACPI-interpreter dependency 
>> of drivers for booting. But this dependency is not 
>mandatory. Once kernel booted to be able
>> to launch /sbin/init, it is also able to launch 
>/sbin/user_space_interpreter, then kernel can enjoy
>> acpi from then on, despite the acpi interpreter is a user 
>space daemon, we just need to invent
>> or user a communication method between kernel and user space daemon.
>
>Before the interpreter, you don't have ANY devices (legacy ones are
>described via the namespace of course, and PCI devices depend on root
>bridges that are also in the namespace).  So you end up at least
>requiring a ramdisk, plus a bunch of encoding to communicate resource
>information from the interpreter to the drivers.
>
>Maybe not impossible, but it certainly requires a lot of work.  Moving
>the interpreter to userspace has been proposed many times, but I've
>never seen any indication that anybody is actually working on it.
>

Yes, it needs a lot of work.  If we want to continue, we should find out
what's the benefit of doing so. The biggest benefit could be that kernel
will be less complex, thus kernel will be more stable.  At least, some
ACPI operation (like information query) is not needed to be handled in
kernel in synchronous manner, which is kernel invoking ACPI interpreter
like calling a C function. On laptop, I DO get many bug reports that
kernel 
crashes, or hang for a while ,or input event lost..., just due to AML
call executed
by ACPI interpreter running in the kernel.  I expect all this symptom
will
be gone, if interpreter is running in user space.

Thanks,
Luming
