Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265698AbUFXVFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265698AbUFXVFk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 17:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265697AbUFXVDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 17:03:50 -0400
Received: from mail.dif.dk ([193.138.115.101]:29135 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S264821AbUFXVCv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 17:02:51 -0400
Date: Thu, 24 Jun 2004 23:01:44 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Dave Jones <davej@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Line up CPU caps messages
Message-ID: <Pine.LNX.4.56.0406242237330.28247@jjulnx.backbone.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew,

Here's a patch to line up the "CPU: After * identify, caps:" messages
produced by printk's in arch/i386/kernel/cpu/common.c

Numbers are easier to compare visually when they line up. Both in dmesg
output and in logs. It's also more pleasing ro look at this way in my
oppinion.

I've posted this to lkml previously in a slightly different version that
drew the comments below from hpa & Dave Jones. This patch makes the
changes suggested by them - for inclusion in next -mm maybe?

H. Peter Anvin wrote:
> > Jesper Juhl wrote:
> >
> > /Very/ minor, trivial thing, yes, but those messages have been annoying my
> > eyes for a while now so I desided to make them line up - so, here's the
> > patch that does that (not sure if a signed-off-by line is needed even for
> > trivial stuff like this, but I assume it should go with everything, so...)
> > Patch is against 2.6.7-rc3-mm2
> >
>
> I think that's what the spaces after CPU: was for... apparently that's
> gotten
> forgotten somehow.  Sigh.  Please put the extra spaces all in one place.


The patch below has all spaces in the same place as requested.


Dave Jones wrote:
> On Tue, Jun 15, 2004 at 11:21:44PM +0200, Jesper Juhl wrote:
>
> > Visually it's much easier to read/compare messages such as these
> >
> > Jun 15 19:09:02 dragon kernel: CPU:     After generic identify, caps: 0183f9ff c1c7f9ff 00000000 00000000
> > Jun 15 19:09:02 dragon kernel: CPU:     After vendor identify, caps: 0183f9ff c1c7f9ff 00000000 00000000
> >
> > if the numbers line up like this
> >
> > Jun 15 19:09:02 dragon kernel: CPU:     After generic identify, caps: 0183f9ff c1c7f9ff 00000000 00000000
> > Jun 15 19:09:02 dragon kernel: CPU:     After vendor identify,  caps: 0183f9ff c1c7f9ff 00000000 00000000
>
> I think it's pointless whilst the third 'after all inits' printk remains
> a) unindented  and b) interrupted by other blurb, but in all honesty,
> I don't think it really matters, so I won't object either way if it goes
> in.


The patch below adresses 'a' by indenting the third line similar to the
first two. 'b' I'm not able to do anything about, that's beyond my
abillities currently.


Here's the patch, against 2.6.7-mm2.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.7-mm2-orig/arch/i386/kernel/cpu/common.c	2004-06-24 22:20:43.000000000 +0200
+++ linux-2.6.7-mm2/arch/i386/kernel/cpu/common.c	2004-06-24 22:35:27.000000000 +0200
@@ -329,7 +329,7 @@ void __init identify_cpu(struct cpuinfo_

 	generic_identify(c);

-	printk(KERN_DEBUG "CPU:     After generic identify, caps: %08lx %08lx %08lx %08lx\n",
+	printk(KERN_DEBUG "CPU: After generic identify, caps: %08lx %08lx %08lx %08lx\n",
 		c->x86_capability[0],
 		c->x86_capability[1],
 		c->x86_capability[2],
@@ -338,7 +338,7 @@ void __init identify_cpu(struct cpuinfo_
 	if (this_cpu->c_identify) {
 		this_cpu->c_identify(c);

-	printk(KERN_DEBUG "CPU:     After vendor identify, caps: %08lx %08lx %08lx %08lx\n",
+	printk(KERN_DEBUG "CPU: After vendor identify, caps:  %08lx %08lx %08lx %08lx\n",
 		c->x86_capability[0],
 		c->x86_capability[1],
 		c->x86_capability[2],
@@ -393,7 +393,7 @@ void __init identify_cpu(struct cpuinfo_

 	/* Now the feature flags better reflect actual CPU features! */

-	printk(KERN_DEBUG "CPU:     After all inits, caps: %08lx %08lx %08lx %08lx\n",
+	printk(KERN_DEBUG "CPU: After all inits, caps:        %08lx %08lx %08lx %08lx\n",
 	       c->x86_capability[0],
 	       c->x86_capability[1],
 	       c->x86_capability[2],


--
Jesper Juhl <juhl-lkml@dif.dk>

