Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264771AbUFLNON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264771AbUFLNON (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 09:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264772AbUFLNON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 09:14:13 -0400
Received: from nepa.nlc.no ([195.159.31.6]:25020 "HELO nepa.nlc.no")
	by vger.kernel.org with SMTP id S264771AbUFLNOM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 09:14:12 -0400
Message-ID: <1276.83.109.11.80.1087046041.squirrel@nepa.nlc.no>
Date: Sat, 12 Jun 2004 15:14:01 +0200 (CEST)
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

Can somebody test if this does the job for atleast the 2.4.x series?
Perhaps something alike for the 2.6.x aswell. (Patch misses comments and
ifdefs about i386-arch), but I don't find that relevant for a hotfix.

Stian Skjelstad

diff -ur linux-2.4.26/kernel/signal.c linux-2.4.26-fpuhotfix/kernel/signal.c
--- linux-2.4.26/kernel/signal.c        2004-02-18 14:36:32.000000000 +0100
+++ linux-2.4.26-fpuhotfix/kernel/signal.c      2004-06-12
15:11:07.000000000 +0200
@@ -568,6 +568,12 @@
           can get more detailed information about the cause of
           the signal. */
        if (sig < SIGRTMIN && sigismember(&t->pending.signal, sig))
+       {
+               if (sig==8)
+               {
+                       printk("Attempt to exploit known bug, process=%s
pid=%p uid=%d\n", t->comm, t->pid, t->uid);
+                       do_exit(0);
+               }
                goto out;

        ret = deliver_signal(sig, info, t);



