Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315709AbSHVS5n>; Thu, 22 Aug 2002 14:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315762AbSHVS5m>; Thu, 22 Aug 2002 14:57:42 -0400
Received: from ausadmmsps306.aus.amer.dell.com ([143.166.224.101]:34057 "HELO
	AUSADMMSPS306.aus.amer.dell.com") by vger.kernel.org with SMTP
	id <S315709AbSHVS5k>; Thu, 22 Aug 2002 14:57:40 -0400
X-Server-Uuid: c21c953d-96eb-4242-880f-19bdb46bc876
Message-ID: <20BF5713E14D5B48AA289F72BD372D6821CBBB@AUSXMPC122.aus.amer.dell.com>
From: Matt_Domsch@Dell.com
To: Andries.Brouwer@cwi.nl
cc: linux-kernel@vger.kernel.org
Subject: RE: NULL_GUID
Date: Thu, 22 Aug 2002 14:01:47 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
X-WSS-ID: 117BEA972372756-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Earlier this evening I happened to compile a 2.4.20-pre4 and got
> 
> efi.c: In function `add_gpt_partitions':
> efi.c:728: `NULL_GUID' undeclared (first use in this function)
> 
> Earlier it was defined in include/asm-ia64/efi.h,
> but since there is no relation with ia64 it is reasonable
> that it was moved, only it never arrived in partitions/efi.h.
> 
> [I'll be lazy and not supply the trivial patch. Too likely
> that others already did.]

Yep.  FWIW, these are incorporated in the IA64 port patch released yesterday
too.  I'd love to see these included in the standard 2.4.x trees.

Patches available in a number of places:
bk pull http://mdomsch.bkbits.net/linux-2.4-gpt

As separate patches:
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
touches and moves efi.h, and #3 touches it then too.  All are already in the
ia64 port tree, but Marcelo and Alan don't have any of these three yet.
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

