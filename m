Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271118AbTHKF1t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 01:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272071AbTHKF1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 01:27:48 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:58639 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S271118AbTHKF1d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 01:27:33 -0400
Date: Mon, 11 Aug 2003 07:26:59 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       davem@redhat.com, chip@pobox.com
Subject: Re: [PATCH] 2.4.22pre10: {,un}likely_p() macros for pointers
Message-ID: <20030811052659.GA28640@alpha.home.local>
References: <1060488233.780.65.camel@cube> <20030810072945.GA14038@alpha.home.local> <20030811045531.GH10446@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030811045531.GH10446@mail.jlokier.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 05:55:31AM +0100, Jamie Lokier wrote:
> Willy Tarreau wrote:
> > > I looked at the assembly (ppc, gcc 3.2.3) and didn't
> > > see any overhead.
> > 
> > same here on x86, gcc-2.95.3 and gcc-3.3.1. The compiler is smart enough not
> > to add several intermediate tests for !!(x).
> 
> What I recall is no additional tests, but the different forms affected
> the compilers choice of instructions on x86, making one form better
> than another.  Unfortunately I don't recall what that was, or what
> test it showed up in :(

It may well be when you use it in boolean constructs. The following functions
return exactly the same result with different code :

int test1(int u, int v, int x, int y) {
   return (u > v) || (x > y);
}

int test2(int u, int v, int x, int y) {
   return !!(u > v) | !!(x > y);
}

test1() uses 2 jumps on x86 while test2 uses only test-and-set and should be
faster. This also allows to easily write the boolean XOR BTW :

int test3(int u, int v, int x, int y) {
   return !!(u > v) ^ !!(x > y);
}

Cheers,
Willy

