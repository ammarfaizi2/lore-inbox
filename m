Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292654AbSBURUe>; Thu, 21 Feb 2002 12:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292659AbSBURUZ>; Thu, 21 Feb 2002 12:20:25 -0500
Received: from host213-121-106-53.in-addr.btopenworld.com ([213.121.106.53]:2284
	"HELO mail.dark.lan") by vger.kernel.org with SMTP
	id <S292657AbSBURUN>; Thu, 21 Feb 2002 12:20:13 -0500
Subject: Re: paging question
From: Gianni Tedesco <gianni@ecsc.co.uk>
To: Jason Yan <jasonyanjk@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020220182600.PTIU27257.tomts11-srv.bellnexxia.net@abc337>
In-Reply-To: <20020220182600.PTIU27257.tomts11-srv.bellnexxia.net@abc337>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 21 Feb 2002 17:20:10 +0000
Message-Id: <1014312010.8529.4.camel@lemsip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-02-20 at 21:26, Jason Yan wrote:
> Hi,
> 
> I have a question about the code to enable  to initialize page 
> tables in linux/arch/i386/head.S
> 
> I search the internet again and again but fail to find any answer
> so far, maybe you gurus can help me out, here it goes:
> 
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

0x18, its the index of the 4th item in GDT. Lines 49-53 set the segment
registers to use the settings in gdt[3];

> 2) Isn't __PAGE_OFFSET 0xC0000000 ? what's the result of $pg0-__PAGE_OFFSET ?

the physical address of $pg0, the kernel is linked to PAGE_OFFSET so it
thinks the address of $pg0 is PAGE_OFFSET+something. Suptracting
PAGE_OFFSET is the simple way to obtain the physical address.

-- 
// Gianni Tedesco <gianni@ecsc.co.uk>
80% of all email is a figment of procmails imagination.

