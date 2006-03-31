Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbWCaCun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbWCaCun (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 21:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWCaCun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 21:50:43 -0500
Received: from mga02.intel.com ([134.134.136.20]:38747 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751194AbWCaCum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 21:50:42 -0500
TrustExchangeSourcedMail: True
X-ExchangeTrusted: True
X-IronPort-AV: i="4.03,148,1141632000"; 
   d="scan'208"; a="17469586:sNHT64813133"
Message-Id: <200603310250.k2V2ofg28252@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Christoph Lameter'" <clameter@sgi.com>
Cc: "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       "'Zoltan Menyhart'" <Zoltan.Menyhart@bull.net>,
       "'Boehm, Hans'" <hans.boehm@hp.com>,
       "'Grundler, Grant G'" <grant.grundler@hp.com>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
Subject: RE: Synchronizing Bit operations V2
Date: Thu, 30 Mar 2006 18:51:25 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZUbBRx1vz5K0SWTY+Ui73TZutghAAAEYkQAAA62MA=
In-Reply-To: 
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, Kenneth W wrote on Thursday, March 30, 2006 6:45 PM
> Christoph Lameter wrote on Thursday, March 30, 2006 6:38 PM
> > > > Neither one is correct because there will always be one combination of 
> > > > clear_bit with these macros that does not generate the required memory 
> > > > barrier.
> > > 
> > > Can you give an example?  Which combination?
> > 
> > For Option(1)
> > 
> > smp_mb__before_clear_bit()
> > clear_bit(...)(
> 
> Sorry, you totally lost me.  It could me I'm extremely slow today.  For
> option (1), on ia64, clear_bit has release semantic already.  The comb
> of __before_clear_bit + clear_bit provides the required ordering.  Did
> I miss something?  By the way, we are talking about detail implementation
> on one specific architecture.  Not some generic concept that clear_bit
> has no ordering stuff in there.

By the way, this is the same thing on x86: look at include/asm-i386/bitops.h:

#define smp_mb__before_clear_bit()      barrier()
#define smp_mb__after_clear_bit()       barrier()

A simple compiler barrier, nothing but
#define barrier() __asm__ __volatile__("": : :"memory")

See, no memory ordering there, because clear_bit already has a LOCK prefix.

- Ken
