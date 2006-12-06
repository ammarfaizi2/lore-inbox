Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937327AbWLFTRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937327AbWLFTRT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 14:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937295AbWLFTRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 14:17:18 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:54360 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S937240AbWLFTRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 14:17:17 -0500
Date: Wed, 6 Dec 2006 11:16:55 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch
 doesn't support it
In-Reply-To: <20061206190025.GC9959@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0612061111130.27263@schroedinger.engr.sgi.com>
References: <20061206164314.19870.33519.stgit@warthog.cambridge.redhat.com>
 <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com>
 <20061206190025.GC9959@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2006, Russell King wrote:

> On Wed, Dec 06, 2006 at 10:56:14AM -0800, Christoph Lameter wrote:
> > I'd really appreciate a cmpxchg that is generically available for 
> > all arches. It will allow lockless implementation for various performance 
> > criticial portions of the kernel.
> 
> Let's recap on cmpxchg.
> 
> For CPUs with no atomic operation other than SWP, it is not lockless.

But then its also just requires disable/enable interrupts on UP which may 
be cheaper than an atomic operation.

> For CPUs with load locked + store conditional, it is expensive.

Because it locks the bus? I am not that familiar with those architectures 
but it seems that those will have a general problem anyways.

> If you want an operation for performance critical portions of the
> kernel, please allow architecture maintainers the freedom to use their
> best performance enhancements.

And thereby denying the kernel developers to use a simple atomic SMP 
operation? Adding additional defines for each arch and each performance 
critical piece of kernel logic?
