Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161067AbVLWWAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161067AbVLWWAY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 17:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161068AbVLWWAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 17:00:23 -0500
Received: from lixom.net ([66.141.50.11]:19121 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S1161066AbVLWWAV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 17:00:21 -0500
Date: Fri, 23 Dec 2005 15:59:16 -0600
To: Jack Steiner <steiner@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH] - Fix memory ordering problem in wake_futex()
Message-ID: <20051223215915.GE24601@pb15.lixom.net>
References: <20051223163816.GA30906@sgi.com> <20051223204822.GC24601@pb15.lixom.net> <20051223213216.GA29541@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051223213216.GA29541@sgi.com>
User-Agent: Mutt/1.5.9i
From: Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2005 at 03:32:16PM -0600, Jack Steiner wrote:

> On IA64, the "sync" instructions are actually part of the ld.acq ot st.rel
> instructions that are used to set/clear spinlocks.
[...]
> IA64 implements fencing of ld.acq or st.rel instructions as one-directional
> barriers.

So ia64 spin_unlock doesn't do store-store ordering across it. I'm
surprised this is the first time this causes problems. Other architectures
seem to order:

* sparc64 does a membar StoreStore|LoadStore
* powerpc does lwsync or sync, depending on arch
* alpha does an mb();

* x86 is in-order

So, sounds to me like you need to fix your lock primitives, not add
barriers to generic code?


-Olof
