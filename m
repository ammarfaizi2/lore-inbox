Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751390AbWEIXEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbWEIXEO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 19:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWEIXEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 19:04:13 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:37506 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751390AbWEIXEN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 19:04:13 -0400
Date: Tue, 9 May 2006 16:07:18 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 05/35] Add sync bitops
Message-ID: <20060509230718.GC24291@moss.sous-sol.org>
References: <20060509084945.373541000@sous-sol.org> <20060509085149.024456000@sous-sol.org> <Pine.LNX.4.64.0605091555540.30338@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605091555540.30338@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Christoph Lameter (clameter@sgi.com) wrote:
> On Tue, 9 May 2006, Chris Wright wrote:
> 
> > Add "always lock'd" implementations of set_bit, clear_bit and
> > change_bit and the corresponding test_and_ functions.  Also add
> > "always lock'd" implementation of cmpxchg.  These give guaranteed
> > strong synchronisation and are required for non-SMP kernels running on
> > an SMP hypervisor.
> 
> Could you explain why this is done and what is exactly meant with "always 
> looked"? Wh the performance impact?

The standard UP bitops are not atomic.  But a UP guest may be on SMP
machine, and the bitmaps here are shared between guests.  The always
locked means the lock prefix is not conditional on either UP build
(or smp alternatives patching), and memory barriers are in place.
There's no performance penalty unless you use them, as it's a new set
(somewhat similar to the bitops changes you were looking into).  Although,
this is the simplest, with no multiplexing, simply new interface, synch_*.
Open to ideas here.  Xen is another possible consumer of your bitops
changes.

thanks,
-chris
