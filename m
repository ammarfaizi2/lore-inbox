Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbTJAGsD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 02:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262018AbTJAGsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 02:48:03 -0400
Received: from ns.suse.de ([195.135.220.2]:59090 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262016AbTJAGsB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 02:48:01 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: jamie@shareable.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Mutilated form of Andi Kleen's AMD prefetch errata  patch
References: <7F740D512C7C1046AB53446D3720017304AFCF@scsmsx402.sc.intel.com.suse.lists.linux.kernel>
	<20031001053833.GB1131@mail.shareable.org.suse.lists.linux.kernel>
	<20030930224853.15073447.akpm@osdl.org.suse.lists.linux.kernel>
	<20031001061348.GE1131@mail.shareable.org.suse.lists.linux.kernel>
	<20030930233258.37ed9f7f.akpm@osdl.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 01 Oct 2003 08:47:58 +0200
In-Reply-To: <20030930233258.37ed9f7f.akpm@osdl.org.suse.lists.linux.kernel>
Message-ID: <p73k77pzc69.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Looking at Andi's patch, it is also a dead box if the fault happens inside
> down_write(mmap_sem).  That should be fixed, methinks.

The only way to fix all that would be to move the instruction checks early
into the fast path.

[On a P4 the overhead is 3.7268 vs 3.6594 microseconds for a fault that 
doesn't hit as measured by lmbench2's lat_sig. This was before the latest 
changes which added more checking, so the overhead is probably bigger now]

-Andi
