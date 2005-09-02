Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161027AbVIBVNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161027AbVIBVNP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 17:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161033AbVIBVNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 17:13:15 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:65505
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161027AbVIBVNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 17:13:14 -0400
Date: Fri, 02 Sep 2005 14:12:55 -0700 (PDT)
Message-Id: <20050902.141255.50099210.davem@davemloft.net>
To: ak@suse.de
Cc: alan@lxorguk.ukuu.org.uk, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au
Subject: Re: [PATCH 2.6.13] lockless pagecache 2/7
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <p73k6hzqk1w.fsf@verdi.suse.de>
References: <4317F136.4040601@yahoo.com.au>
	<1125666486.30867.11.camel@localhost.localdomain>
	<p73k6hzqk1w.fsf@verdi.suse.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@suse.de>
Date: 02 Sep 2005 22:41:31 +0200

> > Yeah quite a few. I suspect most MIPS also would have a problem in this
> > area.
> 
> cmpxchg can be done with LL/SC can't it? Any MIPS should have that.

Right.

On PARISC, I don't see where they are emulating compare and swap
as indicated.  They are doing the funny hashed spinlocks for the
atomic_t operations and bitops, but that is entirely different.

cmpxchg() has to operate in an environment where, unlike the atomic_t
and bitops, you cannot control the accessors to the object at all.

The DRM is the only place in the kernel that requires cmpxchg()
and you can thus make a list of what platform can provide cmpxchg()
by which ones support DRM and thus provide the cmpxchg() macro already
in asm/system.h

We really can't require support for this primitive kernel wide, it's
simply not possible on a couple chips.
