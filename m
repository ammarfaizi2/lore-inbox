Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbVJOXHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbVJOXHV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 19:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbVJOXHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 19:07:20 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:8122
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751252AbVJOXHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 19:07:20 -0400
Date: Sat, 15 Oct 2005 16:07:02 -0700 (PDT)
Message-Id: <20051015.160702.128767261.davem@davemloft.net>
To: andrea@suse.de
Cc: herbert@gondor.apana.org.au, nickpiggin@yahoo.com.au,
       benh@kernel.crashing.org, hugh@veritas.com, paulus@samba.org,
       anton@samba.org, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Possible memory ordering bug in page reclaim?
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051015200701.GP18159@opteron.random>
References: <20051015180018.GN18159@opteron.random>
	<20051015194855.GA1164@gondor.apana.org.au>
	<20051015200701.GP18159@opteron.random>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Arcangeli <andrea@suse.de>
Date: Sat, 15 Oct 2005 22:07:01 +0200

> sure see alpha:
> 
> 	__asm__ __volatile__(
> 	"1:	ldq_l %0,%1\n"
> 	"	addq %0,%3,%2\n"
> 	"	addq %0,%3,%0\n"
> 	"	stq_c %0,%1\n"
> 	"	beq %0,2f\n"
> 	"	mb\n"
> 
> the memory barrier is applied way after the write is visible to other
> cpus, you can even get an irq before the mb and block there for some
> usec.

For atomic operations returning values, there must be a memory
barrier both before and after the atomic operation.  This is
defined in Documentation/atomic_ops.txt, so Alpha needs to be
fixed to add a memory barrier at the beginning of these
assembler sequences.
