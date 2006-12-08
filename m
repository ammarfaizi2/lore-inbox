Return-Path: <linux-kernel-owner+w=401wt.eu-S1761157AbWLHTEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761157AbWLHTEc (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 14:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761160AbWLHTEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 14:04:32 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:4411 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761155AbWLHTEb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 14:04:31 -0500
Date: Fri, 8 Dec 2006 19:04:03 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Howells <dhowells@redhat.com>, Christoph Lameter <clameter@sgi.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, akpm@osdl.org,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch doesn't support it
Message-ID: <20061208190403.GH31068@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	David Howells <dhowells@redhat.com>,
	Christoph Lameter <clameter@sgi.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>, akpm@osdl.org,
	linux-arm-kernel@lists.arm.linux.org.uk,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com> <20061206190025.GC9959@flint.arm.linux.org.uk> <Pine.LNX.4.64.0612061111130.27263@schroedinger.engr.sgi.com> <20061206195820.GA15281@flint.arm.linux.org.uk> <4577DF5C.5070701@yahoo.com.au> <20061207150303.GB1255@flint.arm.linux.org.uk> <4578BD7C.4050703@yahoo.com.au> <20061208085634.GA25751@flint.arm.linux.org.uk> <4595.1165597017@redhat.com> <Pine.LNX.4.64.0612081045430.3516@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612081045430.3516@woody.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2006 at 10:46:17AM -0800, Linus Torvalds wrote:
> 
> 
> On Fri, 8 Dec 2006, David Howells wrote:
> > 
> > In fact I think more things have LL/SC than have CMPXCHG.
> 
> But you cannot expose ll/sc to C, so that's a bogus argument.

Yes you can.  Well, you can on ARM at least.  Between the load exclusive
you can do anything you like until you hit the store exclusive.  If you
haven't touched the location (with anything other than another load
exclusive) and no other CPU has issued a load exclusive, your store
exclusive succeeds.  Whether you have branches, loads or stores to
other locations, etc.  None of that matters.

Not so bogus as you make out.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
