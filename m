Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264169AbRFRPQG>; Mon, 18 Jun 2001 11:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264203AbRFRPP4>; Mon, 18 Jun 2001 11:15:56 -0400
Received: from mx5.sac.fedex.com ([199.81.194.37]:2822 "EHLO mx5.sac.fedex.com")
	by vger.kernel.org with ESMTP id <S264174AbRFRPPi>;
	Mon, 18 Jun 2001 11:15:38 -0400
Date: Mon, 18 Jun 2001 23:15:07 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: <root@boston.corp.fedex.com>
To: "Mohammad A. Haque" <mhaque@haque.net>
cc: Anuradha Ratnaweera <anuradha@bee.lk>,
        Jeff Chua <jchua@silk.corp.fedex.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Unresolved symbol do_softirq in 2.4.6-pre3
In-Reply-To: <Pine.LNX.4.33.0106181017300.6188-100000@viper.haque.net>
Message-ID: <Pine.LNX.4.33.0106182313450.6088-100000@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jun 2001, Mohammad A. Haque wrote:

> On Mon, 18 Jun 2001, Anuradha Ratnaweera wrote:
>
> > I started running 2.4.6-pre3 using the same configuration file as 2.4.5.
> > Diff shows no effective differences between two config files.
> >
> > depmod complains unresolved symbols (do_softirq) in ppp_generic, ppp_async
> > and sunrpc.
> >
>
> Please check the list archives. A possible solution was posted by Keith
> owens
> <http://marc.theaimsgroup.com/?l=linux-kernel&m=99245070328459&w=2>.

Try this ...

Jeff.


--- include/asm-i386/softirq.h	Thu Jun 14 17:10:34 2001
+++ include/asm-i386/softirq.h.new	Thu Jun 14 17:17:15 2001
@@ -36,13 +36,13 @@
 									\
 			".section .text.lock,\"ax\";"			\
 			"2: pushl %%eax; pushl %%ecx; pushl %%edx;"	\
-			"call do_softirq;"				\
+			"call %c1;"					\
 			"popl %%edx; popl %%ecx; popl %%eax;"		\
 			"jmp 1b;"					\
 			".previous;"					\
 									\
 		: /* no output */					\
-		: "r" (ptr)						\
+		: "r" (ptr), "i" (do_softirq)				\
 		/* no registers clobbered */ );				\
 } while (0)


