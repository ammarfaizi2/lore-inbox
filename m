Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267356AbUBSQRq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 11:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267351AbUBSQRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 11:17:46 -0500
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:37390 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S267338AbUBSQR1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 11:17:27 -0500
Date: Thu, 19 Feb 2004 01:11:29 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       torvalds@osd.org, arjanv@redhat.com, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: Non-GPL export of invalidate_mmap_range
Message-ID: <20040219091129.GD1269@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20040217161929.7e6b2a61.akpm@osdl.org> <1077108694.4479.4.camel@laptop.fenrus.com> <20040218140021.GB1269@us.ibm.com> <20040218211035.A13866@infradead.org> <20040218150607.GE1269@us.ibm.com> <20040218222138.A14585@infradead.org> <20040218145132.460214b5.akpm@osdl.org> <20040218230055.A14889@infradead.org> <20040218162858.2a230401.akpm@osdl.org> <20040219123110.A22406@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040219123110.A22406@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 19, 2004 at 12:31:10PM +0000, Christoph Hellwig wrote:
> On Wed, Feb 18, 2004 at 04:28:58PM -0800, Andrew Morton wrote:
> > OK, so I looked at the wrapper.  It wasn't a tremendously pleasant
> > experience.  It is huge, and uses fairly standard-looking filesytem
> > interfaces and locking primitives.  Also some awareness of NFSV4 for some
> > reason.
> 
> And pokes deep into internal structures that it shouldn't.

Again, the point of the patch is to get rid of such poking.

> > Still, the wrapper is GPL so this is not relevant.
> 
> It's BSD licensed - they couldn't distribute it together with GPFS if
> it was GPL.

Yep.

> > Its only use is to tell
> > us whether or not the non-GPL bits are "derived" from Linux, and it
> > doesn't do that.
> 
> Well, something that needs an almost one megabyte big wrapper per defintion
> is not a standalone work but something that's deeply interwinded with
> the kernel.  The tons of kernel version checks certainly show it's poking
> deeper than it should.

On the size, I beg to differ.  One of the reasons the glue module is
so large is because of the fact that GPFS was written to run in an AIX
kernel rather than a Linux kernel.  I would guess that if GPFS had
been instead been derived from Linux, the glue module would be much
smaller.  On the kernel version checks, the point of the patch is
to get rid of at least some of these.

> > Why do you believe that GPFS represents a kernel licensing violation?
> 
> See above.  Something that pokes deep into internal structures and even
> needs new exports certainly is a derived work.  There's a few different
> interpretations of the derived works clause in the GPL around, the FSF
> one wouldn't allow binary modules at all, and Linus' one is also pretty
> strict.

So why are you coming out against something that you seem to believe
allows -better- alignment with Linus's rules?

						Thanx, Paul
