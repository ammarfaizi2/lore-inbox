Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277698AbRJICSp>; Mon, 8 Oct 2001 22:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277697AbRJICSh>; Mon, 8 Oct 2001 22:18:37 -0400
Received: from pizda.ninka.net ([216.101.162.242]:56968 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S277702AbRJICSW>;
	Mon, 8 Oct 2001 22:18:22 -0400
Date: Mon, 08 Oct 2001 19:18:47 -0700 (PDT)
Message-Id: <20011008.191847.15267448.davem@redhat.com>
To: pmckenne@us.ibm.com
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: RFC: patch to allow lock-free traversal of lists with insertion
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200110090155.f991tPt22329@eng4.beaverton.ibm.com>
In-Reply-To: <200110090155.f991tPt22329@eng4.beaverton.ibm.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Paul E. McKenney" <pmckenne@us.ibm.com>
   Date: Mon, 8 Oct 2001 18:55:24 -0700 (PDT)

   I am particularly interested in comments from people who understand
   the detailed operation of the SPARC membar instruction and the PARISC
   SYNC instruction.  My belief is that the membar("#SYNC") and SYNC
   instructions are sufficient,
   
SYNC is sufficient but way too strict.  You don't explicitly say what
you need to happen.  If you need all previous stores to finish
before all subsequent memory operations then:

	membar #StoreStore | #StoreLoad

is sufficient.  If you need all previous memory operations to finish
before all subsequent stores then:

	membar #StoreStore | #LoadStore

is what you want.

   Thoughts?

I think if you need to perform IPIs and junk like that to make the
memory barrier happen correctly, just throw your code away and use a
spinlock instead.

Franks a lot,
David S. Miller
davem@redhat.com
