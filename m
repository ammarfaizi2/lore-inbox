Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbWCaTkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbWCaTkb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 14:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbWCaTkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 14:40:31 -0500
Received: from mga03.intel.com ([143.182.124.21]:30858 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932130AbWCaTk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 14:40:29 -0500
X-IronPort-AV: i="4.03,151,1141632000"; 
   d="scan'208"; a="17505015:sNHT16088898"
Message-Id: <200603311940.k2VJeRg05420@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Nick Piggin'" <nickpiggin@yahoo.com.au>
Cc: "'Christoph Lameter'" <clameter@sgi.com>,
       "Zoltan Menyhart" <Zoltan.Menyhart@bull.net>,
       "Boehm, Hans" <hans.boehm@hp.com>,
       "Grundler, Grant G" <grant.grundler@hp.com>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
Subject: RE: Synchronizing Bit operations V2
Date: Fri, 31 Mar 2006 11:41:11 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZU3wk3Pbf7RWEuSPm+E11xdkEdcgAGwalQ
In-Reply-To: <442CDB98.80803@yahoo.com.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote on Thursday, March 30, 2006 11:35 PM
> > Whoever designed the smp_mb_before/after_* clearly understand the
> > difference between a bidirectional smp_mb() and a one-way memory
> > ordering.  If smp_mb_before/after are equivalent to smp_mb, what's
> > the point of introducing another interface?
> > 
> 
> They are not. They provide equivalent barrier when performed
> before/after a clear_bit, there is a big difference.

Just to give another blunt brutal example, what is said here is equivalent
to say kernel requires:

   <end of critical section>
   smp_mb_before_spin_unlock
   spin_unlock

Because it is undesirable to have spin_unlock to leak into the critical
Section and allow critical section to leak after spin_unlock.  This is
just plain brain dead.
