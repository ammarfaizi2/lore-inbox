Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbTEQCz2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 22:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbTEQCz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 22:55:28 -0400
Received: from dp.samba.org ([66.70.73.150]:53939 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261158AbTEQCz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 22:55:27 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: akpm@zip.com.au, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       davidm@hpl.hp.com, rth@twiddle.net
Subject: Re: [PATCH] Unlimited per-cpu allocation 
In-reply-to: Your message of "Fri, 16 May 2003 19:38:47 MST."
             <20030516.193847.15241922.davem@redhat.com> 
Date: Sat, 17 May 2003 13:07:21 +1000
Message-Id: <20030517030820.E17F72C018@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030516.193847.15241922.davem@redhat.com> you write:
>    From: Rusty Russell <rusty@rustcorp.com.au>
>    Date: Sat, 17 May 2003 11:58:55 +1000
>    
>    IA64 could just use the generic mechanism, like everyone else.  But
>    they do the tricky 64k mapping thing.  As I pointed out, maybe their
>    decision would have to be rethought if that proves inadaquate.
> 
> But we should also give them the option to implement module percpu
> data using indirect buffers.

Well, AFAICT that can't be done realistically: the module percpu
mechanisms must be the same as the core ones (you can't hide the
difference under #ifdef MODULE, either, since they can be handed
about).

You can do TLS-style tricks (with toolchain support), but we don't
need to, and almost certainly don't want to.

The question is not whether we need this allocator to implement percpu
inside modules (we do), but whether it can also be used for
kmalloc_percpu.

Hope that clarifies,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
