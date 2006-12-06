Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937337AbWLFT0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937337AbWLFT0g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 14:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937442AbWLFT0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 14:26:35 -0500
Received: from smtp.osdl.org ([65.172.181.25]:60110 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937337AbWLFT0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 14:26:34 -0500
Date: Wed, 6 Dec 2006 11:25:35 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
cc: Christoph Lameter <clameter@sgi.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-arm-kernel@lists.arm.linux.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch
 doesn't support it
In-Reply-To: <20061206190828.GE4587@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0612061122120.3542@woody.osdl.org>
References: <20061206164314.19870.33519.stgit@warthog.cambridge.redhat.com>
 <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0612061103260.3542@woody.osdl.org> <20061206190828.GE4587@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Dec 2006, Al Viro wrote:
> 
> No.  sparc32 doesn't have one, for instance.

Ok. For SMP-safety, it's important that any architecture that can't do 
this needs to _share_ the same spinlock (on SMP only, of course) that it 
uses for the bitops. 

It would be good (but perhaps not as strict a requirement) if the atomic 
counters also use the same lock. But that is probably impossible on 
sparc32 (since it has a per-counter "lock"-like thing, iirc). So doing a 
cmpxchg() on an atomic_t would be a bug.

		Linus
