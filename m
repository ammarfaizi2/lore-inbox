Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932722AbVITRRo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932722AbVITRRo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 13:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932734AbVITRRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 13:17:44 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11791 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932722AbVITRRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 13:17:43 -0400
Date: Tue, 20 Sep 2005 18:17:37 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: penberg@cs.Helsinki.FI, alan@lxorguk.ukuu.org.uk, viro@ftp.linux.org.uk,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: p = kmalloc(sizeof(*p), )
Message-ID: <20050920171737.GC493@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, penberg@cs.Helsinki.FI,
	alan@lxorguk.ukuu.org.uk, viro@ftp.linux.org.uk,
	linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <20050918100627.GA16007@flint.arm.linux.org.uk> <84144f0205092004187f86840c@mail.gmail.com> <20050920114003.GA31025@flint.arm.linux.org.uk> <Pine.LNX.4.58.0509201501440.9304@sbz-30.cs.Helsinki.FI> <20050920123149.GA29112@flint.arm.linux.org.uk> <20050920101128.70fec697.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050920101128.70fec697.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2005 at 10:11:28AM -0700, Andrew Morton wrote:
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> >
> >  Since some of the other major contributors to the kernel appear to
> >  also disagree with the statement, I think that the entry in
> >  CodingStyle must be removed.
> 
> Nobody has put forward a decent reason for doing so.  "I want to grep for
> initialisations" is pretty pointless because a) it won't catch everything
> anyway and b) most structures are allocated and initialised at a single
> place and many of those which aren't should probably be converted to do
> that anyway.
> 
> The broader point is that you're trying to optimise for the wrong thing. 
> We should optimise for those who read code, not for those who write it.
> 
> Every time I see such a type-unsafe allocation in a patch I have to go hunt
> down the definition of the lhs.  Which is sometimes in a header file, often
> one which hasn't been indexed yet.  Is a pita.

Well, as I've said, don't expect folk to change their style just
because something has been decided privately amongst a small select
group of folk (which is exactly what seems to have happened - maybe
not intentionally.)

And don't expect subsystem maintainers to accept the new "style"
guidelines without a fight.

However, if we really are concerned about type-unsafe allocation,
we should be using something like Alan's suggestion, where the
return type from the *alloc function is appropriately typed and
not void *.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
