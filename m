Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313207AbSDDPyx>; Thu, 4 Apr 2002 10:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313210AbSDDPyl>; Thu, 4 Apr 2002 10:54:41 -0500
Received: from [195.63.194.11] ([195.63.194.11]:28179 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313207AbSDDPy3>; Thu, 4 Apr 2002 10:54:29 -0500
Message-ID: <3CAC68B5.2040505@evision-ventures.com>
Date: Thu, 04 Apr 2002 16:52:37 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE/SUPPORT_VLB_SYNC in 2.5.x
In-Reply-To: <Pine.GSO.4.21.0204041740550.28139-100000@vervain.sonytel.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven wrote:
> SUPPORT_VLB_SYNC is now unconditionally hardcoded to 1 in
> drivers/ide/ide-taskfile.c.
> 
> While most architectures disable it, which no longer works:
> 
> | tux$ find include -type f | xargs grep SUPPORT_VLB_SYNC
> | include/asm-cris/ide.h:#undef SUPPORT_VLB_SYNC
> | include/asm-cris/ide.h:#define SUPPORT_VLB_SYNC 0
> | include/asm-m68k/ide.h:#undef SUPPORT_VLB_SYNC
> | include/asm-m68k/ide.h:#define SUPPORT_VLB_SYNC 0
> | include/asm-mips/ide.h:#undef  SUPPORT_VLB_SYNC
> | include/asm-mips/ide.h:#define SUPPORT_VLB_SYNC 0
> | include/asm-ppc/ide.h:#undef	SUPPORT_VLB_SYNC
> | include/asm-ppc/ide.h:#define SUPPORT_VLB_SYNC	0
> | include/asm-sparc/ide.h:#undef  SUPPORT_VLB_SYNC
> | include/asm-sparc/ide.h:#define SUPPORT_VLB_SYNC 0
> | include/asm-sparc64/ide.h:#undef  SUPPORT_VLB_SYNC
> | include/asm-sparc64/ide.h:#define SUPPORT_VLB_SYNC 0
> | include/linux/ide.h:#ifndef SUPPORT_VLB_SYNC		/* 1 to support weird 32-bit chips */
> | include/linux/ide.h:#define SUPPORT_VLB_SYNC	1	/* 0 to reduce kernel size */
> 
> Wouldn't it be better to enable it on architectures which can have a VESA local
> bus (ia32 only?) only?

Thank you for pointing it out. Of course it just shouldn't be enabled
unconditionally there. Apparently it "slipped in" during some
compiling for "code coverage". My appologies for the inconvenience.
It will be disabled in the next patch round.

