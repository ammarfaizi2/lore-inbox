Return-Path: <linux-kernel-owner+w=401wt.eu-S1750840AbXAPK2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbXAPK2i (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 05:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbXAPK21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 05:28:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43216 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750823AbXAPK2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 05:28:23 -0500
Message-Id: <20070116094557.494892000@taijtu.programming.kicks-ass.net>
User-Agent: quilt/0.46-1
Date: Tue, 16 Jan 2007 10:45:57 +0100
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-mm@kvack.org
Cc: David Miller <davem@davemloft.net>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 0/9] VM deadlock avoidance -v10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These patches implement the basic infrastructure to allow swap over networked
storage.

The basic idea is to reserve some memory up front to use when regular memory
runs out.

To bound network behaviour we accept only a limited number of concurrent 
packets and drop those packets that are not aimed at the connection(s) servicing
the VM. Also all network paths that interact with userspace are to be avoided - 
e.g. taps and NF_QUEUE.

PF_MEMALLOC is set when processing emergency skbs. This makes sense in that we
are indeed working on behalf of the swapper/VM. This allows us to use the 
regular memory allocators for processing but requires that said processing have
bounded memory usage and has that accounted in the reserve.

I am particularly looking for comments on the design; is this acceptable?

Kind regards,
Peter
-- 

