Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163255AbWLGUG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163255AbWLGUG5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 15:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163259AbWLGUG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 15:06:57 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44754 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163255AbWLGUG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 15:06:56 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061207085409.228016a2.akpm@osdl.org> 
References: <20061207085409.228016a2.akpm@osdl.org>  <20061207153138.28408.94099.stgit@warthog.cambridge.redhat.com> <20061207153143.28408.7274.stgit@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org,
       davem@davemloft.com, wli@holomorphy.com, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 3/3] WorkStruct: Use direct assignment rather than cmpxchg() 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 07 Dec 2006 20:06:39 +0000
Message-ID: <639.1165521999@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> and we can assume (and ensure) that a failing test_and_set_bit() will not
> write to the affected word at all.

You may not assume that; and indeed that is not so in the generic
spinlock-based bitops or ARM pre-v6 or PA-RISC or sparc32 or ...

Remember: if you have to put a conditional jump in there, it's going to fail
one way or the other a certain percentage of the time, and that's going to
cause a pipeline stall, and these ops are used quite a lot.

OTOH, I don't know that the stall would be that bad since the spin_lock and
spin_unlock may cause a stall anyway.

David
