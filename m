Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265971AbUFOVv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265971AbUFOVv5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 17:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265972AbUFOVv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 17:51:57 -0400
Received: from mail.dif.dk ([193.138.115.101]:22956 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S265971AbUFOVvy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 17:51:54 -0400
Date: Tue, 15 Jun 2004 23:51:02 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@codemonkey.org.uk>
Subject: Re: [PATCH] Very Trivial - make "After * identify, caps:" messages
 line up
In-Reply-To: <40CF6DF7.8070304@zytor.com>
Message-ID: <Pine.LNX.4.56.0406152347580.9908@jjulnx.backbone.dif.dk>
References: <Pine.LNX.4.56.0406152310390.9908@jjulnx.backbone.dif.dk>
 <40CF6DF7.8070304@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2004, H. Peter Anvin wrote:

> Jesper Juhl wrote:
> > Visually it's much easier to read/compare messages such as these
> >
> > Jun 15 19:09:02 dragon kernel: CPU:     After generic identify, caps: 0183f9ff c1c7f9ff 00000000 00000000
> > Jun 15 19:09:02 dragon kernel: CPU:     After vendor identify, caps: 0183f9ff c1c7f9ff 00000000 00000000
> >
> > if the numbers line up like this
> >
> > Jun 15 19:09:02 dragon kernel: CPU:     After generic identify, caps: 0183f9ff c1c7f9ff 00000000 00000000
> > Jun 15 19:09:02 dragon kernel: CPU:     After vendor identify,  caps: 0183f9ff c1c7f9ff 00000000 00000000
> >
> > /Very/ minor, trivial thing, yes, but those messages have been annoying my
> > eyes for a while now so I desided to make them line up - so, here's the
> > patch that does that (not sure if a signed-off-by line is needed even for
> > trivial stuff like this, but I assume it should go with everything, so...)
> > Patch is against 2.6.7-rc3-mm2
> >
>
> I think that's what the spaces after CPU: was for... apparently that's gotten
> forgotten somehow.  Sigh.  Please put the extra spaces all in one place.
>
Ok, I already send off a second version that indented the third line to
match as well, and had the extra space after "caps:", but here's a (maybe
better) third version that remove the extra spacing after "CPU:" and makes
all the extra spacing appear after "caps:"
still 2.6.7-rc3-mm2 patch

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.7-rc3-mm2-orig/arch/i386/kernel/cpu/common.c	2004-06-09 03:34:40.000000000 +0200
+++ linux-2.6.7-rc3-mm2/arch/i386/kernel/cpu/common.c	2004-06-15 23:50:33.000000000 +0200
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

