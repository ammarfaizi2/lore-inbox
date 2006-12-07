Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937909AbWLGBT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937909AbWLGBT1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 20:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937912AbWLGBT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 20:19:27 -0500
Received: from smtp.osdl.org ([65.172.181.25]:33886 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937909AbWLGBTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 20:19:25 -0500
Date: Wed, 6 Dec 2006 17:18:48 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Matthew Wilcox <matthew@wil.cx>, Christoph Lameter <clameter@sgi.com>,
       David Howells <dhowells@redhat.com>, akpm@osdl.org,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch
 doesn't support it
In-Reply-To: <Pine.LNX.4.64.0612070203520.1867@scrub.home>
Message-ID: <Pine.LNX.4.64.0612061717030.3542@woody.osdl.org>
References: <20061206164314.19870.33519.stgit@warthog.cambridge.redhat.com>
 <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com>
 <20061206190025.GC9959@flint.arm.linux.org.uk>
 <Pine.LNX.4.64.0612061111130.27263@schroedinger.engr.sgi.com>
 <20061206195820.GA15281@flint.arm.linux.org.uk> <20061206213626.GE3013@parisc-linux.org>
 <Pine.LNX.4.64.0612061345160.28672@schroedinger.engr.sgi.com>
 <20061206220532.GF3013@parisc-linux.org> <Pine.LNX.4.64.0612070130240.1868@scrub.home>
 <Pine.LNX.4.64.0612061650240.3542@woody.osdl.org> <Pine.LNX.4.64.0612070203520.1867@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Dec 2006, Roman Zippel wrote:
> > 
> > Any _real_ CPU will simply never care about _anything_ else than just the 
> > size of the datum in question.
> 
> ..or alignment which a dedicated atomic type would allow to be attached.

Can you give any example of a real CPU where alignment matters?

Sure, it needs to be naturally aligned, but that's true of _any_ type in 
the kernel. We don't do unaligneds without "get_unaligned()" and friends.

Btw, if you want to leave out 8-bit and 16-bit data, that's fine. So 
generally you'd only need to handle 32-bit (and 64-bit on a 64-bit 
architecture) accesses anyway.

		Linus
