Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161023AbWKHQxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161023AbWKHQxM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 11:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161219AbWKHQxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 11:53:12 -0500
Received: from mtagate6.de.ibm.com ([195.212.29.155]:34542 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1161023AbWKHQxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 11:53:11 -0500
Date: Wed, 8 Nov 2006 17:54:12 +0100
From: Michael Holzheu <holzheu@de.ibm.com>
To: pavel@ucw.cz
Cc: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org,
       mschwid2@de.ibm.com
Subject: Re: How to document dimension units for virtual files?
Message-Id: <20061108175412.3c2be30c.holzheu@de.ibm.com>
Organization: IBM
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel, Ingo,

Pavel Machek <pavel@ucw.cz> wrote on 10/28/2006 07:40:48 PM:
> Hi!
> 
> > > > 2. Encode dimension unit into filename (e.g. onlinetime_ms or
> > memory_kb)
> > >
> > > This is the recommended one.
> > > - simple to implement and understand on both sides
> > >

[snip]

> > I also think that this is the best solution. It would be nice to have
> > that documented somewhere. Maybe in the Documentation directory
> > something like:
> > 
> > Howto export data in virtual files
> > ==================================
> > 
> > If you want to export data to userspace via virtual filesystems
> > like procfs, sysfs, debugfs etc., the following rules are recommended:
> 
> ...yes please... such patch would be nice.

What about the following ...

Michael

---

 Documentation/filesystems/00-INDEX   |    2 +
 Documentation/filesystems/ExportData |   47 +++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff -Naur linux-2.6.18/Documentation/filesystems/00-INDEX linux-2.6.18-exp-data-doc/Documentation/filesystems/00-INDEX
--- linux-2.6.18/Documentation/filesystems/00-INDEX	2006-09-20 10:50:34.000000000 +0200
+++ linux-2.6.18-exp-data-doc/Documentation/filesystems/00-INDEX	2006-11-08 17:45:31.000000000 +0100
@@ -1,5 +1,7 @@
 00-INDEX
 	- this file (info on some of the filesystems supported by linux).
+ExportData
+	- recommendation of how to export data via virtual File Systems.
 Exporting
 	- explanation of how to make filesystems exportable.
 Locking
diff -Naur linux-2.6.18/Documentation/filesystems/ExportData linux-2.6.18-exp-data-doc/Documentation/filesystems/ExportData
--- linux-2.6.18/Documentation/filesystems/ExportData	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.18-exp-data-doc/Documentation/filesystems/ExportData	2006-11-08 17:44:59.000000000 +0100
@@ -0,0 +1,47 @@
+
+Export data via virtual File Systems
+====================================
+
+If you want to export data to userspace via virtual filesystems
+like procfs, sysfs, debugfs etc., the following rules are recommended:
+
+- Export only one value in one virtual file.
+- Data format should be as simple as possible.
+- Use ASCII formated strings, no binary data if possible.
+- If data has dimension units, encode that in the filename.
+
+Please use the following prefixes, when dimension units are required (According
+to IEC 60027-2 and SI/International System of Units):
+
+Storage size (SI prefixes)
+--------------------------
+* kB: kilobyte (10^3 Byte)
+* MB: megabyte (10^6 Byte)
+* GB: gigabyte (10^9 Byte)
+* TB: terabyte (10^12 Byte)
+* PB: petabyte (10^15 Byte)
+
+Storage size (Binary prefixes)
+------------------------------
+* KiB: kibibyte (2^10 Byte)
+* MiB: mebibyte (2^20 Byte)
+* GiB: gibibyte (2^30 Byte)
+* TiB: tebibyte (2^40 Byte)
+* PiB: pebibyte (2^50 Byte)
+
+Time (SI pefixes)
+-----------------
+* s:  Second
+* ms: Millisecond (10^-3 Seconds)
+* us: Microsecond (10^-6 Seconds)
+* ns: Nanosecond (10^-9 Seconds)
+
+Examples:
+---------
+> ls /sys/kernel/debug/sysinfo
+free_mem_KiB
+online_time_ms
+cpu_time_us
+
+> cat /sys/kernel/debug/free_mem_KiB
+147536
