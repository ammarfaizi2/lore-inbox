Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265961AbUFOVp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265961AbUFOVp2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 17:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265959AbUFOVp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 17:45:28 -0400
Received: from mail.dif.dk ([193.138.115.101]:61867 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S265961AbUFOVpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 17:45:25 -0400
Date: Tue, 15 Jun 2004 23:44:33 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Very Trivial - make "After * identify, caps:" messages
 line up
In-Reply-To: <20040615213330.GA6471@redhat.com>
Message-ID: <Pine.LNX.4.56.0406152338100.9908@jjulnx.backbone.dif.dk>
References: <Pine.LNX.4.56.0406152310390.9908@jjulnx.backbone.dif.dk>
 <20040615213330.GA6471@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2004, Dave Jones wrote:

> On Tue, Jun 15, 2004 at 11:21:44PM +0200, Jesper Juhl wrote:
>
>  > Visually it's much easier to read/compare messages such as these
>  >
>  > Jun 15 19:09:02 dragon kernel: CPU:     After generic identify, caps: 0183f9ff c1c7f9ff 00000000 00000000
>  > Jun 15 19:09:02 dragon kernel: CPU:     After vendor identify, caps: 0183f9ff c1c7f9ff 00000000 00000000
>  >
>  > if the numbers line up like this
>  >
>  > Jun 15 19:09:02 dragon kernel: CPU:     After generic identify, caps: 0183f9ff c1c7f9ff 00000000 00000000
>  > Jun 15 19:09:02 dragon kernel: CPU:     After vendor identify,  caps: 0183f9ff c1c7f9ff 00000000 00000000
>
> I think it's pointless whilst the third 'after all inits' printk remains
> a) unindented

Agreed, since only the first two end up in the same log on my system
that's all I'd noticed, but yes, it would make sense to indent the third
as well to make dmesg output look nice as well.

> and b) interrupted by other blurb,

unfortunately, yes, but I'm /not/ going to try and change that :)

>but in all honesty,
> I don't think it really matters, so I won't object either way if it goes in.
>
Ok, thank you for taking a look.

Here's an updated patch that indents the second line a little different
than with the first patch and also indents the "After all ..." line to
match.
Still against 2.6.7-rc3-mm2

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.7-rc3-mm2-orig/arch/i386/kernel/cpu/common.c	2004-06-09 03:34:40.000000000 +0200
+++ linux-2.6.7-rc3-mm2/arch/i386/kernel/cpu/common.c	2004-06-15 23:39:45.000000000 +0200
@@ -338,7 +338,7 @@ void __init identify_cpu(struct cpuinfo_
 	if (this_cpu->c_identify) {
 		this_cpu->c_identify(c);

-	printk(KERN_DEBUG "CPU:     After vendor identify, caps: %08lx %08lx %08lx %08lx\n",
+	printk(KERN_DEBUG "CPU:     After vendor identify, caps:  %08lx %08lx %08lx %08lx\n",
 		c->x86_capability[0],
 		c->x86_capability[1],
 		c->x86_capability[2],
@@ -393,7 +393,7 @@ void __init identify_cpu(struct cpuinfo_

 	/* Now the feature flags better reflect actual CPU features! */

-	printk(KERN_DEBUG "CPU:     After all inits, caps: %08lx %08lx %08lx %08lx\n",
+	printk(KERN_DEBUG "CPU:     After all inits, caps:        %08lx %08lx %08lx %08lx\n",
 	       c->x86_capability[0],
 	       c->x86_capability[1],
 	       c->x86_capability[2],


--
Jesper Juhl <juhl-lkml@dif.dk>

