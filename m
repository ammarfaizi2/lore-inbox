Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935842AbWK3LDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935842AbWK3LDV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 06:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935860AbWK3LDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 06:03:21 -0500
Received: from mx1.redhat.com ([66.187.233.31]:8630 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S935842AbWK3LDU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 06:03:20 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061130003506.GA1248@oleg> 
References: <20061130003506.GA1248@oleg> 
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Alan Stern <stern@rowland.harvard.edu>,
       "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: atomic_add_unless() doesn't imply mb() on failure 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 30 Nov 2006 11:01:53 +0000
Message-ID: <11754.1164884513@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> wrote:

> Most implementations of atomic_add_unless() can fail (return 0) after the
> first atomic_read() (before cmpxchg). In that case we have a compiler
> barrier only.

Ummm...  I wonder if we should instead change the behaviour of
atomic_add_unless() to include an explicit smp_rmb() between the read and the
conditional jump on all archs where this isn't already implied.  Otherwise,
what governs when the initial test going to be done by the CPU?

Note that not all archs do cmpxchg() here, though I don't think that affects
your argument.

David
