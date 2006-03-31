Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbWCaAzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWCaAzQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 19:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbWCaAzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 19:55:16 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:31690 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751091AbWCaAzO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 19:55:14 -0500
Date: Thu, 30 Mar 2006 16:55:08 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Zoltan Menyhart <Zoltan.Menyhart@bull.net>,
       "Boehm, Hans" <hans.boehm@hp.com>,
       "Grundler, Grant G" <grant.grundler@hp.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: RE: Synchronizing Bit operations V2
In-Reply-To: <200603310052.k2V0qQg26856@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.64.0603301653200.2068@schroedinger.engr.sgi.com>
References: <200603310052.k2V0qQg26856@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Mar 2006, Chen, Kenneth W wrote:

> Christoph Lameter wrote on Thursday, March 30, 2006 4:43 PM
> > > > Note that the current semantics for bitops IA64 are broken. Both
> > > > smp_mb__after/before_clear_bit are now set to full memory barriers
> > > > to compensate
> > > 
> > > Why you say that?  clear_bit has built-in acq or rel semantic depends
> > > on how you define it. I think only one of smp_mb__after/before need to
> > > be smp_mb?
> > 
> > clear_bit has no barrier semantics just acquire. Therefore both smp_mb_* 
> > need to be barriers or they need to add some form of "release".
> 
> We are talking about arch specific implementation of clear_bit and smp_mb_*.
> Yes, for generic code, clear_bit has no implication of memory ordering, but
> for arch specific code, one should optimize those three functions with the
> architecture knowledge of exactly what's happening under the hood.

Arch specific code should make this explicit too and not rely on implied 
semantics. Otherwise one has to memorize that functions have to work with 
different semantics in arch code and core code which makes the source 
code difficult to maintain.

