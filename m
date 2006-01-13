Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030364AbWAMNu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030364AbWAMNu2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 08:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030365AbWAMNu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 08:50:28 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:36023 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1030364AbWAMNu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 08:50:27 -0500
From: "Takashi Sato" <sho@tnes.nec.co.jp>
To: "'Andrew Morton'" <akpm@osdl.org>
Cc: <torvalds@osdl.org>, <viro@zeniv.linux.org.uk>,
       <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
       <trond.myklebust@fys.uio.no>
Subject: RE: [PATCH 2/3] Fix problems on multi-TB filesystem and file
Date: Fri, 13 Jan 2006 22:50:19 +0900
Message-ID: <000101c61848$4dd3b5b0$4168010a@bsd.tnes.nec.co.jp>
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
In-Reply-To: <20060112183319.526b877a.akpm@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> >  This is a patch to add blkcnt_t as the type of inode.i_blocks.
> >  This enables you to make the size of blkcnt_t either 4 bytes or 8 bytes
> >  on 32 bits architecture with CONFIG_LSF.
>
> What was the rationale behind CONFIG_LSF?  It's a bit of an ugly thing and
> I'm wondering if we wouldn't be better off just removing it and simply
> fixing >2TB support for all .configs?

We should avoid needless growth of heavily-used structure such as
inode for a small system like embedded system.
So I make it possible to configure the size of i_blocks with CONFIG_LSF.

> Do the common userspace tools need to be updated for this, or do they
> already get it right?

glibc's st_blocks is always 8 bytes as below.

__blkcnt64_t st_blocks;

On the original kernel, a padding for st_blocks is set at appropriate
location for each endian types as below.
So, there is no need to fix user program(glibc).

include/asm-i386/stat.h:
--------------------------------------------------------------------------
unsigned long   st_blocks;      /* Number 512-byte blocks allocated. */
unsigned long   __pad4;         /* future possible st_blocks high bits */
---------------------------------------------------------------------------

include/asm-m68k/stat.h:
--------------------------------------------------------------------------
unsigned long   __pad4;         /* future possible st_blocks high bits */
unsigned long   st_blocks;      /* Number 512-byte blocks allocated. */
--------------------------------------------------------------------------

-- Takashi Sato


