Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292982AbSCIXs7>; Sat, 9 Mar 2002 18:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292983AbSCIXsk>; Sat, 9 Mar 2002 18:48:40 -0500
Received: from pl100.nas921.ichikawa.nttpc.ne.jp ([210.165.234.100]:25627 "EHLO
	mbr.sphere.ne.jp") by vger.kernel.org with ESMTP id <S292982AbSCIXsa>;
	Sat, 9 Mar 2002 18:48:30 -0500
Date: Sun, 10 Mar 2002 08:48:25 +0900
From: Bruce Harada <bruce@ask.ne.jp>
To: Seiichi Nakashima <nakasima@kumin.ne.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.21-pre4 hung up
Message-Id: <20020310084825.031ee4b0.bruce@ask.ne.jp>
In-Reply-To: <200203092312.AA00022@prism.kumin.ne.jp>
In-Reply-To: <200203092312.AA00022@prism.kumin.ne.jp>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.6; i686-pc-linux-gnu)
X-Face: $qrUU,Lz=B[A}i%m2Rg^Ik;~V@]$Ay)$S`wUf3:^aZ1UdLf,_;1y7_xbEh=Yv*wB0=Fv]a1hj14_qQsl[f1KX]q4IdhwmSIeP6>Ap@[e$c$G;;ObLI7?Y<H5";4<{GAPoak2U)!da]-ZJb}!.#>Xsq*)M'3Jp<M,l~'4F{qWpM$%"%p'
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Mar 2002 08:12:28 +0900
Seiichi Nakashima <nakasima@kumin.ne.jp> wrote:

> Hi.
> 
> I update to linux-2.2.20 + patch-2.2.21-pre4.
> before I used linux-2.2.20 + patch-2.2.21-pre3, and worked fine.
> linux-2.2.21-pre4 is normal end to patch, compile and install, but bootup
> failuer.

[SNIP]

According to other reports, it would appear that this change:

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

is the problem. Reversing it (i.e. changing the i=0 to i=1) should allow
you to boot again.


