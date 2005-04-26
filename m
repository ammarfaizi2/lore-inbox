Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261823AbVDZW2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbVDZW2v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 18:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbVDZW2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 18:28:51 -0400
Received: from mailfe09.swip.net ([212.247.155.1]:51107 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261823AbVDZW2s convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 18:28:48 -0400
X-T2-Posting-ID: k1c2aGMK8Lj9Cnpb+Eju4eOhqUzXuhsckJNC9B9P7R8=
Date: Wed, 27 Apr 2005 00:31:36 +0200
From: Frederik Deweerdt <dev.deweerdt@laposte.net>
To: linux-kernel@vger.kernel.org
Cc: juhl-lkml@dif.dk
Subject: Re: [PATCH] Don't oops when unregistering unknown kprobes
Message-ID: <20050426223136.GH27406@gilgamesh.home.res>
Mail-Followup-To: linux-kernel@vger.kernel.org, juhl-lkml@dif.dk
References: <20050426162203.GE27406@gilgamesh.home.res> <20050426162751.GD32766@in.ibm.com> <20050426214241.GF27406@gilgamesh.home.res> <Pine.LNX.4.62.0504262349160.2071@dragon.hyggekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0504262349160.2071@dragon.hyggekrogen.localhost>
User-Agent: Mutt/1.5.6i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 27/04/05 00:09 +0200, Jesper Juhl écrivit:
> On Tue, 26 Apr 2005, Frederik Deweerdt wrote:
> Seems to me this will end up calling spin_lock_irqsave() twice, but only 
> spin_unlock_irqrestore once in the non-failing case... hmm..

Indeed, I made an obvious mistake there, sorry.

> 
> Also, as Chris Wedgwood asked, why not simply  return -EINVAL;  instead of 
> the printk()?  Does the user really care that we tried to unregister a 
> nonexisting kprobe? and if you really think someone would like to know 
> then I'd personally say that KERN_DEBUG should be sufficient.

I wanted to make the patch minimal, but it does make sense. 

> I'd suggest something like this :
> [ ... ]

You should also change the prototype in include/kernel/kprobes.h:

--- linux-2.6.12-rc3/include/linux/kprobes.h    2005-03-02 08:37:50.000000000 +0100
+++ linux-2.6.12-rc3-devel/include/linux/kprobes.h      2005-04-27 00:23:09.000000000 +0200
@@ -103,7 +103,7 @@ extern void show_registers(struct pt_reg
 struct kprobe *get_kprobe(void *addr);
 
 int register_kprobe(struct kprobe *p);
-void unregister_kprobe(struct kprobe *p);
+int unregister_kprobe(struct kprobe *p);
 int setjmp_pre_handler(struct kprobe *, struct pt_regs *);
 int longjmp_break_handler(struct kprobe *, struct pt_regs *);
 int register_jprobe(struct jprobe *p);

Regards,
Frederik
PS: I've fixed my mailing habits, sorry for inconvenience :)

-- 
o----------------------------------------------o
| http://open-news.net : l'info alternative    |
| Tech - Sciences - Politique - International  |
o----------------------------------------------o
