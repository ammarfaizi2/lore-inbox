Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbWCaRnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbWCaRnN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 12:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbWCaRnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 12:43:13 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:65186 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750952AbWCaRnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 12:43:11 -0500
Date: Fri, 31 Mar 2006 09:43:00 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Zoltan Menyhart <Zoltan.Menyhart@bull.net>,
       "Boehm, Hans" <hans.boehm@hp.com>,
       "Grundler, Grant G" <grant.grundler@hp.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Synchronizing Bit operations V2
In-Reply-To: <442CAC11.4070803@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0603310939570.6628@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0603301300430.1014@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0603301615540.2023@schroedinger.engr.sgi.com>
 <442C7B51.1060203@yahoo.com.au> <Pine.LNX.4.64.0603301921550.3145@schroedinger.engr.sgi.com>
 <442CAC11.4070803@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Mar 2006, Nick Piggin wrote:

> > 
> > Right. From the earlier conversation I had the impression that this is what
> > you wanted.
> Perhaps it is the best way to go, but you need to fix ia64's
> current problems first. Again -- you don't plan to audit and
> convert _all_ current users in one go do you?

No. If you look at the patch you will see that this fixes the ia64 
problems for the existing scheme and then allows the use of new _mode 
bitops if you include bitops_mode.h from core code. This is designed for a 
gradual change.

> You acknowledge that you have to fix ia64 to match current semantics
> first, right?

Right. I believe I have done so by making both smb_mb_* full barriers.

> Now people seem to be worried about the performance impact that will
> have, so I simply suggest that adding two or three new macros for the
> important cases to give you a 90% solution.

We could transition some key locations of core code to use _mode bitops
if there are performance problems.

> I think Documentation/atomic_ops.txt isn't bad. smp_mb__* really
> is a smp_mb, which can be optimised sometimes.

Ok. Then we are on the same page and the solution I presented may be 
acceptable. I have a new rev here that changes the naming a bit but I 
think we are okay right?

