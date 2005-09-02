Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161057AbVIBVcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161057AbVIBVcE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 17:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161055AbVIBVcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 17:32:04 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:13024
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161057AbVIBVcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 17:32:03 -0400
Date: Fri, 02 Sep 2005 14:31:49 -0700 (PDT)
Message-Id: <20050902.143149.08652495.davem@davemloft.net>
To: nickpiggin@yahoo.com.au
Cc: ak@suse.de, alan@lxorguk.ukuu.org.uk, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.13] lockless pagecache 2/7
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <4318C28A.5010000@yahoo.com.au>
References: <1125666486.30867.11.camel@localhost.localdomain>
	<p73k6hzqk1w.fsf@verdi.suse.de>
	<4318C28A.5010000@yahoo.com.au>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Piggin <nickpiggin@yahoo.com.au>
Date: Sat, 03 Sep 2005 07:22:18 +1000

> This atomic_cmpxchg, unlike a "regular" cmpxchg, has the advantage
> that the memory altered should always be going through the atomic_
> accessors, and thus should be implementable with spinlocks.
> 
> See for example, arch/sparc/lib/atomic32.c
> 
> At least, that's what I'm hoping for.

Ok, as long as the rule is that all accesses have to go
through accessor macros, it would work.  This is not true
for existing uses of cmpxchg() btw, userland accesses shared
locks with the kernel would using any kind of accessors we
can control.

This means that your atomic_cmpxchg() cannot be used for locking
objects shared with userland, as DRM wants, since the hashed spinlock
trick does not work in such a case.
