Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932989AbWJIRRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932989AbWJIRRe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 13:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932988AbWJIRRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 13:17:34 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:3463 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932098AbWJIRRd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 13:17:33 -0400
Date: Mon, 9 Oct 2006 10:17:09 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: David Howells <dhowells@redhat.com>
cc: Matthew Wilcox <matthew@wil.cx>, torvalds@osdl.org, akpm@osdl.org,
       sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/4] LOG2: Implement a general integer log2 facility in
 the kernel [try #4] 
In-Reply-To: <9954.1160395768@redhat.com>
Message-ID: <Pine.LNX.4.64.0610091012330.27355@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0610090403490.25336@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.64.0610061015570.14591@schroedinger.engr.sgi.com>
 <20061006133414.9972.79007.stgit@warthog.cambridge.redhat.com>
 <20061006141704.GH2563@parisc-linux.org> <7795.1160388696@redhat.com> 
 <9954.1160395768@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Oct 2006, David Howells wrote:

> On FRV, for example, I don't want to wrap fls() because the code for ilog2()
> can be shorter and simpler.
> 
> If I did fls() as a wrapper around ilog2() then it would have to involve a
> conditional jump because the compiler can't alter the inline asm of ilog2() to
> turn the SCAN instruction into CSCAN (which is a conditionally executed
> version of SCAN).

Hmmm.. Why not? If you can define fls on a per arch basis then that should 
be possible? You can tell the compiler to produce the correct version of 
the scan instructions. We do that frequently on IA64.
 
> (I have defined ilog2(n) as returning an undefined value if n < 1).

Undefined values are bad. Could you produce a runtime error instead?

> > >  (5) fls() and fls64() can't be used to initialise a variable at compile
> > >      time, ilog2() can.
> > 
> > Well that is the same issue as (4).
> 
> Not quite.  I think (4) might be sufficiently achievable with an inline
> function, but (5) is definitely not.

With the appropriate per arch modification of fls() this should also be 
possible within the existing framework.

