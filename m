Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbWG0PoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWG0PoG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 11:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWG0PoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 11:44:05 -0400
Received: from mga01.intel.com ([192.55.52.88]:22202 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750802AbWG0PoE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 11:44:04 -0400
X-IronPort-AV: i="4.07,189,1151910000"; 
   d="scan'208"; a="105925461:sNHT329960267"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Generic battery interface
Date: Thu, 27 Jul 2006 11:40:43 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6011259C4@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Generic battery interface
Thread-Index: AcaxjzziJX69FFXLSuWUQrr7KNG1ZgAAW9ew
From: "Brown, Len" <len.brown@intel.com>
To: "Shem Multinymous" <multinymous@gmail.com>, "Pavel Machek" <pavel@suse.cz>
Cc: "Matthew Garrett" <mjg59@srcf.ucam.org>, <vojtech@suse.cz>,
       "kernel list" <linux-kernel@vger.kernel.org>,
       <linux-thinkpad@linux-thinkpad.org>, <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 27 Jul 2006 15:40:45.0404 (UTC) FILETIME=[0680A1C0:01C6B193]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ... need a consistent interface to common functionality.

Agreed.

Path names and file names in sysfs are an API, so it is important
to choose them wisely.  The string "acpi" should not appear in
any path-name or file-name in sysfs that is intended to be generic,
as it would make no sense on a non-ACPI system.

Neither the ACPI /proc/acpi/battery API or
the tp_smapi /sys/devices/platform/smapi API qualify as generic.
It it a historical artifact that /proc/acpi exists, I'd delete it
immediately if that wouldn't instantly break every distro on earth.

Re: battery events

Vojtech suggested that we create a virtual battery interface,
just like the input layer has virtual input devices.
Drivers such as above could conjur up devices, and user-space
could also create what look like batteries, say through a
utility that knows how to talk to a UPS.

In either case, user-space would look for a well known set
of device file names, such as /dev/battery0, /dev/battery1
or some such, do a select on the file and get events that way.

With a /dev/battery0, and IOCTLS to get information from it,
the question becomes redundancy between that file and sysfs
text files.

Re: sysfs or /dev

It is tempting to claim that sysfs is extensible, but note
that whenever you create a sysfs file, you are creating an API,
which is a decision of exactly the same magnitude as defining
an IOCTL -- in either case, user-space needs to react to it
to understand it -- just that you can do that from the shell
with sysfs.

-Len
