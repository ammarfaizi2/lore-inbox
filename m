Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262782AbUCOVIP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 16:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262784AbUCOVIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 16:08:15 -0500
Received: from fed1mtao04.cox.net ([68.6.19.241]:30173 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP id S262782AbUCOVIL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 16:08:11 -0500
Date: Mon, 15 Mar 2004 14:08:07 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: davem@redhat.com, cieciwa@alpha.zarz.agh.edu.pl,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [SPARC64][PPC] strange error ..
Message-ID: <20040315210807.GC13167@smtp.west.cox.net>
References: <Pine.LNX.4.58L.0403151437360.16193@alpha.zarz.agh.edu.pl> <Pine.LNX.4.58L.0403151939460.17732@alpha.zarz.agh.edu.pl> <20040315190026.GG4342@smtp.west.cox.net> <20040315123953.3b6b863f.davem@redhat.com> <20040315204346.GB13167@smtp.west.cox.net> <20040315125417.3839f8fa.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040315125417.3839f8fa.rddunlap@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2004 at 12:54:17PM -0800, Randy.Dunlap wrote:
> On Mon, 15 Mar 2004 13:43:46 -0700 Tom Rini wrote:
> | On Mon, Mar 15, 2004 at 12:39:53PM -0800, David S. Miller wrote:
> | 
> | > On Mon, 15 Mar 2004 12:00:26 -0700
> | > Tom Rini <trini@kernel.crashing.org> wrote:
> | > 
> | > > That leaves the more general problem of <asm/unistd.h> uses 'asmlinkage'
> | > > on platforms where either (or both) of the following can be true:
> | > > - 'asmlinkage' is a meaningless term, and shouldn't be used.
> | > > - <asm/unistd.h> doesn't include <linux/linkage.h> so it's possible
> | > >   another file down the line breaks.
> | > 
> | > I think the best fix is to include linux/linkage.h in asm/unistd.h as
> | > you seem to be suggesting, and therefore that is the change I will
> | > push off to Linus to fix this on sparc32 and sparc64.
> | 
> | Erm, if I read include/asm-sparc{,64}/linkage.h right, 'asmlinkage' ends
> | up being defined to ''.  So why not just remove 'asmlinkage' from the
> | offending line in unistd.h ?
> 
> For future-proofing:  so that it will be like all other $arch/unistd.h,

It's not nearly all other $arch/unistd.h, it's arm, arm26, i386, ia64,
ppc64, v850 and x86_64.  Of which, only i386, ia64 and x86_64 arm* do
anything in <asm/linkage.h>.

So if we really do want to go down the future-proof <asm-*/unistd.h>
from the ia-centric folks (<grin>) road, we'd be better off with a patch
to fix everyone else's $arch/unistd.h.

> so that when someone changes the meaning of it, it will just work...?

The meaning of asmlinkage ?

-- 
Tom Rini
http://gate.crashing.org/~trini/
