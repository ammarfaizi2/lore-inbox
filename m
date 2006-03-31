Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbWCaDCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbWCaDCa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 22:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWCaDC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 22:02:29 -0500
Received: from mga02.intel.com ([134.134.136.20]:54838 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751206AbWCaDC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 22:02:28 -0500
X-IronPort-AV: i="4.03,148,1141632000"; 
   d="scan'208"; a="17472914:sNHT2043947017"
Message-Id: <200603310301.k2V31Gg28423@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Christoph Lameter'" <clameter@sgi.com>
Cc: "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       "'Zoltan Menyhart'" <Zoltan.Menyhart@bull.net>,
       "'Boehm, Hans'" <hans.boehm@hp.com>,
       "'Grundler, Grant G'" <grant.grundler@hp.com>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
Subject: RE: Synchronizing Bit operations V2
Date: Thu, 30 Mar 2006 19:02:00 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZUbqAaKeUgVl7pRXOCEQPv1TKIWgAACwaQ
In-Reply-To: <Pine.LNX.4.64.0603301855280.3045@schroedinger.engr.sgi.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote on Thursday, March 30, 2006 6:56 PM
> > By the way, this is the same thing on x86: look at include/asm-i386/bitops.h:
> > 
> > #define smp_mb__before_clear_bit()      barrier()
> > #define smp_mb__after_clear_bit()       barrier()
> > 
> > A simple compiler barrier, nothing but
> > #define barrier() __asm__ __volatile__("": : :"memory")
> > 
> > See, no memory ordering there, because clear_bit already has a LOCK prefix.
> 
> And that implies barrier behavior right?

No, not the memory ordering semantics you are thinking about.  It just tell
compiler not to be over smart and schedule a load operation above that point
Intel compiler is good at schedule memory load way ahead of its use to hide
memory latency. gcc probably does that too, I'm not 100% sure. This prevents
the compiler to schedule load before that line.

- Ken
