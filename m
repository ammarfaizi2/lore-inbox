Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262784AbTLIVex (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 16:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263053AbTLIVex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 16:34:53 -0500
Received: from [64.65.189.210] ([64.65.189.210]:58842 "EHLO
	mail.pacrimopen.com") by vger.kernel.org with ESMTP id S262784AbTLIVeu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 16:34:50 -0500
Subject: 2.4.23 + Preempt, JFS Corruption.
From: Joshua Schmidlkofer <joshua@imr-net.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1071005675.32237.97.camel@bubbles.imr-net.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 09 Dec 2003 13:34:35 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy,

   We are migrating from ext3 to jfs and had a weird error.  We have a
dual pentium III 1.4 ghz system.  We have 4GB of ram, and a Mylex
AcceleRAID 170 [DAC960] controller. Intel pro/100 nics, nothing else too
special.  The motherboard chipset is ServerWorks.  We added a 40GB ide
drive to the onboard controller.  It has jfs on it, and we are using
this for the migration.  We have been backing up to it for a few days,
and it went read-only on us.  

  I have dtree page corrupt errors, but no hardware errors.  jfs fsck
errors out as well.

  We saw a load of errors like this in the dmesg:

ERROR: (device ide0(3,1)): DT_GETPAGE: dtree page corrupt
ERROR: (device ide0(3,1)): DT_GETPAGE: dtree page corrupt
ERROR: (device ide0(3,1)): DT_GETPAGE: dtree page corrupt
ERROR: (device ide0(3,1)): DT_GETPAGE: dtree page corrupt
ERROR: (device ide0(3,1)): DT_GETPAGE: dtree page corrupt
ERROR: (device ide0(3,1)): DT_GETPAGE: dtree page corrupt
ERROR: (device ide0(3,1)): DT_GETPAGE: dtree page corrupt


jfs fsck reports:
jfs_fsck version 1.1.4, 30-Oct-2003
processing started: 12/9/2003 9.3.38
The current device is:  /dev/hda1
Block size in bytes:  4096
Filesystem size in blocks:  9769520
**Phase 1 - Check Blocks, Files/Directories, and  Directory Entries
**Phase 2 - Count links
Incorrect link counts detected in the aggregate.
**Phase 3 - Duplicate Block Rescan and Directory Connectedness
**Phase 4 - Report Problems
File system object DF1323074 is linked as:
/slash/home/virtual/[innocent protected]
cannot repair the data format error(s) in this directory.
cannot repair DF1323074.
**Phase 5 - Check Connectivity
**Phase 6 - Perform Approved Corrections
**Phase 7 - Verify File/Directory Allocation Maps
**Phase 8 - Verify Disk Allocation Maps
Incorrect data detected in disk allocation structures.
Incorrect data detected in disk allocation control structures.
 39078080 kilobytes total disk space.
   292595 kilobytes in 88974 directories.
 15368020 kilobytes in 1074664 user files.
        0 kilobytes in extended attributes
   633991 kilobytes reserved for system use.
 23368664 kilobytes are available for use.
File system checked READ ONLY.
ERRORS HAVE BEEN DETECTED.  Run fsck with the -f parameter to repair.
Filesystem is dirty.



(the [innocent protected] just obfuscates the path)

