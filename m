Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261432AbTCTMoP>; Thu, 20 Mar 2003 07:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261434AbTCTMoP>; Thu, 20 Mar 2003 07:44:15 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:44934 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S261432AbTCTMoO>; Thu, 20 Mar 2003 07:44:14 -0500
Date: Thu, 20 Mar 2003 12:54:55 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: David Brownell <david-b@pacbell.net>, Jeff Garzik <jgarzik@pobox.com>,
       Greg KH <greg@kroah.com>, Russell King <rmk@arm.linux.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.5] PCI MWI cacheline size fix
Message-ID: <20030320125450.GC6995@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	David Brownell <david-b@pacbell.net>,
	Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>,
	Russell King <rmk@arm.linux.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <20030320135950.A2333@jurassic.park.msu.ru> <20030320115520.GB6995@suse.de> <20030320152956.A2584@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030320152956.A2584@jurassic.park.msu.ru>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 20, 2003 at 03:29:56PM +0300, Ivan Kokshaysky wrote:
 > On Thu, Mar 20, 2003 at 11:55:20AM +0000, Dave Jones wrote:
 > >  > +	else if (c->x86 > 6)
 > >  > +		pci_cache_line_size = 128 >> 2;	/* P4 */
 > >  >  
 > > 
 > > I'd feel more comfortable with this with a c->x86_vendor == X86_VENDOR_INTEL
 > > on the else if clause. The above code will silently break if for eg,
 > > VIA, Transmeta or any other clone manufacturer make a model 7 or higher CPU.
 > 
 > No, we'd just assume 128 bytes cache line size on such CPU, which is
 > safe unless it has cache lines larger than 128. But if we assume 32 bytes
 > while this new CPU has 64, MWI might corrupt memory by transferring
 > incomplete cache lines.

Ok, thanks for explaining this to me. Another possibility at future
proofing would be to actually run the cpuid function to get the
cacheline size, although as thats vendor (and in some cases model)
specific, it's probably more pain than its worth, so your method is
the safest way forward.

		Dave


