Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264679AbSKRT06>; Mon, 18 Nov 2002 14:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264756AbSKRTZC>; Mon, 18 Nov 2002 14:25:02 -0500
Received: from d12lmsgate.de.ibm.com ([194.196.100.234]:50429 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S264647AbSKRTYu> convert rfc822-to-8bit; Mon, 18 Nov 2002 14:24:50 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.48 s390.
Date: Mon, 18 Nov 2002 20:16:20 +0100
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211182016.20240.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
some s390 patches for 2.5.48. The majority of the patches is to keep up
with the common code changes. There is one bigger patch: the reworked
sclp driver - formerly known as hwc. It is much smaller than the old
code, still does the same and even has some comments...
We are still very busy with the sysfs driver model changes. There is
more to be done before the common io layer is in a state that won't
change immediatly again. Arnd wanted to put a current version of
it to linux-390.bkbit.net for interested parties. It is not ready
for inclusion into the main kernel yet.

01: Kconfig file fixes: remove options ISA/MCA/EISA, add some missing
    help texts. Regenerate default configuration files. Update section
    names in vmlinux.lds.S. Simplify some Makefiles.
02: Add new system calls for event polling and set_tid_address.
03: New memory management defines MAP_POPULATE/MAP_NONBLOCK .
04: s390 needs a 64 bit sector_t for big disks accessed via scsi/zfcp.
05: Add s390/s390x support for new kernel module loader.
06: Compile fixes.
07: Bug fix for copy_to_user/copy_from_user. If the copy faults, it is
    possible that the information in the lowcore gets overwritten. The
    new code is completly independent from program check information.
    Fix compile for peculiar get_user() usage in drivers/scsi/scsi_ioctl.c
08: Make the kernel compile with newer version of gcc.
09: Fix ebcdic conversion for strings of n*256 + 1 characters.
10: Don't set cpu_vm_mask if the mm isn't exclusive to the cpu.
11: Remove the _PAGE_ISCLEAN bit in pte_mkwrite to make pte_mkwrite
    work correctly even if it is not followed by a pte_mkdirty.
12: Bug fixes for the 31 bit emulation layer. New interface
    [un]register_ioctl32_conversion.
13: xpram driver: remove unused variable and add missing return statement.
14: Remove some warnings.
15: Reworked sclp driver part 1 - remove hwc files
16: Reworked sclp driver part 2 - add sclp files.

blue skies,
  Martin.


