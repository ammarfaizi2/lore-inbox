Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbTIWTGm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 15:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbTIWTF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 15:05:27 -0400
Received: from home.kvack.org ([216.138.200.138]:56795 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S261921AbTIWTFP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 15:05:15 -0400
Date: Tue, 23 Sep 2003 15:04:59 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: Grant Grundler <iod00d@hp.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, "David S. Miller" <davem@redhat.com>,
       davidm@hpl.hp.com, davidm@napali.hpl.hp.com, peter@chubb.wattle.id.au,
       ak@suse.de, peterc@gelato.unsw.edu.au, linux-ns83820@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
Message-ID: <20030923150459.A17437@kvack.org>
References: <DD755978BA8283409FB0087C39132BD101B01194@fmsmsx404.fm.intel.com> <20030923142925.A16490@kvack.org> <20030923185104.GA8477@cup.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030923185104.GA8477@cup.hp.com>; from iod00d@hp.com on Tue, Sep 23, 2003 at 11:51:04AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 11:51:04AM -0700, Grant Grundler wrote:
> On Tue, Sep 23, 2003 at 02:29:25PM -0400, Benjamin LaHaise wrote:
> ...
> > (yet another hardware issue pushed off on software for no significant gain).
> 
> Even x86 pays at least a one cycle penalty for every misaligned access.
> In general, open source code has no excuse for using misaligned fields.
> It's (mostly) avoidable.  TCP/IP headers are the historical exception.

The other point to keep in mind is that apparently the .09u rev of the P4 
includes additional hardware for handling unaligned accesses because they 
are so common (gzip is a good example of an app where it is faster to do 
an unaligned access for the benefit of fetching the data in one instruction 
instead of 3+, and there is no way to improve on it).

> One could make the same arguement that a modern NIC should not require
> 16 byte alignment for DMA. It's a tradeoff one way or the other.
> Just a matter of perspective.

I consider the 83820 buggy in this regard, too.  That said, the fix does 
not belong in the driver layer, as having it duplicated in a dozen drivers 
is more stupid than fixing up the arch code which is required anyways.

		-ben
-- 
"The software industry today survives only through an unstated agreement 
not to stir things up too much.  We must hope this lawsuit [by SCO] isn't 
the big stirring spoon." -- Ian Lance Taylor, Linux Journal, June 2003
