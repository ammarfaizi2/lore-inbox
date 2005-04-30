Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbVD3Qkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbVD3Qkq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 12:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbVD3Qkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 12:40:46 -0400
Received: from pat.uio.no ([129.240.130.16]:10149 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261282AbVD3Qkk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 12:40:40 -0400
Subject: Re: [RFC] unify semaphore implementations
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Paul Mackerras <paulus@samba.org>
Cc: Benjamin LaHaise <bcrl@kvack.org>, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <17010.58144.95239.716600@cargo.ozlabs.ibm.com>
References: <20050428182926.GC16545@kvack.org>
	 <17009.33633.378204.859486@cargo.ozlabs.ibm.com>
	 <20050429141437.GA24617@kvack.org>
	 <1114789320.10086.81.camel@lade.trondhjem.org>
	 <17010.58144.95239.716600@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Sat, 30 Apr 2005 12:40:29 -0400
Message-Id: <1114879229.14213.18.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.494, required 12,
	autolearn=disabled, AWL 1.46, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On lau , 2005-04-30 at 11:45 +1000, Paul Mackerras wrote:

> What is "your machine"?  Is a single cmpxchg really slower than
> locking and unlocking a spinlock?  If so, by how much?

Sorry. Thinking back, I realize that I was testing the non-irqsafe
spinlocks, since that was the only case that was of interest for the
iosem stuff. I should go back and test for the case of irqsafe ones.

FYI, though, the machine on which I tested it is a mobile P4. When
averaging over 1000 iterations, a single bus-locked cmpxchg took more
than twice the amount of time to complete than a single bus-locked incb
or decb (as used in the 386 spinlock implementations).
The spinlocked version was therefore not much faster for the fast path,
but for the slow path you do only a single spin_lock/spin_unlock
combination instead of cmpxchg+spinlock/spinunlock. It is therefore
twice as fast.

Cheers,
  Trond

