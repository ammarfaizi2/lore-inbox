Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964840AbWEaGqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbWEaGqc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 02:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964844AbWEaGqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 02:46:32 -0400
Received: from mse2fe2.mse2.exchange.ms ([66.232.26.194]:3296 "EHLO
	mse2fe2.mse2.exchange.ms") by vger.kernel.org with ESMTP
	id S964840AbWEaGqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 02:46:32 -0400
Subject: Re: linux-2.6 x86_64 kgdb issue
From: Piet Delaney <piet@bluelane.com>
Reply-To: piet@bluelane.com
To: Andi Kleen <ak@suse.de>
Cc: Piet Delaney <piet@bluelane.com>, "Amit S. Kale" <amitkale@linsyssoft.com>,
       "Vladimir A. Barinov" <vbarinov@ru.mvista.com>,
       Andrew Morton <akpm@osdl.org>, kgdb-bugreport@lists.sourceforge.net,
       trini@kernel.crashing.org, linux-kernel@vger.kernel.org
In-Reply-To: <200605310750.34047.ak@suse.de>
References: <446E0B4B.9070003@ru.mvista.com>
	 <200605251207.27699.amitkale@linsyssoft.com>
	 <1149050728.26542.85.camel@piet2.bluelane.com>
	 <200605310750.34047.ak@suse.de>
Content-Type: text/plain
Organization: BlueLane Tech,
Date: Tue, 30 May 2006 23:46:27 -0700
Message-Id: <1149057987.26542.116.camel@piet2.bluelane.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4-3mdk 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 May 2006 06:46:31.0343 (UTC) FILETIME=[F33F53F0:01C6847D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-31 at 07:50 +0200, Andi Kleen wrote:
> > Perhaps we should add a kgdb config menu option and #define
> > CONFIG_16KSTACKS to double the stack size so the kernel can be 
> > debugged with more context available. I'm currently using -O0 for 
> > the networking stack and -O1 for the rest of the kernel. Sounds like 
> > it would be helpful now for AMD64 targets.
> 
> You only got stack overflows when working with kgdb right?

Yes, I was using kgdb to look at the stack audits I stored in
the thread structure.

>  
> Sounds like a kgdb problem to me then that can and should be probably fixed. e.g. 
> afaik kgdb isn't reentrant anyways so it could just use static buffers.

On Solaris the problem was that the kernel stack was larger because tail
optimization was disabled with optimization disabled. I'm not having
a kgdb problem with i386, it seems that Vladimir is/was and Amit
suspected it being due to the AMD64 requiring largers stacks. Seems
plausible to me. I thought you might have thoughts on that.

> 
> I would suggest against adding any new config options for this - it would
> conflict with the great goal of having loadable debuggers that work
> on any kernels.

What's the conflict with larger kernel stacks and a loadable (kgdb)
module? Like Andy Morton I prefer to avoid using modules when using
kgdb; so I wouldn't have run into a problem. 

I was suggesting larger stack space for the kernel, not kgdb. I agree
this case might be one where kgdb has caused the kernel to trip over 
the edge. I don't feel comfortable running on a kernel that running
that close to running out of stack space. Maybe that's just a personal
preference; I'm paranoid I guess. I like having rock solid systems and
wacking the stack isn't always detected. On SunOS we had a REDZONE but
last I check Linux didn't; has one been added? If it hasn't it might
be good to keep in mind having a CPU specific physical page available
when we grow into the REDZONE. Looked to me like the stack grows right
into the thread structure; might make a nice exploit for a linux root
kit.

Having loadable debuggers seems a bit high hopes, as 'we' haven't even
release linux with kgdb built into the Linux src yet. 

-piet
 
 
> -Andi
> 
-- 
---
piet@bluelane.com

