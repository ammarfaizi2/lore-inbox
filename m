Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbTI3OGt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 10:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbTI3OGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 10:06:49 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:646 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S261506AbTI3OGr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 10:06:47 -0400
Date: Tue, 30 Sep 2003 15:06:27 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Dave Jones <davej@redhat.com>, John Bradford <john@grabjohn.com>,
       akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: your mail
Message-ID: <20030930140627.GB28876@mail.shareable.org>
References: <200309300817.h8U8HGrf000881@81-2-122-30.bradfords.org.uk> <20030930133113.GC23333@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030930133113.GC23333@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Tue, Sep 30, 2003 at 09:17:16AM +0100, John Bradford wrote:
>  > Of course a kernel compiled strictly for 386s may seem to boot on an
>  > Athlon but not work properly.  So what?  Just don't run the 'wrong'
>  > kernel.
> 
> Wrong answer. How do you intend to install Linux when a distro boot
> kernel is compiled for lowest-common-denominator (386), and is the
> 'wrong' kernel for an Athlon ?

I'm not sure what the fuss is; a strict 386 kernel runs just fine
without any problems on an Athlon.  But anyway...

Dave, you are conflating "kernel compiled strictly for 386s" with
"compiled for lowest-common-denominator".

They are totally different configurations.  Isn't that why we have
"generic" now?

The latter is for distro boots.  The former is for that
386-as-a-firewall with 1MB of RAM, where it _really_ has to trim
everything it can, and no errata thank you.

I've not heard of anyone actually wanting a strict 386 kernel lately,
but strict 486 is not so unusual.

Just as some people want a P4 optimised kernel, and some people want a
K7 optimised kernel, so some people want a 386 or 486 or Pentium
optimised kernel.  Lowest-common-denominator means it runs on
everything, and isn't really anything to do with 386 any more - that's
not really the lowest-common-denominator, by virtue of the obvious
fact that pure 386 code isn't reliable on all other CPUs.

> We hashed this argument out a week or so ago, it seems the message
> didn't get across. YOU CAN NOT DISABLE ERRATA WORKAROUNDS IN A KERNEL
> THAT MAY POSSIBLY BOOT ON HARDWARE THAT WORKAROUND IS FOR.

I agree.  It shouln't be possible to boot on the wrong hardware: it
should refuse.

There is precedent: X86_GOOD_APIC && X86_LOCAL_APIC: when booted on a
non-MMX P5, it refuses to boot, because it does not contain the errata
workaround.

Unfortunately the kernel has opposite precedents too.

By selecting a PII kernel, it is possible to configure out the code
for X86_PPRO_FENCE and X86_F00F_BUG, yet as far as I can tell, those
_can_ possibly boot on kernels where the errata are needed, and nary a
printk is emitted for it.  Nasty bugs they are, too.

More generally than the CPU, you can also configure out BLK_DEV_RZ1000
which is another crucial workaround that needs to go in any
lowest-common-denominator kernel.  Basically, if you're building a
distro boot kernel, you must turn on all known workarounds.  That's
certainly lowest-common-denominator, but it's a far cry from the
configuration that a 386-as-firewall user wants.

> clearer?

If the kernel had a consistent policy so far, it would be more clear,
but it doesn't.

-- Jamie
