Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268756AbTBZOQQ>; Wed, 26 Feb 2003 09:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268759AbTBZOQQ>; Wed, 26 Feb 2003 09:16:16 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:14333 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S268756AbTBZOQP>;
	Wed, 26 Feb 2003 09:16:15 -0500
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15964.52883.370949.237446@gargle.gargle.HOWL>
Date: Wed, 26 Feb 2003 15:26:27 +0100
To: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: Enabling L2 cache for overdrive CPUs.
In-Reply-To: <200302261349.h1QDn0Bh002816@deviant.impure.org.uk>
References: <200302261349.h1QDn0Bh002816@deviant.impure.org.uk>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

davej@codemonkey.org.uk writes:
 > Some CPU overdrives (such as those made by powerleap) mean
 > that we get a CPU with L2 cache disabled by default, and
 > a BIOS that doesn't know how to turn it on.
 > The patch below is untested, and I'd like some feedback
 > from folks (preferably those with these wacky overdrives,
 > but also from regular intel CPUs too - disable L2 in your
 > bios and try booting with 'enable-l2' and see what happens).
...
 > +	cr0 = read_cr0();
 > +	cr0 |= 1<<30;
 > +	write_cr0 (cr0);
 > +
 > +	rdmsr (0x11e, lo, hi);
 > +	lo |= 0x40101;
 > +	wrmsr (0x11e, lo, hi);
 > +
 > +	cr0 &= ~(1<<30);
 > +	write_cr0 (cr0);
 > +
 > +	wbinvd();

Ugh. Is this for the PII overdrive for PPro socket or what?

Seems awfully dangerous to have a __setup() clobber MSRs without
checking the cpuid first. 
Shouldn't this be in the CPU detection/quirks code instead?
It already contains stuff similar to this.

/Mikael
