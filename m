Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292170AbSBTS0V>; Wed, 20 Feb 2002 13:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292157AbSBTS0L>; Wed, 20 Feb 2002 13:26:11 -0500
Received: from tomts11.bellnexxia.net ([209.226.175.55]:46032 "EHLO
	tomts11-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S292153AbSBTS0B>; Wed, 20 Feb 2002 13:26:01 -0500
Date: Wed, 20 Feb 2002 13:26:18 -0800
From: Jason Yan <jasonyanjk@yahoo.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: paging question
X-mailer: FoxMail 4.0 beta 2 [cn]
Message-Id: <20020220182600.PTIU27257.tomts11-srv.bellnexxia.net@abc337>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a question about the code to enable  to initialize page 
tables in linux/arch/i386/head.S

I search the internet again and again but fail to find any answer
so far, maybe you gurus can help me out, here it goes:

48         cld
49         movl $(__KERNEL_DS),%eax
50         movl %eax,%ds
51         movl %eax,%es
52         movl %eax,%fs
53         movl %eax,%gs
81 /*
82  * Initialize page tables
83  */
84         movl $pg0-__PAGE_OFFSET,%edi /* initialize page tables */
85         movl $007,%eax  /* "007" doesn't mean with right to kill, but
86                                    PRESENT+RW+USER */
87 2:      stosl
88         add $0x1000,%eax
89         cmp $empty_zero_page-__PAGE_OFFSET,%edi
90         jne 2b
   
I remove the SMP code.  According the setup.S, gdt_table is setup as
gdt_table:		
			#.quad 0x0000000000000000;	// null
			#.quad 0x0000000000000000;	// not used
			#.quad 0x00cf9a000000ffff;	// 0x10 kernel 4GB code at 0x00000000
			#.quad 0x00cf92000000ffff;	// 0x18 kernel 4GB data at 0x00000000

1) So, what's in %eax after line 49 ?  0x0 ?
2) Isn't __PAGE_OFFSET 0xC0000000 ? what's the result of $pg0-__PAGE_OFFSET ?

Thanks,

Jason


