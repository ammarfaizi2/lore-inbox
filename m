Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269112AbUJEPhD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269112AbUJEPhD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 11:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269082AbUJEPgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 11:36:45 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:25020 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S269146AbUJEPfA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 11:35:00 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] I/O space write barrier
Date: Tue, 5 Oct 2004 08:33:49 -0700
User-Agent: KMail/1.7
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <1096922369.2666.177.camel@cube> <200410041926.57205.jbarnes@sgi.com> <1096945479.24537.15.camel@gaston>
In-Reply-To: <1096945479.24537.15.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410050833.49654.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, October 4, 2004 8:04 pm, Benjamin Herrenschmidt wrote:
> > I agree, it's hard to get right, especially when you've got a large base
> > of drivers with hard to find assumptions about ordering.
> >
> > What about mmiowb()?  Should it be eieio?  I don't want to post another
> > patch if I don't have to...
>
> I don't understand the whole story...
>
> If normal accesses aren't relaxed (and I think they shouldn't be), then
> there is no point in a barrier here.... If you need an explicit barrier
> for explicitely relaxed accesses, then yes.

This macro is only supposed to deal with writes from different CPUs that may 
arrive out of order, nothing else.  It sounds like PPC won't allow that 
normally, so I can be an empty definition.

> That doesn't solve my need of MMIO vs. memory unless you are trying to
> cover that as well, in which case it should be a sync.

No, I think that has to be covered separately.

Jesse
