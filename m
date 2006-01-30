Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964922AbWA3TtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964922AbWA3TtH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 14:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964923AbWA3TtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 14:49:07 -0500
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:53783 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S964922AbWA3TtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 14:49:04 -0500
Date: Mon, 30 Jan 2006 19:50:04 +0000
From: Stuart Brady <sdbrady@ntlworld.com>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Stuart Brady <sdbrady@ntlworld.com>,
       Grant Grundler <grundler@parisc-linux.org>,
       Akinobu Mita <mita@miraclelinux.com>, linux-kernel@vger.kernel.org,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Ian Molton <spyro@f2s.com>,
       dev-etrax@axis.com, David Howells <dhowells@redhat.com>,
       Yoshinori Sato <ysato@users.sourceforge.jp>,
       Linus Torvalds <torvalds@osdl.org>, linux-ia64@vger.kernel.org,
       Hirokazu Takata <takata@linux-m32r.org>, linux-m68k@vger.kernel.org,
       Greg Ungerer <gerg@uclinux.org>, linux-mips@linux-mips.org,
       parisc-linux@parisc-linux.org, linuxppc-dev@ozlabs.org,
       linux390@de.ibm.com, linuxsh-dev@lists.sourceforge.net,
       linuxsh-shmedia-dev@lists.sourceforge.net, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, Miles Bader <uclinux-v850@lsi.nec.co.jp>,
       Andi Kleen <ak@suse.de>, Chris Zankel <chris@zankel.net>
Subject: Re: [parisc-linux] Re: [PATCH 3/6] C-language equivalents of include/asm-*/bitops.h
Message-ID: <20060130195004.GA25860@miranda.arrow>
References: <20060125113206.GD18584@miraclelinux.com> <20060125200250.GA26443@flint.arm.linux.org.uk> <20060126000618.GA5592@twiddle.net> <20060126085540.GA15377@flint.arm.linux.org.uk> <20060126161849.GA13632@colo.lackof.org> <20060126164020.GA27222@flint.arm.linux.org.uk> <20060126230443.GC13632@colo.lackof.org> <20060126230353.GC27222@flint.arm.linux.org.uk> <20060129071242.GA24624@miranda.arrow> <20060130170647.GC3816@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060130170647.GC3816@linux-mips.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2006 at 05:06:47PM +0000, Ralf Baechle wrote:
> On Sun, Jan 29, 2006 at 07:12:42AM +0000, Stuart Brady wrote:
> 
> > On MIPS, fls() and flz() should probably use CLO.
> 
> It actually uses clz.

I know.  flz(x) is basically __ilog2(~x), and I still say clo would be
better.  Removing flz() sounds reasonable, though.

> > Curiously, MIPS is the only arch with a flz() function.
> 
> No longer.  The fls implementation was based on flz and fls was the only
> user of flz.  So I cleaned that, once I commit flz will be gone.  Not
> only a cleanup but also a minor optimization.

I'd got that slightly wrong.  Yeah, fls(x) returned flz(~x) + 1, which
is __ilog2(~~x) + 1.  So obviously clz was fine for that, but it needed
cleaning up.

Shame about popc on SPARC.  However, ffz is cheese, regardless of pops.
(On sparc64, ffs is too.)  I'll wait for the generic bitops patches to
be dealt with (or not) and then submit a patch fixing this if needed.

Thanks,
-- 
Stuart Brady

By the way, I really hope nobody gets ten copies of this, as happened
with my last post.  It does not seem to be my fault, AFAICS.
