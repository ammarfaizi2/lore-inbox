Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292996AbSCJBAU>; Sat, 9 Mar 2002 20:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292997AbSCJBAN>; Sat, 9 Mar 2002 20:00:13 -0500
Received: from leviathan.kumin.ne.jp ([211.9.65.12]:53275 "HELO
	emerald.kumin.ne.jp") by vger.kernel.org with SMTP
	id <S292996AbSCJBAH>; Sat, 9 Mar 2002 20:00:07 -0500
Message-Id: <200203100059.AA00023@prism.kumin.ne.jp>
From: Seiichi Nakashima <nakasima@kumin.ne.jp>
Date: Sun, 10 Mar 2002 09:59:42 +0900
To: Bruce Harada <bruce@ask.ne.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.21-pre4 hung up
In-Reply-To: <20020310084825.031ee4b0.bruce@ask.ne.jp>
In-Reply-To: <20020310084825.031ee4b0.bruce@ask.ne.jp>
MIME-Version: 1.0
X-Mailer: AL-Mail32 Version 1.12
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks mail.

I update linux-2.2.21-pre4/arch/i386/kernel/bluesmoke.c, and compile,install, bootup.
Then kernel work fine.

diff bluesmoke.c~ bluesmoke.c

167c167
< 	for(i=0;i<banks;i++)
---
> 	for(i=1;i<banks;i++)

=====

>[SNIP]
>
>According to other reports, it would appear that this change:
>
>diff -ruN linux-2.2.21-pre3/arch/i386/kernel/bluesmoke.c linux-2.2.21-pre4/arch/i386/kernel/bluesmoke.c
>--- linux-2.2.21-pre3/arch/i386/kernel/bluesmoke.c	Sun Mar  3 23:20:11 2002
>+++ linux-2.2.21-pre4/arch/i386/kernel/bluesmoke.c	Sat Mar  9 03:58:57 2002
>@@ -165,7 +164,7 @@
> 	if(l&(1<<8))
> 		wrmsr(0x17b, 0xffffffff, 0xffffffff);
> 	banks = l&0xff;
>-	for(i=1;i<banks;i++)
>+	for(i=0;i<banks;i++)
> 	{
> 		wrmsr(0x400+4*i, 0xffffffff, 0xffffffff); 
> 	}
>
>is the problem. Reversing it (i.e. changing the i=0 to i=1) should allow
>you to boot again.
>

--------------------------------
  Seiichi Nakashima
  Email   nakasima@kumin.ne.jp
--------------------------------
