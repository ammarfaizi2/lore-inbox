Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267392AbTBULsA>; Fri, 21 Feb 2003 06:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267394AbTBULsA>; Fri, 21 Feb 2003 06:48:00 -0500
Received: from ns.suse.de ([213.95.15.193]:51215 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267392AbTBULr7>;
	Fri, 21 Feb 2003 06:47:59 -0500
Date: Fri, 21 Feb 2003 12:58:05 +0100
From: Andi Kleen <ak@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com,
       ak@suse.de, davem@redhat.com
Subject: Re: ioctl32 consolidation
Message-ID: <20030221115805.GA6445@wotan.suse.de>
References: <20030220223119.GA18545@elf.ucw.cz> <20030220224433.GV9800@gtf.org> <20030221113428.GF24049@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030221113428.GF24049@atrey.karlin.mff.cuni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2003 at 12:34:29PM +0100, Pavel Machek wrote:
> Hi!
> 
> 
> > > Currently, 32-bit emulation in kernel has *5* copies, and its >1000
> > > lines each.
> > 
> > Yes :/  Consolidating all these copies into a single layer has been a
> > "project to be" for quite some time.
> > 
> > I do not know if it is too late in 2.5.x to begin this work, however.
> > We _are_ in a feature freeze...  I suppose it is up to the consensus of
> > arch maintainers, because it [obviously] does not affect ia32.
> 
> Actually Andi asked me to do the work. Dave, is it okay with you? What
> about other maintainers?

One issue you need to be careful about is that long long has different
alignment between 32bit and 64bit on ia64 and x86-64. On sparc64/mips64/ppc64
etc. that isn't the case. The x86-64 handlers convert sometimes more than
the later ones because of that.

Also some ioctl handlers are endian dependent, at least in x86-64 (I think
I commented them all). Not sure if Dave did the same.

First step probably is to just get register_ioctl32_translation into
a common header and implementation file.

-Andi
