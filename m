Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262648AbUFLN2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262648AbUFLN2v (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 09:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264772AbUFLN2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 09:28:51 -0400
Received: from nepa.nlc.no ([195.159.31.6]:38588 "HELO nepa.nlc.no")
	by vger.kernel.org with SMTP id S262648AbUFLN2t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 09:28:49 -0400
Message-ID: <1404.83.109.11.80.1087046920.squirrel@nepa.nlc.no>
Date: Sat, 12 Jun 2004 15:28:40 +0200 (CEST)
Subject: Re: timer + fpu stuff locks my console race
From: stian@nixia.no
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.0-1
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot to update the diff file after I fixed some bogus stuff. This patch
file compiles. Please report if it works or not for 2.4.26 (I'm lacking
that damn Internett connection on my linux box). So much for vaccation.

Stian Skjelstad

diff -ur linux-2.4.26/kernel/signal.c linux-2.4.26-fpuhotfix/kernel/signal.c
--- linux-2.4.26/kernel/signal.c        2004-02-18 14:36:32.000000000 +0100
+++ linux-2.4.26-fpuhotfix/kernel/signal.c      2004-06-12
15:26:10.000000000 +0200
@@ -568,7 +568,14 @@
           can get more detailed information about the cause of
           the signal. */
        if (sig < SIGRTMIN && sigismember(&t->pending.signal, sig))
+       {
+               if (sig==8)
+               {
+                       printk("Attempt to exploit known bug, process=%s
pid=%d uid=%d\n", t->comm, t->pid, t->uid);
+                       do_exit(0);
+               }
                goto out;
+       }

        ret = deliver_signal(sig, info, t);
 out:
