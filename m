Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273488AbRIUMea>; Fri, 21 Sep 2001 08:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273487AbRIUMeU>; Fri, 21 Sep 2001 08:34:20 -0400
Received: from mail.ask.ne.jp ([203.179.96.3]:35045 "EHLO mail.ask.ne.jp")
	by vger.kernel.org with ESMTP id <S273489AbRIUMeH>;
	Fri, 21 Sep 2001 08:34:07 -0400
Date: Fri, 21 Sep 2001 21:31:56 +0900
From: Bruce Harada <bruce@ask.ne.jp>
To: Mikael Djurfeldt <djurfeldt@nada.kth.se>, martin@jtrix.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10-pre12: IO_APIC_init_uniprocessor
Message-Id: <20010921213156.061abcf6.bruce@ask.ne.jp>
In-Reply-To: <E15jyPh-0001QM-00@mdj.nada.kth.se>
In-Reply-To: <E15jyPh-0001QM-00@mdj.nada.kth.se>
X-Mailer: Sylpheed version 0.6.2 (GTK+ 1.2.6; i686-pc-linux-gnu)
X-Face: $qrUU,Lz=B[A}i%m2Rg^Ik;~V@]$Ay)$S`wUf3:^aZ1UdLf,_;1y7_xbEh=Yv*wB0=Fv]a1hj14_qQsl[f1KX]q4IdhwmSIeP6>Ap@[e$c$G;;ObLI7?Y<H5";4<{GAPoak2U)!da]-ZJb}!.#>Xsq*)M'3Jp<M,l~'4F{qWpM$%"%p'
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Sep 2001 09:38:25 +0200
Mikael Djurfeldt <mdj@mdj.nada.kth.se> wrote:

> I have the APIC option enabled in my configuration.
> 
> When compiling 2.4.10-pre12, the call to IO_APIC_init_uniprocessor in
> init/main.c is not resolved.  In fact, searching for this symbol, I
> didn't find it anywhere else in the kernel source.

On Thu, 20 Sep 2001 08:55:38 +0100
Martin Brooks <martin@jtrix.com> wrote:

> init/main.o: In function `smp_init':
> init/main.o(.text.init+0x74d): undefined reference to 
> `IO_APIC_init_uniprocessor'
> make: *** [vmlinux] Error 1
> 
> 
> I'm not subscribed, please CC.

Patch from Keith Owens below. Please make sure to search the l-k archives for
compile problems such as this - there's always a good chance that someone will
have hit the same problem before.


--------------- Patch starts -----------------

Index: 10-pre12.1/init/main.c
--- 10-pre12.1/init/main.c Fri, 06 Jul 2001 09:49:24 +1000 kaos (linux-2.4/k/11_main.c 1.1.5.1.1.8.1.3 644)
+++ 10-pre12.1(w)/init/main.c Wed, 19 Sep 2001 21:28:17 +1000 kaos (linux-2.4/k/11_main.c 1.1.5.1.1.8.1.3 644)
@@ -483,7 +483,7 @@ extern void cpu_idle(void);
 #ifdef CONFIG_X86_IO_APIC
 static void __init smp_init(void)
 {
-	IO_APIC_init_uniprocessor();
+	APIC_init_uniprocessor();
 }
 #else
 #define smp_init()	do { } while (0)

---------------- Patch ends -------------------
