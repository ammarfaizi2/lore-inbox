Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265663AbUGGW4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265663AbUGGW4k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 18:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265660AbUGGW4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 18:56:35 -0400
Received: from mail-relay-1.tiscali.it ([212.123.84.91]:15245 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S265661AbUGGW42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 18:56:28 -0400
Date: Thu, 8 Jul 2004 00:56:35 +0200
From: Kronos <kronos@kronoz.cjb.net>
To: linux-kernel@vger.kernel.org
Cc: programming@johnwross.com
Subject: Re: Increasing IDE Channels
Message-ID: <20040707225635.GA26832@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John W. Ross <programming@johnwross.com> ha scritto:
> Greetings,
> 
> I've spent several days working to increase the number of IDE channels above
> the 10 allowed in the kernel.
[cut]
> Changed ide.h:
> 
> IDE_NR_PORTS  (10)
> to
> IDE_NR_PORTS  (12)
> 
> In major.h I added:
> 
> #define IDE10_MAJOR     240
> #define IDE11_MAJOR     241
> 
> in ide.c I changed
> 
> static const u8 ide_hwif_to_major[] = { IDE0_MAJOR, IDE1_MAJOR,
>     IDE2_MAJOR, IDE3_MAJOR,
>     IDE4_MAJOR, IDE5_MAJOR,
>     IDE6_MAJOR, IDE7_MAJOR,
>     IDE8_MAJOR, IDE9_MAJOR };
> 
> to :
> 
> static const u8 ide_hwif_to_major[] = { IDE0_MAJOR, IDE1_MAJOR,
>     IDE2_MAJOR, IDE3_MAJOR,
>     IDE4_MAJOR, IDE5_MAJOR,
>     IDE6_MAJOR, IDE7_MAJOR,
>     IDE8_MAJOR, IDE9_MAJOR,
>     IDE10_MAJOR, IDE11_MAJOR)
> 
 
> 1.) Could someone please explain why there is a limit of 10 interfaces (is
> this something that I shouldn't even try)?

Because hwifs are statically allocated, see drivers/ide/ide.c:

ide_hwif_t ide_hwifs[MAX_HWIFS];        /* master data repository */

Also if names are ide0..ide9, the following would be ide: and ide; (see
init_hwif_data in drivers/ide/ide.c).

> 2.)What did I miss on moving to 12?

You can try and set MAX_HWIFS to 12 too (see include/asm-i386/ide.h),
but you may find other problems.

I don't know ide layer very much, I'm sorry but I can't help you more.

Luca
-- 
Home: http://kronoz.cjb.net
Non capisco tutta questa eccitazione per il Multitasking: 
io sono anni che leggo in bagno.
