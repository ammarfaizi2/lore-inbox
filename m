Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbTI3Oug (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 10:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbTI3Oug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 10:50:36 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:34265 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S261522AbTI3Ouc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 10:50:32 -0400
Date: Tue, 30 Sep 2003 15:50:08 +0100
From: Dave Jones <davej@redhat.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: John Bradford <john@grabjohn.com>, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: your mail
Message-ID: <20030930145007.GB12812@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jamie Lokier <jamie@shareable.org>,
	John Bradford <john@grabjohn.com>, akpm@osdl.org, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <200309300817.h8U8HGrf000881@81-2-122-30.bradfords.org.uk> <20030930133113.GC23333@redhat.com> <20030930140627.GB28876@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030930140627.GB28876@mail.shareable.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 03:06:27PM +0100, Jamie Lokier wrote:
 > Dave Jones wrote:
 > > On Tue, Sep 30, 2003 at 09:17:16AM +0100, John Bradford wrote:
 > >  > Of course a kernel compiled strictly for 386s may seem to boot on an
 > >  > Athlon but not work properly.  So what?  Just don't run the 'wrong'
 > >  > kernel.
 > > Wrong answer. How do you intend to install Linux when a distro boot
 > > kernel is compiled for lowest-common-denominator (386), and is the
 > > 'wrong' kernel for an Athlon ?
 > I'm not sure what the fuss is; a strict 386 kernel runs just fine
 > without any problems on an Athlon.  But anyway...

Unless it got configured away as proposed in your earlier patch.

 > Dave, you are conflating "kernel compiled strictly for 386s" with
 > "compiled for lowest-common-denominator".
 > 
 > They are totally different configurations.  Isn't that why we have
 > "generic" now?

CONFIG_GENERIC could be extended to offer other options yes,
but right now what it does doesn't really match the name IMO.
Right now its closer to a CONFIG_MAX_CACHELINE_SIZE

 > The latter is for distro boots.  The former is for that
 > 386-as-a-firewall with 1MB of RAM, where it _really_ has to trim
 > everything it can, and no errata thank you.

Again, 'trimming' away a few hundred bytes of errata workarounds
is ridiculous when we have bigger fish to fry where we can save
KBs of .text size, and MB's of runtime memory.

 > I've not heard of anyone actually wanting a strict 386 kernel lately,
 > but strict 486 is not so unusual.

ISTR that current gcc's emit 486 instructions anyway, so its possible
that with a modern toolchain, you can't *build* a 386 kernel.
I'm not sure if that got fixed or not, I don't track gcc lists any more.

 > Just as some people want a P4 optimised kernel, and some people want a
 > K7 optimised kernel, so some people want a 386 or 486 or Pentium
 > optimised kernel.  Lowest-common-denominator means it runs on
 > everything, and isn't really anything to do with 386 any more - that's
 > not really the lowest-common-denominator, by virtue of the obvious
 > fact that pure 386 code isn't reliable on all other CPUs.

Elaborate? "pure 386 code" (whatever that means in your definition)
should run perfectly reliable on every CPU we care about.

 > > We hashed this argument out a week or so ago, it seems the message
 > > didn't get across. YOU CAN NOT DISABLE ERRATA WORKAROUNDS IN A KERNEL
 > > THAT MAY POSSIBLY BOOT ON HARDWARE THAT WORKAROUND IS FOR.
 > I agree.  It shouln't be possible to boot on the wrong hardware: it
 > should refuse.

So first you argue for compiling out a few hundred bytes of errata
workaround, now you want to instead compile in checks & printk's
(which probably add up to not far off the same amount of space).

 > By selecting a PII kernel, it is possible to configure out the code
 > for X86_PPRO_FENCE and X86_F00F_BUG, yet as far as I can tell, those
 > _can_ possibly boot on kernels where the errata are needed, and nary a
 > printk is emitted for it.  Nasty bugs they are, too.

Indeed. That's arguably a bug that occured when someone split the
original CONFIG_M686 into _M686 & MPENTIUMII.

 > More generally than the CPU, you can also configure out BLK_DEV_RZ1000
 > which is another crucial workaround that needs to go in any
 > lowest-common-denominator kernel.

I wouldn't look at the history of drivers/ide/ as a shining example of
good design 8-)

 > Basically, if you're building a
 > distro boot kernel, you must turn on all known workarounds.  That's
 > certainly lowest-common-denominator, but it's a far cry from the
 > configuration that a 386-as-firewall user wants.

Ok, I see what you're getting at, but Adrian's patch turned arch/i386/Kconfig
and arch/i386/Makefile into guacamole.  After spending so much time
getting that crap into something maintainable, it seemed a huge step
backwards to litter it with dozens of ifdefs and duplication.
There has to be a cleaner way of pleasing everyone.

 > > clearer?
 > If the kernel had a consistent policy so far, it would be more clear,
 > but it doesn't.

Agreed, there are some questionable parts.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
