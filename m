Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbWCBFuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWCBFuN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 00:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWCBFuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 00:50:12 -0500
Received: from fmr23.intel.com ([143.183.121.15]:13984 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750774AbWCBFuK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 00:50:10 -0500
x-mimeole: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: 2.6.16rc5 'found' an extra CPU.
Date: Thu, 2 Mar 2006 00:49:53 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30063BFB95@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.16rc5 'found' an extra CPU.
Thread-Index: AcY9r9tXD0Cwbk6hS+6uA7sKXDYtggADIu0Q
From: "Brown, Len" <len.brown@intel.com>
To: "Dave Jones" <davej@redhat.com>, "Raj, Ashok" <ashok.raj@intel.com>
Cc: "Andi Kleen" <ak@suse.de>, <linux-kernel@vger.kernel.org>,
       <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 02 Mar 2006 05:49:55.0715 (UTC) FILETIME=[221E1D30:01C63DBD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>sysfs gets it right.
>
>(23:11:01:davej@nemesis:~)$ ls /sys/devices/system/cpu/
>cpu0/  cpu1/
>(23:11:07:davej@nemesis:~)$ ls /proc/acpi/processor/
>CPU1/  CPU2/  CPU3/

This is because the BIOS has three "Processor" objects in the DSDT.

As I've mentioned before, /proc/acpi/*/* should not exist.
Internal ACPI BIOS names "CPU1, CPU1, CPU3" in this case
are actually arbitray 4-character strings, and should
never be exposed to the user in the file-system.

sysfs with cpu0, cpu1 -- predictable strings for objects --
gets it right, and is the direction we are going.

I'm afraid that even after we get this stuff out of /proc
and into sysfs where it belongs, we'll have to leave /proc/acpi around
for a while b/c unfortunately people are under the impression
that the path names there actually mean something and
they can actually count on them -- which they can't.

-Len
