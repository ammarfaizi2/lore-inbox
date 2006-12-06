Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937690AbWLFVwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937690AbWLFVwp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 16:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937689AbWLFVwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 16:52:45 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:58613 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S937686AbWLFVwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 16:52:44 -0500
Date: Wed, 6 Dec 2006 13:52:20 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Matthew Wilcox <matthew@wil.cx>
cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch
 doesn't support it
In-Reply-To: <20061206213626.GE3013@parisc-linux.org>
Message-ID: <Pine.LNX.4.64.0612061345160.28672@schroedinger.engr.sgi.com>
References: <20061206164314.19870.33519.stgit@warthog.cambridge.redhat.com>
 <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com>
 <20061206190025.GC9959@flint.arm.linux.org.uk>
 <Pine.LNX.4.64.0612061111130.27263@schroedinger.engr.sgi.com>
 <20061206195820.GA15281@flint.arm.linux.org.uk> <20061206213626.GE3013@parisc-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2006, Matthew Wilcox wrote:

> And for those of us with only load-and-zero, that's simply:
> 
> #define load_locked(addr) spin_lock(hash(addr)), *addr
> #define store_exclusive(addr, old, new) \
> 			*addr = new, spin_unlock(hash(addr)), 0
> 
> which is also optimal for us.

This means we tolerate the assignment race for SMP that was pointed out 
earlier?

cmpxchg emulation may then also be tolerable just replace the irq 
enable/disable in David's implementation with taking a spin lock?

