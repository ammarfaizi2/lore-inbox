Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbWCaDMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbWCaDMU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 22:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbWCaDMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 22:12:19 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:20188 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751211AbWCaDMS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 22:12:18 -0500
Date: Thu, 30 Mar 2006 19:12:11 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Zoltan Menyhart <Zoltan.Menyhart@bull.net>,
       "Boehm, Hans" <hans.boehm@hp.com>,
       "Grundler, Grant G" <grant.grundler@hp.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: RE: Synchronizing Bit operations V2
In-Reply-To: <200603310309.k2V39dg28480@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.64.0603301909590.3145@schroedinger.engr.sgi.com>
References: <200603310309.k2V39dg28480@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Mar 2006, Chen, Kenneth W wrote:

> Christoph Lameter wrote on Thursday, March 30, 2006 7:02 PM
> > We are talking about IA64 and IA64 only generates an single instruction 
> > with either release or acquire semantics for the case in which either 
> > smb_mb__before/after_clear_bit does nothing.
> > 
> > Neither acquire nor release is a memory barrier on IA64.
> 
> 
> The use of
>         smp_mb__before_clear_bit();
>         clear_bit( ... );
> 
> is: all memory operations before this call will be visible before
> the clear_bit().  To me, that's release semantics.

What of it? Release semantics are not a full fence or memory barrier.

> On ia64, we map the following:
> #define Smp_mb__before_clear_bit      do { } while (0)
> #define clear_bit                     clear_bit_mode(..., RELEASE)
> 
> Which looked perfect fine to me.  I don't understand why you say it does
> not provide memory ordering.

It does not provide a memory barrier / fence. Later memory references can 
still be moved by the processor above the instruction with release semantics.
