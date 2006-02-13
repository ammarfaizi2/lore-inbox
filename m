Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750871AbWBMANe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbWBMANe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 19:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbWBMANe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 19:13:34 -0500
Received: from mail.gmx.net ([213.165.64.21]:31970 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750871AbWBMANd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 19:13:33 -0500
X-Authenticated: #9163084
Date: Mon, 13 Feb 2006 01:14:12 +0100
From: Marko <letterdrop@gmx.de>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How getting a pointer on the per-cpu struct tss_struct??
Message-Id: <20060213011412.0779d337.letterdrop@gmx.de>
In-Reply-To: <Pine.LNX.4.64.0602121552520.10777@montezuma.fsmlabs.com>
References: <20060213002706.50e5289c.letterdrop@gmx.de>
	<Pine.LNX.4.64.0602121552520.10777@montezuma.fsmlabs.com>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for answering.

So when I don't want to change the kernel, the only way to get
a pointer on the IO Permission Bitmap is using the TSS entry in
the GDT??

Or is there another way to access the current structure tss_struct??


Marko Euth




On Sun, 12 Feb 2006 15:58:31 -0800 (PST)
Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:

> On Mon, 13 Feb 2006, Marko wrote:
> 
> > But when I try to compile this, I get the warning:
> > 
> > 	*** Warning: "per_cpu__init_tss" [/home/..../module.ko]
> > 	undefined!
> > 
> > and according to this warning an error, when I try to load the module:
> > 
> > 	insmod: error inserting 'module.ko': -1 Unknown symbol in module
> 
> init_tss isn't exported, you would need to do 
> EXPORT_PER_CPU_SYMBOL(init_tss).
> 
> Also a suggestion, you should use __get_cpu_var instead of per_cpu e.g.
> 
> 	struct tss_struct *t;
> 	/* if you don't need cpu variable just preempt_disable */
> 	int cpu = get_cpu();
> 	t = __get_cpu_var(init_tss);
> ...
> 	put_cpu();
> 
