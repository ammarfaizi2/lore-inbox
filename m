Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316681AbSFUQoR>; Fri, 21 Jun 2002 12:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316683AbSFUQoQ>; Fri, 21 Jun 2002 12:44:16 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:49341 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S316681AbSFUQoP>;
	Fri, 21 Jun 2002 12:44:15 -0400
Date: Fri, 21 Jun 2002 18:44:07 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200206211644.SAA14317@harpo.it.uu.se>
To: ak@suse.de
Subject: Re: 2.5.23+ bootflag.c triggers __iounmap: bad address
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jun 2002 14:43:41 +0200, Andi Kleen wrote:
>> __iounmap: bad address c4800009
>> __iounmap: bad address c4804b8c
>> __iounmap: bad address c4802009
>> 
>> These warnings/errors are new since 2.5.23, which makes me
>> suspect something's wrong in the 2.5.23 iounmap changes.
>
>Does this patch fix it?
>
>
>-Andi
>
>
>
>--- linux-2.5.23-work/arch/i386/mm/ioremap.c.~2~	Tue Jun 18 02:13:09 2002
>+++ linux-2.5.23-work/arch/i386/mm/ioremap.c	Fri Jun 21 14:42:23 2002
>@@ -213,9 +213,9 @@
> void iounmap(void *addr)
> { 
> 	struct vm_struct *p;
>-	if (addr < high_memory) 
>+	if (addr <= high_memory) 
> 		return; 
>-	p = remove_kernel_area(addr); 
>+	p = remove_kernel_area(PAGE_MASK & (unsigned long) addr); 
> 	if (!p) { 
> 		printk("__iounmap: bad address %p\n", addr);
> 		return;
>

Yes, that fixed the problem on the two machines I mentioned.
Thanks.

/Mikael
