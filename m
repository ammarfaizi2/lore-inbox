Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264851AbUFLPVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264851AbUFLPVY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 11:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264853AbUFLPVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 11:21:24 -0400
Received: from zulo.virutass.net ([62.151.20.186]:65240 "EHLO
	mx.larebelion.net") by vger.kernel.org with ESMTP id S264851AbUFLPVU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 11:21:20 -0400
From: Manuel Arostegui Ramirez <manuel@todo-linux.com>
To: Han Boetes <han@mijncomputer.nl>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: new kernel bug
Date: Sat, 12 Jun 2004 17:08:12 +0200
User-Agent: KMail/1.5
References: <200406121159.28406.manuel@todo-linux.com> <200406121442.48691.manuel@todo-linux.com> <20040612150851.GC5922@boetes.org>
In-Reply-To: <20040612150851.GC5922@boetes.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200406121708.12827.manuel@todo-linux.com>
X-Virus: by Larebelion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sábado 12 Junio 2004 17:08, Han Boetes escribió:
> Manuel Arostegui Ramirez wrote:
> > I'm thinking about download patch-2.6.7-rc3, maybe it will fixed that
> > bug.
>
> I just tried and 2.6.7-rc3 doesn't fix this bug. Ow well it's `just' a
> local crash. Annoying but not something big.
>
>
Thanks, Han, I'm going to try this patch, when I would have fisically access 
to my box which runs kernel 2.4.20-8.
This is the orignaly thread for this discussion.
http://marc.theaimsgroup.com/?l=linux-kernel&m=108705340404567&w=2

This is the patch I'm going to try, Han:

stian@nixia.no wrote:

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


-- 
Manuel Arostegui Ramirez #Linux Registered User 200896

