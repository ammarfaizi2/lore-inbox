Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262167AbVATPz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262167AbVATPz7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 10:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbVATPzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 10:55:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:45493 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262175AbVATPvb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 10:51:31 -0500
Date: Thu, 20 Jan 2005 07:51:08 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
cc: Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       paulus@samba.org, linux-kernel@vger.kernel.org, mingo@elte.hu,
       tony.luck@intel.com, dsw@gelato.unsw.edu.au, benh@kernel.crashing.org,
       linux-ia64@vger.kernel.org, hch@infradead.org, wli@holomorphy.com,
       jbarnes@sgi.com
Subject: Re: [PATCH RFC] 'spinlock/rwlock fixes' V3 [1/1]
In-Reply-To: <16879.29449.734172.893834@wombat.chubb.wattle.id.au>
Message-ID: <Pine.LNX.4.58.0501200747230.8178@ppc970.osdl.org>
References: <20050116230922.7274f9a2.akpm@osdl.org> <20050117143301.GA10341@elte.hu>
 <20050118014752.GA14709@cse.unsw.EDU.AU> <16877.42598.336096.561224@wombat.chubb.wattle.id.au>
 <20050119080403.GB29037@elte.hu> <16878.9678.73202.771962@wombat.chubb.wattle.id.au>
 <20050119092013.GA2045@elte.hu> <16878.54402.344079.528038@cargo.ozlabs.ibm.com>
 <20050120023445.GA3475@taniwha.stupidest.org> <20050119190104.71f0a76f.akpm@osdl.org>
 <20050120031854.GA8538@taniwha.stupidest.org> <16879.29449.734172.893834@wombat.chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 Jan 2005, Peter Chubb wrote:
> 
> I suggest reversing the sense of the macros, and having read_can_lock()
> and write_can_lock()
> 
> Meaning:
> 	read_can_lock() --- a read_lock() would have succeeded
> 	write_can_lock() --- a write_lock() would have succeeded.

Yes. This has the advantage of being readable, and the "sense" of the test 
always being obvious.

We have a sense problem with the "trylock()" cases - some return "it was
locked" (semaphores), and some return "I succeeded" (spinlocks), so not
only is the sense not immediately obvious from the usage, it's actually
_different_ for semaphores and for spinlocks.

So I like "read_can_lock()", since it's also obvious what it returns.

(And yes, we should fix the semaphore trylock return code, dammit.)

		Linus
