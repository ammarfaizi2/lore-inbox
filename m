Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266333AbUJEXQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266333AbUJEXQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 19:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266324AbUJEXQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 19:16:34 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:5354 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266333AbUJEXJf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 19:09:35 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] I/O space write barrier
Date: Tue, 5 Oct 2004 16:09:23 -0700
User-Agent: KMail/1.7
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <1096922369.2666.177.camel@cube> <200410050833.49654.jbarnes@engr.sgi.com> <1097016099.27222.14.camel@gaston>
In-Reply-To: <1097016099.27222.14.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410051609.23479.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, October 5, 2004 3:41 pm, Benjamin Herrenschmidt wrote:
> On Wed, 2004-10-06 at 01:33, Jesse Barnes wrote:
> > This macro is only supposed to deal with writes from different CPUs that
> > may arrive out of order, nothing else.  It sounds like PPC won't allow
> > that normally, so I can be an empty definition.
>
> I don't understand that neither. You can never guarantee any ordering
> between writes from different CPUs unless you have a sinlock. If you
> have an ordering problem with spinlocks, then it's a totally different
> issue, a bit more like MMIO vs. cacheable mem that we have on PPC.

Right.

> If 
> this is the problem you are trying to chase, then we could use such a
> barrier on ppc too and make it a hard sync, but it has nothing to do
> with the write barrier we already have in our IO accessors...

Ok.

>
> > > That  doesn't solve my need of MMIO vs. memory unless you are trying to
> > > cover that as well, in which case it should be a sync.
> >
> > No, I think that has to be covered separately.
>
> How so ? Again, this whole "ordering of writes between different CPU" makes
> absolutely no sense to me.

It's like you said above.  I meant that ordering of writes to I/O space and 
memory space should be dealt with differently on PPC, as you've said before.  
I guess you need new barrier types for that?

Jesse
