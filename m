Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751045AbWCAIQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbWCAIQY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 03:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbWCAIQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 03:16:24 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:57507 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751045AbWCAIQY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 03:16:24 -0500
Date: Wed, 1 Mar 2006 00:16:12 -0800
From: Jeremy Higdon <jeremy@sgi.com>
To: Jes Sorensen <jes@sgi.com>
Cc: Roland Dreier <rdreier@cisco.com>, "Bryan O'Sullivan" <bos@pathscale.com>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] Define wc_wmb, a write barrier for PCI write combining
Message-ID: <20060301081612.GA289233@sgi.com>
References: <1140841250.2587.33.camel@localhost.localdomain> <yq08xrvhkee.fsf@jaguar.mkp.net> <adar75nlcar.fsf@cisco.com> <44047565.3090202@sgi.com> <adafym3l8lk.fsf@cisco.com> <44048660.3010701@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44048660.3010701@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2006 at 06:20:32PM +0100, Jes Sorensen wrote:
> Roland Dreier wrote:
> >    Jes> Not quite correct as far as I understand it. mmiowb() is
> >    Jes> supposed to guarantee that writes to MMIO space have
> >    Jes> completed before continuing.  That of course covers the
> >    Jes> multi-CPU case, but it should also cover the write-combining
> >    Jes> case.
> >
> >I don't believe this is correct.  mmiowb() does not guarantee that
> >writes have completed -- they may still be pending in a buffer in a
> >bridge somewhere.  The _only_ effect of mmiowb() is to make sure that
> >writes which have been ordered between CPUs using some other mechanism
> >(i.e. a lock) are properly ordered by the rest of the system.  This
> >only has an effect systems like very large ia64 systems, where (as I
> >understand it), writes can pass each other on the way to the PCI bus.
> >In fact, mmiowb() is a NOP on essentially every architecture.
> 
> Hmmmm
> 
> That could be, seems like Jesse agrees that it could all be in the
> pipeline somewhere. Considering Jesse was responsible for mmiowb() I'll
> take his word for it ;-)

Right.  On the Altix, the mmiowb ensures that the write is into a
FIFO on the destination node (node I/O device is attached to), so
that later writes from other nodes will be ordered after it.  But
it doesn't actually force it to the bus.  That's one reason why it's
so much quicker than a using a read for ordering.

jeremy
