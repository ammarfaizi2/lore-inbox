Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbTI3O7T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 10:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbTI3O7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 10:59:19 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:3974 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S261552AbTI3O7N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 10:59:13 -0400
Date: Tue, 30 Sep 2003 15:58:54 +0100
From: Jamie Lokier <jamie@shareable.org>
To: John Bradford <john@grabjohn.com>
Cc: Dave Jones <davej@redhat.com>, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: your mail
Message-ID: <20030930145854.GD28876@mail.shareable.org>
References: <200309300817.h8U8HGrf000881@81-2-122-30.bradfords.org.uk> <20030930133113.GC23333@redhat.com> <200309301410.h8UEAEgJ000652@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309301410.h8UEAEgJ000652@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:
> Unless, of course, you object to the possibility that somebody might
> go out of their way to compile a 386 specific kernel from source
> themselves, then run it on an Athlon.  By chance it will probably
> appear to work OK, but won't have the workaround enabled.  So what?

Actually the 386 kernel will work just fine on the AMD...  The
workaround is only needed, in the kernel, to protect against the
kernel's own use of non-386 features...

Userspace is a different matter, but userspace has a lot of
model-specific things to worry about beyond this one instruction on
AMD.  In practice: bswap, cmov, cmpxchg, mmx, sse, sse2, so knowing
whether to use prefetch or not is just one more variable for userspace
- and one which any portable app or library will have to know about in
any case.

(Aside: It is quite an anomaly that those cumbersome floating point
instructions are emulated on the older CPUs, yet all the other
instructions aren't emulated.  Emulation is very slow, and forcing
userspace to just use different code instead is good, but that's just
as valid for floating point as it is for MMX, cmpxchg etc.)

> Only somebody who knows exactly what they were doing is likely to do
> that - how could it happen by accident?  If you really must, put a
> warning in to say, 'This kernel doesn't support your processor', but
> doing that just adds more bloat.  OK, so the bloat will be freed after
> boot, but it's still bloat on the boot device, which matters in some
> embedded systems.

To be fair, the kernel really ought to just say that and halt.  That
is a fine compromise.  It won't make embedded systems folks completely
happy, because if you've only got 2MB of NVRAM for your whole kernel
_and_ filesystem including user data (think PDA or cellphone), then a
hundred bytes here or there is actually worth trimming.

But then, those sort of embedded folks should just figure out
compressed software-suspend, and then they can ditch __init data from
the NVRAM image completely.  It's much better to lose all of __init
than just a few bytes here or there, isn't it?

-- Jamie
