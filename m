Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937454AbWLFT3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937454AbWLFT3m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 14:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937494AbWLFT3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 14:29:42 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:34668 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937462AbWLFT3k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 14:29:40 -0500
Date: Wed, 6 Dec 2006 12:29:39 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, Christoph Lameter <clameter@sgi.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-arm-kernel@lists.arm.linux.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch doesn't support it
Message-ID: <20061206192939.GX3013@parisc-linux.org>
References: <20061206164314.19870.33519.stgit@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com> <Pine.LNX.4.64.0612061103260.3542@woody.osdl.org> <20061206190828.GE4587@ftp.linux.org.uk> <Pine.LNX.4.64.0612061122120.3542@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612061122120.3542@woody.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2006 at 11:25:35AM -0800, Linus Torvalds wrote:
> Ok. For SMP-safety, it's important that any architecture that can't do 
> this needs to _share_ the same spinlock (on SMP only, of course) that it 
> uses for the bitops. 

That doesn't help, since assignment can't be guarded by any lock.

> It would be good (but perhaps not as strict a requirement) if the atomic 
> counters also use the same lock. But that is probably impossible on 
> sparc32 (since it has a per-counter "lock"-like thing, iirc). So doing a 
> cmpxchg() on an atomic_t would be a bug.

sparc32 switched over to the parisc way of doing things, so they could
expand their atomic_t to a full 32 bits.  They still have the old
atomic_24_t lying around for their arch-private use, but atomic_t uses a
hashed spinlock.
