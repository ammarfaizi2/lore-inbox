Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268734AbUIQPed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268734AbUIQPed (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 11:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268828AbUIQPdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 11:33:50 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:43176 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S268734AbUIQPP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 11:15:28 -0400
Date: Fri, 17 Sep 2004 17:14:11 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Stelian Pop <stelian@popies.net>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC, 2.6] a simple FIFO implementation
Message-ID: <20040917151411.GY15426@dualathlon.random>
References: <20040917102413.GA3089@crusoe.alcove-fr> <Pine.LNX.4.44.0409171228240.4678-100000@localhost.localdomain> <20040917122400.GD3089@crusoe.alcove-fr> <20040917131523.GQ15426@dualathlon.random> <20040917133656.GF3089@crusoe.alcove-fr> <20040917134145.GT15426@dualathlon.random> <20040917140021.GG3089@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040917140021.GG3089@crusoe.alcove-fr>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2004 at 04:00:21PM +0200, Stelian Pop wrote:
> We could do that by having a 'spinlock_t internal_lock' and a 
> 'spinlock_t * lock' fields, in struct kfifo: we always use 'lock' and
> we initialize lock to either &internal_lock or to the user lock.

the whole point was to save memory, this will actually waste another 4/8
(32bit/64bit) bytes...

note that you would still do the locking in your highlevel inlines, it's
just that the caller will have the responsability of allocating a lock.
