Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292267AbSBTT4k>; Wed, 20 Feb 2002 14:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292255AbSBTT4i>; Wed, 20 Feb 2002 14:56:38 -0500
Received: from toole.uol.com.br ([200.231.206.186]:21149 "EHLO
	toole.uol.com.br") by vger.kernel.org with ESMTP id <S292259AbSBTT4A>;
	Wed, 20 Feb 2002 14:56:00 -0500
Date: Wed, 20 Feb 2002 16:55:54 -0300 (BRT)
From: Cesar Suga <sartre@linuxbr.com>
To: Jason Yan <jasonyanjk@yahoo.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: paging question
In-Reply-To: <20020220182600.PTIU27257.tomts11-srv.bellnexxia.net@abc337>
Message-ID: <Pine.LNX.4.40.0202201644440.2737-100000@sartre.linuxbr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2002, Jason Yan wrote:

> I have a question about the code to enable  to initialize page
> tables in linux/arch/i386/head.S

> I search the internet again and again but fail to find any answer
> so far, maybe you gurus can help me out, here it goes:

> 48         cld
> 49         movl $(__KERNEL_DS),%eax
> 50         movl %eax,%ds
> 51         movl %eax,%es
> 52         movl %eax,%fs
> 53         movl %eax,%gs
> 81 /*
> 82  * Initialize page tables
> 83  */
> 84         movl $pg0-__PAGE_OFFSET,%edi /* initialize page tables */
> 85         movl $007,%eax  /* "007" doesn't mean with right to kill, but
> 86                                    PRESENT+RW+USER */
> 87 2:      stosl
> 88         add $0x1000,%eax
> 89         cmp $empty_zero_page-__PAGE_OFFSET,%edi
> 90         jne 2b
>
> I remove the SMP code.  According the setup.S, gdt_table is setup as
> gdt_table:
> 			#.quad 0x0000000000000000;	// null
> 			#.quad 0x0000000000000000;	// not used
> 			#.quad 0x00cf9a000000ffff;	// 0x10 kernel 4GB code at 0x00000000
> 			#.quad 0x00cf92000000ffff;	// 0x18 kernel 4GB data at 0x00000000
>
> 1) So, what's in %eax after line 49 ?  0x0 ?

	As in asm/segment.h (included on arch/i386/kernel/head.S): (i386)

#ifndef _ASM_SEGMENT_H
#define _ASM_SEGMENT_H

#define __KERNEL_CS     0x10
#define __KERNEL_DS     0x18

	uaccess.h specifies another value, but that's KERNEL_DS for user
space memory.

> 2) Isn't __PAGE_OFFSET 0xC0000000 ? what's the result of $pg0-__PAGE_OFFSET ?

	Yes, __PAGE_OFFSET is 0xC0000000. I am not sure, but I think it
initializes the page tables to 8MB here, and the final page tables depend
on the memory size (better seeing pgtable.h)...

	Regards,
	Cesar Suga <sartre@linuxbr.com>


