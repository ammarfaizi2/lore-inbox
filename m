Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932371AbVJDN1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbVJDN1R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 09:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbVJDN1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 09:27:17 -0400
Received: from cantor.suse.de ([195.135.220.2]:39060 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932371AbVJDN1Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 09:27:16 -0400
To: Rohit Seth <rohit.seth@intel.com>
Cc: akpm@osdl.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Clean up of __alloc_pages
References: <20051001120023.A10250@unix-os.sc.intel.com>
	<Pine.LNX.4.62.0510030828400.7812@schroedinger.engr.sgi.com>
	<1128358558.8472.13.camel@akash.sc.intel.com>
	<Pine.LNX.4.62.0510030952520.8266@schroedinger.engr.sgi.com>
	<1128361714.8472.44.camel@akash.sc.intel.com>
From: Andi Kleen <ak@suse.de>
Date: 04 Oct 2005 15:27:08 +0200
In-Reply-To: <1128361714.8472.44.camel@akash.sc.intel.com>
Message-ID: <p733bnh1kgj.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rohit Seth <rohit.seth@intel.com> writes:
> 
> I think conceptually this ask for a new flag __GFP_NODEONLY that
> indicate allocations to come from current node only. 
> 
> This definitely though means I will need to separate out the allocation
> from pcp patch (as Nick suggested earlier).

This reminds me - the current logic is currently a bit suboptimal on
many NUMA systems. Often it would be better to be a bit more
aggressive at freeing memory (maybe do a very low overhead light try to
free pages) in the first node before falling back to other nodes. What
right now happens is that when you have even minor memory pressure
because e.g. you node is filled up with disk cache the local memory
affinity doesn't work too well anymore.

-Andi
