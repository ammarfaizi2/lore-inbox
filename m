Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbVFUN7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbVFUN7h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 09:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbVFUN4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 09:56:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5550 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261389AbVFUN4I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 09:56:08 -0400
Date: Tue, 21 Jun 2005 09:56:01 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: cutaway@bellsouth.net
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] do_execve() perf improvement opportunity?
In-Reply-To: <000d01c5762c$5e399dc0$2800000a@pc365dualp2>
Message-ID: <Pine.LNX.4.61.0506210954090.14739@chimarrao.boston.redhat.com>
References: <000d01c5762c$5e399dc0$2800000a@pc365dualp2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2005 cutaway@bellsouth.net wrote:

> I'm thinking it may be possible to very cheaply cache a pointer to the 
> last allocation here rather than freeing it and just recycle it for the 
> next exec saving a trip through the slab machanism.

Note that the slab mechanism can do allocations locally
on each CPU in an SMP system, while your pointer would
need some cross-CPU synchronisation.  Also, you could
end up using the bprm from a CPU on a remote NUMA node,
instead of a local piece of memory.

Still, it would be interesting/educational to know if your
optimisation makes a difference on single CPU systems.

-- 
The Theory of Escalating Commitment: "The cost of continuing mistakes is
borne by others, while the cost of admitting mistakes is borne by yourself."
  -- Joseph Stiglitz, Nobel Laureate in Economics
