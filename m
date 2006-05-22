Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWEVLvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWEVLvn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 07:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbWEVLv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 07:51:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:19337 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750780AbWEVLvS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 07:51:18 -0400
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, giri@lmc.cs.sunysb.edu
Subject: Re: __vmalloc with GFP_ATOMIC causes 'sleeping from invalid context'
References: <20060522013648.6FCEAEE9EE@wolfe.lmc.cs.sunysb.edu>
	<447119B3.7000506@yahoo.com.au>
From: Andi Kleen <ak@suse.de>
Date: 22 May 2006 13:18:18 +0200
In-Reply-To: <447119B3.7000506@yahoo.com.au>
Message-ID: <p73fyj271fp.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> writes:

> Giridhar Pemmasani wrote:
> > If __vmalloc is called in atomic context with GFP_ATOMIC flags,
> > __get_vm_area_node is called, which calls kmalloc_node with GFP_KERNEL
> > flags. This causes 'sleeping function called from invalid context at
> > mm/slab.c:2729' with 2.6.16-rc4 kernel. A simple solution is to use
> 
> I can't see what would cause this in either 2.6.16-rc4 or 2.6.17-rc4.
> What is the line?
> 
> > proper flags in __get_vm_area_node, depending on the context:
> 
> I don't think that always works, you might pass in GFP_ATOMIC due to
> having hold of a spinlock, for example.
> 
> Also, vmlist_lock isn't interrupt safe, so it still kind of goes
> against the spirit of GFP_ATOMIC (which is to allow allocation from
> interrupt context).

That's not the only problem. Allocating page table entries or flushing TLBs from
an atomic context is just not supported by the low level architecture code.

-Andi
