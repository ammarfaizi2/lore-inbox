Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbVG0Xoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbVG0Xoo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 19:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVG0XnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 19:43:25 -0400
Received: from fmr15.intel.com ([192.55.52.69]:30106 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S261235AbVG0Xlm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 19:41:42 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: ACPI buttons in 2.6.12-rc4-mm2
Date: Wed, 27 Jul 2005 19:40:46 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B300428CAA6@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ACPI buttons in 2.6.12-rc4-mm2
Thread-Index: AcWTArSTxUgwdpCSSZ6Kk4nANft2ngAABplQ
From: "Brown, Len" <len.brown@intel.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <thecwin@gmail.com>, <acpi-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 27 Jul 2005 23:40:48.0320 (UTC) FILETIME=[9D9A1400:01C59304]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
>> I'm open to suggestions on how to approach this transition.
>> I can make ACPI_PROC a static build option -- what else
>> can I do to ease the transition in this, our stable release?
>
>Well I don't know how awkward this would be from an 
>implementation POV, but can we just leave the legacy
>/proc stuff there until the /sys interface is
>all in place and userspace is upgraded?
>Then kill all the /proc stuff later?
>
>We could also print a rude message the first time someone 
>tries to use a deprecated /proc file, just to help push the
>userspace tool developers along.
>Although I note that sys_bdflush() is still with us ;)

/proc/acpi/event
/proc/acpi/sleep
are used the most.

/proc/acpi/<drivername>/<BIOS devname>/* are really screwed up
in that <BIOS devname> is an arbitrary internal BIOS string
that should have never been exposed to userspace.  Instead
we should have done what sysfs does -- look at the _type_
of device and then simply add a number to it -- cpu0, cpu1
so that a program could actually find stuff.

I'm constantly nagged that this layer in the /proc/tree
had arbitrary strings in pathnames.  Also, the /proc
file handling code is buggy -- so it wastes my time
maintaining it, when it should not exist at all...
Restoring the /proc code to the button driver will
increase button.c in size by over 60%...

So I'm in favor of whatever solution makes it all go away
as soon as possible.

-Len
