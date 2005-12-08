Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbVLHLjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbVLHLjG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 06:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbVLHLjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 06:39:06 -0500
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:33420 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S932074AbVLHLjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 06:39:05 -0500
Message-ID: <02ab01c5fbeb$faf7d740$4168010a@bsd.tnes.nec.co.jp>
From: "Takashi Sato" <sho@bsd.tnes.nec.co.jp>
To: "Dave Kleikamp" <shaggy@austin.ibm.com>
Cc: "'Andreas Dilger'" <adilger@clusterfs.com>, <linux-kernel@vger.kernel.org>,
       <linux-fsdevel@vger.kernel.org>,
       "Trond Myklebust" <trond.myklebust@fys.uio.no>
References: <000001c5fb1d$0a27c8d0$4168010a@bsd.tnes.nec.co.jp> <1133963528.27373.4.camel@lade.trondhjem.org> <1133967716.8910.5.camel@kleikamp.austin.ibm.com> <1133969671.27373.47.camel@lade.trondhjem.org> <1133973247.8907.33.camel@kleikamp.austin.ibm.com>
Subject: Re: stat64 for over 2TB file returned invalid st_blocks
Date: Thu, 8 Dec 2005 20:38:54 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-2";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> On Wed, 2005-12-07 at 10:34 -0500, Trond Myklebust wrote:
>> If you really want a variable size type here, then the right thing to do
>> is to define a __kernel_blkcnt_t or some such thing, and hide the
>> configuration knob for it somewhere in the arch-specific Kconfigs.
> 
> Takashi's patch does improve on what currently exists.  Maybe someone
> can create a separate patch to replace sector_t with blkcnt_t where it
> makes sense.

I prefer sector_t for i_blocks rather than newly defined blkcnt_t.
The reasons are:

  - Both i_blocks and common sector_t are for on-disk 512-byte unit.
    In this point of view, they have the same character.

  - If we created the type blkcnt_t newly, the patch would have to
    touch a lot of files as follows, like sector_t does.
        block/Kconfig, asm-i386/types.h, asm-x86_64/types.h,
        asm-ppc/types.h, asm-s390/types.h, asm-sh/types.h,
        asm-h8300/types.h, asm-mips/types.h
    It will be simple if we use sector_t for i_blocks.

Also, I cannot imagine the situation that > 2TB files are used over
network with CONFIG_LBD disabled kernel.  Is there such a thing
realistically?

-- Takashi Sato
