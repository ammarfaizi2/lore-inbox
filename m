Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269627AbUICLxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269627AbUICLxn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 07:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269637AbUICLxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 07:53:42 -0400
Received: from mx1.elte.hu ([157.181.1.137]:57551 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269627AbUICLxh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 07:53:37 -0400
Date: Fri, 3 Sep 2004 13:55:05 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: linux-kernel@vger.kernel.org, rlrevell@joe-job.com,
       felipe_alfaro@linuxmail.org
Subject: Re: lockup with voluntary preempt R0 and VP, KP, etc, disabled
Message-ID: <20040903115505.GB29493@elte.hu>
References: <20040903120957.00665413@mango.fruits.de> <20040903100946.GA22819@elte.hu> <20040903123139.565c806b@mango.fruits.de> <20040903103244.GB23726@elte.hu> <20040903135919.719db41d@mango.fruits.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="neYutvxvOLaeuPCA"
Content-Disposition: inline
In-Reply-To: <20040903135919.719db41d@mango.fruits.de>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Florian Schmidt <mista.tapas@gmx.net> wrote:

> [<c0105e29>] do_signal+0x79/0x110
> [<c01162a0>] default_wake_function+0x0/0x20
>   c012fgd7   do_futex+0x47/0xa0
>   c012fb20   sys_futex
>   c0103f07   do_notify
>   c01060e6   work_notifysig
>
> Code: 96 54 01 00 00 8e e0 8e e8 85 d2 74 11 c7 86 54 01 00 00 00 00 00
> 00 89 d0 e8 bb e4 ff 8b 9e 5c 01 00 00 85 db 74 09 8b 45 0c <8b> 40 20
> 48 78 08 8b 5d f8 8b 75 fc c9 c3 c7 86 56 01 00 00 00 
> <6> note: scsynth exited with preempt count 1

it seems the first crash scrolled off and we dont really know what
happened ... Could you apply the attached patch - it will shut the
console off and freeze the box after printing the first oops.

	Ingo

--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="print-single-oops.patch"

--- linux/arch/i386/kernel/traps.c.orig
+++ linux/arch/i386/kernel/traps.c
@@ -256,6 +256,9 @@ void show_registers(struct pt_regs *regs
 		}
 	}
 	printk("\n");
+	console_silent();
+	for (;;)
+		local_irq_disable();
 }	
 
 static void handle_BUG(struct pt_regs *regs)

--neYutvxvOLaeuPCA--
