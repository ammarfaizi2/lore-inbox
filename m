Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316880AbSGBTNB>; Tue, 2 Jul 2002 15:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316882AbSGBTNA>; Tue, 2 Jul 2002 15:13:00 -0400
Received: from smtp2.us.dell.com ([143.166.85.133]:42168 "EHLO
	smtp2.us.dell.com") by vger.kernel.org with ESMTP
	id <S316880AbSGBTM7>; Tue, 2 Jul 2002 15:12:59 -0400
Date: Tue, 2 Jul 2002 14:15:12 -0500 (CDT)
X-X-Sender: mdomsch@humbolt.us.dell.com
From: <>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, <alan@redhat.com>
cc: linux-kernel@vger.kernel.org, David Mosberger <davidm@napali.hpl.hp.com>
Subject: [PATCH] GUID Partition Tables for 2.4.x
Message-ID: <Pine.LNX.4.44.0207021357440.26161-100000@humbolt.us.dell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-ID: <Pine.LNX.4.44.0207021357442.26161@humbolt.us.dell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo and Alan:

Posted to http://domsch.com/linux/patches/gpt is the GUID Partition Table 
code, copied from the IA64 port patch and applied to 2.4.19-pre1 and 
2.4.19-pre10-ac2.  This code is identical to that included in the IA64 
port patch already, and has been in use on IA64 for many many months.  
Equivalent code is already included in the 2.5 kernel series.  I'm 
submitting now for 2.4.x so that a partition table scheme which supports 
Large Block Devices will be available if/when Peter Chubb's work on such 
is backported from 2.5.x.  I've tested this on x86.

The work consist of two parts:
1) Changes efi_guid_t typedef to match the 2.5.x implementation.  This 
code is already included in the ia64 port patch for 2.4.x, and I have 
David Mosberger's approval to submit this directly for 2.4.x.

 arch/ia64/kernel/efivars.c |   21 +++++----------------
 arch/ia64/kernel/mca.c     |   28 +++++++++++++---------------
 include/asm-ia64/efi.h     |   36 +++++++++++++++++++++++++++---------
 include/asm-ia64/sal.h     |   36 ++++++++++++++++++------------------
 4 files changed, 63 insertions, 58 deletions


2) Adds fs/partitions/efi.[ch] and associated small changes to related 
files.  The arch/ia64/defconfig change removes a stale entry.

 Documentation/Configure.help |   11
 arch/ia64/defconfig          |    1
 fs/partitions/Config.in      |    1
 fs/partitions/Makefile       |    2
 fs/partitions/check.c        |    4
 fs/partitions/efi.c          |  804 +++++++++++++++++++++++++++++++++++++++++++
 fs/partitions/efi.h          |  119 ++++++
 fs/partitions/msdos.c        |   11
 8 files changed, 943 insertions, 10 deletions


The patches are in both BK Changeset form and traditional diff.

BK:
http://domsch.com/linux/patches/gpt/linux-2.4-gpt-efiguidt.cset
http://domsch.com/linux/patches/gpt/linux-2.4-gpt.cset

Patch:
http://domsch.com/linux/patches/gpt/linux-2.4.19-rc1-efiguidt.patch
http://domsch.com/linux/patches/gpt/linux-2.4.19-rc1-gpt.patch


Marcelo, I understand you won't wish to apply this before 2.4.19 final.  I 
don't expect any conflicts to arise between this code and anything 
expected in 2.4.19 final, so please try to apply this after 2.4.19 is out.

Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
#1 US Linux Server provider for 2001 and Q1/2002! (IDC May 2002)



