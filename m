Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277176AbRJLDcB>; Thu, 11 Oct 2001 23:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277178AbRJLDbv>; Thu, 11 Oct 2001 23:31:51 -0400
Received: from sydney1.au.ibm.com ([202.135.142.193]:63756 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S277176AbRJLDbk>; Thu, 11 Oct 2001 23:31:40 -0400
Date: Fri, 12 Oct 2001 13:27:33 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: dipankar@in.ibm.com, linux-kernel@vger.kernel.org,
        paul.mckenney@us.ibm.com
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists with insertion
Message-Id: <20011012132733.75734399.rusty@rustcorp.com.au>
In-Reply-To: <Pine.LNX.4.33.0110100302560.1555-100000@penguin.transmeta.com>
In-Reply-To: <20011010153613.A17580@in.ibm.com>
	<Pine.LNX.4.33.0110100302560.1555-100000@penguin.transmeta.com>
X-Mailer: Sylpheed version 0.5.3 (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Oct 2001 03:18:23 -0700 (PDT)
Linus Torvalds <torvalds@transmeta.com> wrote:

> 	lock
> 	unhash
> 	unlock
> 	if (atomic_dec()) {
> 		free
> 	}

And the read side is:
	lock
	loopup
	atomic_inc
	unlock

With RCU, read side is:
	loopup
	atomic_inc

Write is:
	lock /* protect against other writes */
	unhash /* be careful with wmb()s here... */
	unlock
	call_rcu(if (atomic_dec()) free) /* ie. does this later */

Clear?
Rusty.
