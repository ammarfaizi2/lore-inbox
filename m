Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964959AbVITKHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbVITKHm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 06:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbVITKHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 06:07:42 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:19650 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S964959AbVITKHl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 06:07:41 -0400
Date: Tue, 20 Sep 2005 13:07:39 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Al Viro <viro@ftp.linux.org.uk>
cc: Robert Love <rml@novell.com>, Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: p = kmalloc(sizeof(*p), )
In-Reply-To: <20050920095352.GN7992@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0509201256340.402@sbz-30.cs.Helsinki.FI>
References: <20050918100627.GA16007@flint.arm.linux.org.uk>
 <1127061146.6939.6.camel@phantasy> <84144f020509200153f0becf2@mail.gmail.com>
 <20050920093953.GM7992@ftp.linux.org.uk> <Pine.LNX.4.58.0509201245340.32086@sbz-30.cs.Helsinki.FI>
 <20050920095352.GN7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2005 at 12:47:32PM +0300, Pekka J Enberg wrote:
> > To find candidates, something like:
> > 
> > grep "kmalloc(sizeof([^*]" -r drivers/ | grep -v "sizeof(struct"
> > 
> > And then use my eyes to find real bugs.

On Tue, 20 Sep 2005, Al Viro wrote:
> "grep for kmallocs that do not have _either_ form and look for bugs among
> them" is hardly usable as an argument in favour of one of them...

I would disagree with that. The _common case_ for allocation is:

	p = kmalloc(sizeof(*p), ...);

For which you know that you are allocating enough memory for the struct. 
Now the only way to screw it up is to write:

	p = kmalloc(sizeof(p), ...);

That is trivial to grep for.

Yes, currently, typedefs and open-coded kcalloc's give false positives but
that's what kernel janitors are for...

			Pekka
