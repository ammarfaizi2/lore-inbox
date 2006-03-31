Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbWCaAw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbWCaAw2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 19:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWCaAw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 19:52:28 -0500
Received: from mga03.intel.com ([143.182.124.21]:20308 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751096AbWCaAw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 19:52:27 -0500
X-IronPort-AV: i="4.03,148,1141632000"; 
   d="scan'208"; a="17145927:sNHT25605188"
Message-Id: <200603310052.k2V0qQg26856@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Christoph Lameter'" <clameter@sgi.com>
Cc: "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Zoltan Menyhart" <Zoltan.Menyhart@bull.net>,
       "Boehm, Hans" <hans.boehm@hp.com>,
       "Grundler, Grant G" <grant.grundler@hp.com>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
Subject: RE: Synchronizing Bit operations V2
Date: Thu, 30 Mar 2006 16:53:11 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZUXAG21lXprQUaTYu04PO/eGNctwAARc9g
In-Reply-To: <Pine.LNX.4.64.0603301639530.2068@schroedinger.engr.sgi.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote on Thursday, March 30, 2006 4:43 PM
> > > Note that the current semantics for bitops IA64 are broken. Both
> > > smp_mb__after/before_clear_bit are now set to full memory barriers
> > > to compensate
> > 
> > Why you say that?  clear_bit has built-in acq or rel semantic depends
> > on how you define it. I think only one of smp_mb__after/before need to
> > be smp_mb?
> 
> clear_bit has no barrier semantics just acquire. Therefore both smp_mb_* 
> need to be barriers or they need to add some form of "release".

We are talking about arch specific implementation of clear_bit and smp_mb_*.
Yes, for generic code, clear_bit has no implication of memory ordering, but
for arch specific code, one should optimize those three functions with the
architecture knowledge of exactly what's happening under the hood.

- Ken
