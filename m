Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261913AbVASVtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbVASVtN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 16:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbVASVry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 16:47:54 -0500
Received: from ozlabs.org ([203.10.76.45]:26337 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261913AbVASVn3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 16:43:29 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16878.54402.344079.528038@cargo.ozlabs.ibm.com>
Date: Thu, 20 Jan 2005 08:43:30 +1100
From: Paul Mackerras <paulus@samba.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Peter Chubb <peterc@gelato.unsw.edu.au>, Tony Luck <tony.luck@intel.com>,
       Darren Williams <dsw@gelato.unsw.edu.au>, Andrew Morton <akpm@osdl.org>,
       Chris Wedgwood <cw@f00f.org>, torvalds@osdl.org,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
       Ia64 Linux <linux-ia64@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: Horrible regression with -CURRENT from "Don't busy-lock-loop in preemptable spinlocks" patch
In-Reply-To: <20050119092013.GA2045@elte.hu>
References: <20050117055044.GA3514@taniwha.stupidest.org>
	<20050116230922.7274f9a2.akpm@osdl.org>
	<20050117143301.GA10341@elte.hu>
	<20050118014752.GA14709@cse.unsw.EDU.AU>
	<16877.42598.336096.561224@wombat.chubb.wattle.id.au>
	<20050119080403.GB29037@elte.hu>
	<16878.9678.73202.771962@wombat.chubb.wattle.id.au>
	<20050119092013.GA2045@elte.hu>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar writes:

> * Peter Chubb <peterc@gelato.unsw.edu.au> wrote:
> 
> > >> Here's a patch that adds the missing read_is_locked() and
> > >> write_is_locked() macros for IA64.  When combined with Ingo's
> > >> patch, I can boot an SMP kernel with CONFIG_PREEMPT on.
> > >> 
> > >> However, I feel these macros are misnamed: read_is_locked() returns
> > >> true if the lock is held for writing; write_is_locked() returns
> > >> true if the lock is held for reading or writing.
> > 
> > Ingo> well, 'read_is_locked()' means: "will a read_lock() succeed"
> > 
> > Fail, surely?
> 
> yeah ... and with that i proved beyond doubt that the naming is indeed
> unintuitive :-)

Yes.  Intuitively read_is_locked() is true when someone has done a
read_lock and write_is_locked() is true when someone has done a write
lock.

I suggest read_poll(), write_poll(), spin_poll(), which are like
{read,write,spin}_trylock but don't do the atomic op to get the lock,
that is, they don't change the lock value but return true if the
trylock would succeed, assuming no other cpu takes the lock in the
meantime.

Regards,
Paul.
