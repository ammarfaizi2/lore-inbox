Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751887AbWCIM20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887AbWCIM20 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 07:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751873AbWCIM2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 07:28:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43458 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751853AbWCIM2Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 07:28:24 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0603082127110.32577@g5.osdl.org> 
References: <Pine.LNX.4.64.0603082127110.32577@g5.osdl.org>  <Pine.LNX.4.64.0603081115300.32577@g5.osdl.org> <20060308184500.GA17716@devserv.devel.redhat.com> <20060308173605.GB13063@devserv.devel.redhat.com> <20060308145506.GA5095@devserv.devel.redhat.com> <31492.1141753245@warthog.cambridge.redhat.com> <29826.1141828678@warthog.cambridge.redhat.com> <9834.1141837491@warthog.cambridge.redhat.com> <11922.1141842907@warthog.cambridge.redhat.com> <14275.1141844922@warthog.cambridge.redhat.com> <19984.1141846302@warthog.cambridge.redhat.com> <17423.30789.214209.462657@cargo.ozlabs.ibm.com> <Pine.LNX.4.64.0603081652430.32577@g5.osdl.org> <17423.32792.500628.226831@cargo.ozlabs.ibm.com> <Pine.LNX.4.64.0603081716400.32577@g5.osdl.org> <17423.42185.78767.837295@cargo.ozlabs.ibm.com> 
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, akpm@osdl.org,
       linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
       mingo@redhat.com, Alan Cox <alan@redhat.com>, linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #2] 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Thu, 09 Mar 2006 12:27:54 +0000
Message-ID: <25437.1141907274@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:

> > A spin_lock does show up on the bus, doesn't it?
> 
> Nope.

Yes, sort of, under some circumstances. If the CPU doing the spin_lock()
doesn't own the cacheline with the lock, it'll have to resort to the bus to
grab the cacheline from the current owner (so another CPU would at least see a
read).

The effect of the spin_lock() might not be seen outside of the CPU before the
spin_unlock() occurs, but it *will* be committed to the CPU's cache, and given
cache coherency mechanisms, that's effectively the same as main memory.

So it's in effect visible on the bus, given that it will be transferred to
another CPU when requested; and as long as the other CPUs expect to see the
effects and the ordering imposed, it's immaterial whether the content of the
spinlock is actually ever committed to SDRAM or whether it remains perpetually
in one or another's CPU cache.

David
