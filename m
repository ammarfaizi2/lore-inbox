Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbVJCGdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbVJCGdN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 02:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbVJCGdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 02:33:13 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:29669 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932162AbVJCGdM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 02:33:12 -0400
Date: Mon, 3 Oct 2005 08:33:53 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Felix Oxley <lkml@oxley.org>
Cc: linux-kernel@vger.kernel.org, ralf@linux-mips.org
Subject: Re: 2.6.14-rc3-rt1
Message-ID: <20051003063353.GC23241@elte.hu>
References: <20050913100040.GA13103@elte.hu> <20050926070210.GA5157@elte.hu> <20051002151817.GA7228@elte.hu> <200510022151.51133.lkml@oxley.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200510022151.51133.lkml@oxley.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Felix Oxley <lkml@oxley.org> wrote:

> I have a compile error in drivers/net/hamradio/mkiss.c
> 
> 	CC [M]  drivers/net/hamradio/mkiss.o
> 	drivers/net/hamradio/mkiss.c:625: error: 
> 	RW_LOCK_UNLOCKED’ undeclared here (not in a function)
> 
> Due to the fact that
> 
> 	RW_LOCK_UNLOCKED 
> 
> has not been converted to the form
> 
> 	RW_LOCK_UNLOCKED(name.lock)
> 
> by the RT patch.

i've applied the cleanup below to my tree - it might as well go upstream 
too, it's slightly more compact than the explicit initializer.

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

Index: linux/drivers/net/hamradio/mkiss.c
===================================================================
--- linux.orig/drivers/net/hamradio/mkiss.c
+++ linux/drivers/net/hamradio/mkiss.c
@@ -622,7 +622,7 @@ static void ax_setup(struct net_device *
  * best way to fix this is to use a rwlock in the tty struct, but for now we
  * use a single global rwlock for all ttys in ppp line discipline.
  */
-static rwlock_t disc_data_lock = RW_LOCK_UNLOCKED;
+static DEFINE_RWLOCK(disc_data_lock);
 
 static struct mkiss *mkiss_get(struct tty_struct *tty)
 {
