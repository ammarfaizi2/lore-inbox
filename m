Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264120AbRFMQkJ>; Wed, 13 Jun 2001 12:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264119AbRFMQj7>; Wed, 13 Jun 2001 12:39:59 -0400
Received: from firewall.ocs.com.au ([203.34.97.9]:4340 "EHLO ocs4.ocs-net")
	by vger.kernel.org with ESMTP id <S264118AbRFMQju>;
	Wed, 13 Jun 2001 12:39:50 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "David S. Miller" <davem@redhat.com>
cc: Andreas Schwab <schwab@suse.de>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.6-pre3 unresolved symbol do_softirq 
In-Reply-To: Your message of "Wed, 13 Jun 2001 07:55:49 MST."
             <15143.32501.395951.374796@pizda.ninka.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 14 Jun 2001 02:39:28 +1000
Message-ID: <18658.992450368@ocs4.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jun 2001 07:55:49 -0700 (PDT), 
"David S. Miller" <davem@redhat.com> wrote:
>
>Andreas Schwab writes:
> > "David S. Miller" <davem@redhat.com> writes:
> > 
> > |> I can't believe there is no reliable way to get rid of that
> > |> pesky "$" gcc is adding to the symbol.  Oh well...
> > 
> > Use %c0.  *Note Output Templates and Operand Substitution: (gcc)Output
> > Template.
>
>Nice, see Keith?  There are no excuses :-)

Oh, there are always excuses ;).  But in this case ...

Index: 6-pre3.1/include/asm-i386/softirq.h
--- 6-pre3.1/include/asm-i386/softirq.h Sat, 09 Jun 2001 11:25:53 +1000 kaos (linux-2.4/T/51_softirq.h 1.3 644)
+++ 6-pre3.1(w)/include/asm-i386/softirq.h Thu, 14 Jun 2001 02:26:16 +1000 kaos (linux-2.4/T/51_softirq.h 1.3 644)
@@ -36,13 +36,13 @@ do {									\
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
 
No changes to kernel/ksyms, it still says EXPORT_SYMBOL(do_softirq);  I like it.

