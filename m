Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292751AbSCINbn>; Sat, 9 Mar 2002 08:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292762AbSCINbe>; Sat, 9 Mar 2002 08:31:34 -0500
Received: from 1Cust74.tnt6.lax7.da.uu.net ([67.193.244.74]:27118 "HELO
	cx518206-b.irvn1.occa.home.com") by vger.kernel.org with SMTP
	id <S292761AbSCINbS>; Sat, 9 Mar 2002 08:31:18 -0500
Subject: [BUG][PATCH] boot failure Re: Linux 2.2.21pre4
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Sat, 9 Mar 2002 05:29:23 -0800 (PST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16jWBa-0008Nc-00@the-village.bc.nu> from "Alan Cox" at Mar 09, 2002 02:02:14 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20020309132923.DA930895B2@cx518206-b.irvn1.occa.home.com>
From: barryn@pobox.com (Barry K. Nathan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Please save any 2.2 updates for 2.2.22pre from now on unless they are
> clear bug fixes. I hope to do a 2.2.21rc1 next
> 
> 2.2.21pre4
[snip]
> o	Fix MCE address reporting order, fix oops with	(Dave Jones)
> 	newer gcc due to bad asm constraints

Hmmm... I have a computer here that freezes at this point in the boot
process with 2.2.21-pre4:

...
CPU: L2 cache: 128K
Intel machine check architecture supported.

Reversing the following change to bluesmoke.c lets this computer boot
again like it does with 2.2.21-pre3. The computer in question has a 533MHz
Intel Celeron (the Pentium II-based kind).

-Barry K. Nathan <barryn@pobox.com>

diff -ruN linux-2.2.21-pre3/arch/i386/kernel/bluesmoke.c linux-2.2.21-pre4/arch/i386/kernel/bluesmoke.c
--- linux-2.2.21-pre3/arch/i386/kernel/bluesmoke.c	Sun Mar  3 23:20:11 2002
+++ linux-2.2.21-pre4/arch/i386/kernel/bluesmoke.c	Sat Mar  9 03:58:57 2002
@@ -165,7 +164,7 @@
 	if(l&(1<<8))
 		wrmsr(0x17b, 0xffffffff, 0xffffffff);
 	banks = l&0xff;
-	for(i=1;i<banks;i++)
+	for(i=0;i<banks;i++)
 	{
 		wrmsr(0x400+4*i, 0xffffffff, 0xffffffff); 
 	}
