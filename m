Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbTJAO6V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 10:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262276AbTJAO5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 10:57:52 -0400
Received: from ns.suse.de ([195.135.220.2]:59830 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262269AbTJAO4f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 10:56:35 -0400
Date: Wed, 1 Oct 2003 16:56:32 +0200
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Jamie Lokier <jamie@shareable.org>, hugh@veritas.com, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Mutilated form of Andi Kleen's AMD prefetch errata patch
Message-ID: <20031001145631.GK22333@wotan.suse.de>
References: <20031001073132.GK1131@mail.shareable.org> <Pine.LNX.4.44.0310010900280.5501-100000@localhost.localdomain> <20031001093329.GA2649@mail.shareable.org> <20031001075151.4e595f99.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031001075151.4e595f99.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm a bit confused as to what significance the faulting address has btw:
> kernel code can raise prefetch faults against addresses which are less
> than, and presumably greater than TASK_SIZE.

Currently it can't - hlist either prefetches to zero or to a valid 
address and everybody else using prefetch should also use valid addresses.

But it's conceivable that future kernels make more extensive use of
prefetch.

e.g. x86-64 hit it because it has prefetch is copy_{from/to}_user /csum_copy_*
and everybody can pass arbitary addresses to that.

-Andi
> 
