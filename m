Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318058AbSHQSCo>; Sat, 17 Aug 2002 14:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318059AbSHQSCo>; Sat, 17 Aug 2002 14:02:44 -0400
Received: from [143.166.83.88] ([143.166.83.88]:53261 "HELO
	AUSADMMSRR501.aus.amer.dell.com") by vger.kernel.org with SMTP
	id <S318058AbSHQSCn>; Sat, 17 Aug 2002 14:02:43 -0400
X-Server-Uuid: ff595059-9672-488a-bf38-b4dee96ef25b
Message-ID: <20BF5713E14D5B48AA289F72BD372D6821CB73@AUSXMPC122.aus.amer.dell.com>
From: Matt_Domsch@Dell.com
To: bunk@fs.tum.de, marcelo@conectiva.com.br
cc: linux-kernel@vger.kernel.org, alan@redhat.com
Subject: [BK PATCH 2.4.x] move asm-ia64/efi.h to linux/efi.h (was RE:
 Lin ux 2.4.20-pre3)
Date: Sat, 17 Aug 2002 13:06:34 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
X-WSS-ID: 11404F2773618-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The compile error in efi.c is still present in -pre3:
> efi.c: In function `add_gpt_partitions':
> efi.c:728: `NULL_GUID' undeclared (first use in this function)

> Matt suggested to move include/asm-ia64/efi.h to 
> include/linux/efi.h. Is
> it possible to do this before 2.4.20-final?

I sure hope so.  Here's the patch set for 2.4.x which fixes the NULL_GUID
bug, moves efi.h from include/asm-ia64 to include/linux, and fixes
efi_guid_unparse.


1)
http://domsch.com/linux/patches/gpt/linux-2.4-gpt-efiguidt.cset
has been in the IA64 port for a while.  This fixes the endianness issues
with the efi_guid_t type and adds the NULL_GUID definition needed to compile
the GPT code.

2)
http://domsch.com/linux/patches/ia64/linux-2.4-efihmove.cset
moves include/asm-ia64/efi.h to include/linux/efi.h similar to the 2.5
patches.  This is needed to allow the GPT code to compile on non-IA64
platforms too, necessary for the use of really big disks.

3)
http://domsch.com/linux/patches/gpt/linux-2.4-gpt-efiguidt-unparse.cset
has been the IA64 port for a while.  This fixes efi_guid_unparse for
endianness.


These need to be applied in the above order, as #1 touches efi.h,  #2
touches and moves efi.h, and #3 touches it then too.  #1 and #3 are already
in the ia64 port tree, but Marcelo and Alan don't have any of these three.
I've compiled this on x86 against BK-current building in GPT with no
troubles.


Thanks,
Matt
--
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
#1 US Linux Server provider for 2001 and Q1/2002! (IDC May 2002)

