Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267750AbUHPPYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267750AbUHPPYc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 11:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267711AbUHPPU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 11:20:29 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:49586 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267713AbUHPPTG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 11:19:06 -0400
Date: Mon, 16 Aug 2004 08:18:11 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Ray Bryant <raybry@sgi.com>
cc: "David S. Miller" <davem@redhat.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: page fault fastpath: Increasing SMP scalability by introducing
 pte locks?
In-Reply-To: <41205BAA.9030800@sgi.com>
Message-ID: <Pine.LNX.4.58.0408160817210.8293@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0408150630560.324@schroedinger.engr.sgi.com>
 <20040815130919.44769735.davem@redhat.com> <Pine.LNX.4.58.0408151552280.3370@schroedinger.engr.sgi.com>
 <20040815165827.0c0c8844.davem@redhat.com> <Pine.LNX.4.58.0408151703580.3751@schroedinger.engr.sgi.com>
 <20040815185644.24ecb247.davem@redhat.com> <Pine.LNX.4.58.0408151924250.4480@schroedinger.engr.sgi.com>
 <41205BAA.9030800@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Aug 2004, Ray Bryant wrote:

> Something else to worry about here is mm->rss.  Previously, this was updated
> only with the page_table_lock held, so concurrent increments were not a
> problem.  rss may need to converted be an atomic_t if you use pte_locks.
> It may be that an approximate value for rss is good enough, but I'm not sure
> how to bound the error that could be introduced by a couple of hundred
> processers handling page faults in parallel and updating rss without locking
> it or making it an atomic_t.

Correct. There are a number of issues that may have to be addressed but
first we need to agree on a general idea how to proceed.

