Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263262AbTJQAVI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 20:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263263AbTJQAVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 20:21:08 -0400
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:37546 "EHLO
	DYN320019.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id S263262AbTJQAVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 20:21:06 -0400
Date: Thu, 16 Oct 2003 10:17:11 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: "M. Fioretti" <m.fioretti@inwind.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6: new features and older computers
Message-ID: <20031016171711.GA1676@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20031006052154.GB26388@inwind.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031006052154.GB26388@inwind.it>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Marco,

I can help with one of these...

On Mon, Oct 06, 2003 at 07:21:54AM +0200, M. Fioretti wrote:
> 4) What is RCU and which kind of performances it will improve

RCU is a locking mechanism that is useful primarily for read-mostly
data structures.  It can be thought of as a reader-writer lock in which
the readers need not actually do anything, which means that you can
get substantial performance improvements in read-mostly situations.
The writers must perform updates in a careful manner to avoid messing
up the readers.  In particular, if a writer removes an element from a
list, it must wait for a "grace period" before freeing up the element,
since readers might still be referencing it.  RCU provides primitives
that wait for grace periods to elapse.

The best introduction to RCU is probably:

	http://www.linuxjournal.com/article.php?sid=6993

More information on RCU, including performance comparisons in
the Linux kernel may be found at:

	http://www.rdrop.com/users/paulmck/rclock/

					Thanx, Paul
