Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751301AbWH1Ikp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbWH1Ikp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 04:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbWH1Ikp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 04:40:45 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:51337 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751295AbWH1Iko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 04:40:44 -0400
Subject: Re: [PATCH 6/7] remove all remaining _syscallX macros
From: David Woodhouse <dwmw2@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: David Miller <davem@davemloft.net>, arnd@arndb.de,
       linux-arch@vger.kernel.org, jdike@addtoit.com, B.Steinbrink@gmx.de,
       arjan@infradead.org, chase.venters@clientec.com, akpm@osdl.org,
       rmk+lkml@arm.linux.org.uk, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
In-Reply-To: <200608281028.13652.ak@suse.de>
References: <200608281003.02757.ak@suse.de> <200608281015.38389.ak@suse.de>
	 <20060828.011929.66059812.davem@davemloft.net>
	 <200608281028.13652.ak@suse.de>
Content-Type: text/plain
Date: Mon, 28 Aug 2006 09:40:36 +0100
Message-Id: <1156754436.5340.20.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-28 at 10:28 +0200, Andi Kleen wrote:
> On Monday 28 August 2006 10:19, David Miller wrote:
> 
> > I see it as duplication because the person who writes the
> > kernel is the one who ends up writing the libc syscall
> > bits or explains to the libc person for that arch how
> > things work.  
> 
> And the way to explain it is to write the reference code.

That's a new and interesting thing to add to the list of things
that /usr/include/linux is _not_:

/usr/include/linux is _not_ a place to dump "reference code" in lieu of
documentation on using kernel interfaces.

Besides, the _syscallX implementations in the kernel were generally
unsuitable for use in that way anyway -- I'd be much more inclined to
rely on the libc version. The kernel version would do strange things
like break with PIC code by using an unavailable register (i386),
misalign 64-bit syscall arguments on 32-bit machines (MIPS), etc. 

> > And once one libc implmenetation of this 
> > exists, it can be used as a reference for other libc
> > variants.
> 
> At least on x86-64 various glibc versions had quite buggy
> syscall()s, that is why I never trusted it very much.

I assume these were very _early_ glibc in when the port was new? 

> > Finally, once it's done, it's done, and that's it.
> 
> Except if you still have to deal with old user land.

The limited subset of old userland which elected to use _syscallX()
instead of libc's syscall(), and which can be fixed fairly easily.

-- 
dwmw2

