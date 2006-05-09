Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbWEIXEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWEIXEj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 19:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbWEIXEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 19:04:39 -0400
Received: from cantor2.suse.de ([195.135.220.15]:11467 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932067AbWEIXEi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 19:04:38 -0400
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [RFC PATCH 05/35] Add sync bitops
Date: Wed, 10 May 2006 01:04:34 +0200
User-Agent: KMail/1.9.1
Cc: Christoph Lameter <clameter@sgi.com>, Chris Wright <chrisw@sous-sol.org>,
       xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       Ian Pratt <ian.pratt@xensource.com>
References: <20060509084945.373541000@sous-sol.org> <20060509085149.024456000@sous-sol.org> <Pine.LNX.4.64.0605091555540.30338@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0605091555540.30338@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605100104.34751.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 May 2006 00:56, Christoph Lameter wrote:
> On Tue, 9 May 2006, Chris Wright wrote:
> 
> > Add "always lock'd" implementations of set_bit, clear_bit and
> > change_bit and the corresponding test_and_ functions.  Also add
> > "always lock'd" implementation of cmpxchg.  These give guaranteed
> > strong synchronisation and are required for non-SMP kernels running on
> > an SMP hypervisor.
> 
> Could you explain why this is done and what is exactly meant with "always 
> looked"? Wh the performance impact?

When UP guest runs on SMP hypervisor they still need the LOCK prefix
to talk to the hypervisor through shared memory in a smp safe way.

Normally UP kernels don't use any LOCK prefixes.

I suggested to refactor the bitops this way earlier for this.

-Andi

