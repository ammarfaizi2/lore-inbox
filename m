Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292259AbSBTT4k>; Wed, 20 Feb 2002 14:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292262AbSBTT4d>; Wed, 20 Feb 2002 14:56:33 -0500
Received: from tomts21-srv.bellnexxia.net ([209.226.175.183]:2296 "EHLO
	tomts21-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S292253AbSBTTzW>; Wed, 20 Feb 2002 14:55:22 -0500
Date: Wed, 20 Feb 2002 14:54:44 -0800
From: Jason Yan <jasonyanjk@yahoo.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: initialize page tables --  Re: paging question
X-mailer: FoxMail 4.0 beta 2 [cn]
Message-Id: <20020220195513.EIBW1236.tomts21-srv.bellnexxia.net@abc337>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Dick

Oops, I use a wrong subject, what I want to ask is how the pg0 be initialized

in head.S,

395 .org 0x2000
396 ENTRY(pg0)

so $pg0-__PAGE_OFFSET = 0x2000 - 0xC0000000 = 40002000, how comes bff00000 ?

>84 movl $pg0-_PAGE_OFFSET,%edi

%edi = bff00000 (or 40002000) ?

>87 2:      stosl

that's  move %eax  to  %es:%edi, __KERNEL_DS = 0x18, so %es is 0x18, according the gdt_table, 0x00cf92000000ffff, the base linear address is 0x00000000, that means
%es:%edi = bff00000 (or 40002000), how can the %eax be moved into an nonexist ram, 
cause at that time, no page directory and and page table yet.

Anyway, thank you for your help.

Regards,

Jason  

>> 48         cld
>> 49         movl $(__KERNEL_DS),eax
>> 50         movl eax,ds
>> 51         movl eax,es
>> 52         movl eax,fs
>> 53         movl eax,gs
>> 81 /*
>> 82  * Initialize page tables
>> 83  */
>> 84         movl $pg0-__PAGE_OFFSET,edi /* initialize page tables */
>> 85         movl $007,eax  /* "007" doesn't mean with right to kill, but
>> 86                                    PRESENT+RW+USER */
>> 87 2:      stosl
>> 88         add $0x1000,eax
>> 89         cmp $empty_zero_page-__PAGE_OFFSET,edi
>> 90         jne 2b
>>    
>> I remove the SMP code.  According the setup.S, gdt_table is setup as
>> gdt_table:		
>> 			#.quad 0x0000000000000000;	// null
>> 			#.quad 0x0000000000000000;	// not used
>> 			#.quad 0x00cf9a000000ffff;	// 0x10 kernel 4GB code at 0x00000000
>> 			#.quad 0x00cf92000000ffff;	// 0x18 kernel 4GB data at 0x00000000
>> 
>> 1) So, what's in eax after line 49 ?  0x0 ?
>> 2) Isn't __PAGE_OFFSET 0xC0000000 ? what's the result of $pg0-__PAGE_OFFSET ?
>> 
>> Thanks,
>> 
>> Jason
>


