Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261737AbVC1NZy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261737AbVC1NZy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 08:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbVC1NZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 08:25:54 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:15020 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261737AbVC1NZp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 08:25:45 -0500
Subject: [RFC/PATCH 0/17][Kdump] Overview
From: Vivek Goyal <vgoyal@in.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>, fastboot <fastboot@lists.osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain
Date: Mon, 28 Mar 2005 18:55:41 +0530
Message-Id: <1112016341.4001.71.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset restores back the kdump functionality on i386. Patchset
contains the patches for user space (kexec-tools-1.101) and kernel space
(2.6.12-rc1-mm3). Some of the user space patches are being released for
the completeness.

This patch set performs following.

kexec-tool-1.101
(http://www.xmission.com/~ebiederm/files/kexec/kexec-tools-1.101.tar.gz)
-----------------------------------------------------------------------

- Create a backup region and copy the first 640K of memory to backup
  region over a crash.
- Generate Elf headers representing crashed memory and store in reserved
  region. Also appends the memmap= and elfcorehdr= parameters to command
  line internally to be passed to capture kernel.
- Fills in the virtual addresses for linearly mapped region at the elf
  header creation time. This assists in limited debugging through gdb.
- Adds another command line option "--crash-dump" to differentiate
  between kexec on panic and kexec on panic with crash dump on.


2.6.12-rc1-mm3
--------------

- Retrieve physical address of elf core headers, stored by crashed
  kernel.
- Export dump image in ELF format through /proc/vmcore interface.
- Export raw dump image through /dev/oldmem interface.


Following patches (as in series file) need to be dropped before applying
the fresh ones.

crashdump-documentation.patch
crashdump-memory-preserving-reboot-using-kexec.patch
crashdump-routines-for-copying-dump-pages.patch
crashdump-routines-for-copying-dump-pages-fixes.patch
crashdump-elf-format-dump-file-access.patch
crashdump-linear-raw-format-dump-file-access.patch
crashdump-linear-raw-format-dump-file-access-coding-style.patch


I look forward for comments and suggestions. I have done basic testing
on uni and SMP systems.

Thanks
Vivek

