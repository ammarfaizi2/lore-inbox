Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266274AbUJEWsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266274AbUJEWsn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 18:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266233AbUJEWsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 18:48:43 -0400
Received: from gate.crashing.org ([63.228.1.57]:51088 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266291AbUJEWra (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 18:47:30 -0400
Subject: Re: [PATCH] I/O space write barrier
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200410050833.49654.jbarnes@engr.sgi.com>
References: <1096922369.2666.177.camel@cube>
	 <200410041926.57205.jbarnes@sgi.com> <1096945479.24537.15.camel@gaston>
	 <200410050833.49654.jbarnes@engr.sgi.com>
Content-Type: text/plain
Message-Id: <1097016099.27222.14.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 06 Oct 2004 08:41:40 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-06 at 01:33, Jesse Barnes wrote:

> This macro is only supposed to deal with writes from different CPUs that may 
> arrive out of order, nothing else.  It sounds like PPC won't allow that 
> normally, so I can be an empty definition.

I don't understand that neither. You can never guarantee any ordering
between writes from different CPUs unless you have a sinlock. If you
have an ordering problem with spinlocks, then it's a totally different
issue, a bit more like MMIO vs. cacheable mem that we have on PPC. If
this is the problem you are trying to chase, then we could use such a
barrier on ppc too and make it a hard sync, but it has nothing to do
with the write barrier we already have in our IO accessors...

> > That  doesn't solve my need of MMIO vs. memory unless you are trying to
> > cover that as well, in which case it should be a sync.
> 
> No, I think that has to be covered separately.

How so ? Again, this whole "ordering of writes between different CPU" makes
absolutely no sense to me.

Ben.


