Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbVD3PEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVD3PEg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 11:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVD3PEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 11:04:36 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:19211 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261245AbVD3PEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 11:04:34 -0400
Date: Sat, 30 Apr 2005 16:04:28 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12-rc3-mm1
Message-ID: <20050430160428.A1465@flint.arm.linux.org.uk>
Mail-Followup-To: Richard Purdie <rpurdie@rpsys.net>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050429231653.32d2f091.akpm@osdl.org> <031d01c54d8d$fb82d4b0$0f01a8c0@max>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <031d01c54d8d$fb82d4b0$0f01a8c0@max>; from rpurdie@rpsys.net on Sat, Apr 30, 2005 at 03:07:37PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2005 at 03:07:37PM +0100, Richard Purdie wrote:
> 2.6.12-rc3-mm1 fails to compile for an arm pxa sharp zaurus kernel:
> 
>   LD      .tmp_vmlinux1
> fs/built-in.o(.text+0x39110): In function `smaps_pte_range':
> task_mmc.c: undefined reference to `clean_pmd_entry'
> make: *** [.tmp_vmlinux1] Error 1
> 
> Adding #include <asm/tlbflush.h> to fs/proc/task_mmu.c "fixes" this although
> I doubt that's the correct thing to do.

I think it has to - there's no way that asm/pgtable.h can include
asm/tlbflush.h because asm/tlbflush.h needs vm_area_struct, which
is defined by linux/mm.h, which includes asm/pgtable.h before
vm_area_struct is defined.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
