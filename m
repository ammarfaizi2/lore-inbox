Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbWCaS4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbWCaS4a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 13:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWCaS4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 13:56:30 -0500
Received: from mga02.intel.com ([134.134.136.20]:26655 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751302AbWCaS43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 13:56:29 -0500
X-IronPort-AV: i="4.03,151,1141632000"; 
   d="scan'208"; a="17756981:sNHT34124104"
Message-Id: <200603311856.k2VIuPg04814@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Nick Piggin'" <nickpiggin@yahoo.com.au>
Cc: "'Christoph Lameter'" <clameter@sgi.com>,
       "Zoltan Menyhart" <Zoltan.Menyhart@bull.net>,
       "Boehm, Hans" <hans.boehm@hp.com>,
       "Grundler, Grant G" <grant.grundler@hp.com>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
Subject: RE: Synchronizing Bit operations V2
Date: Fri, 31 Mar 2006 10:57:08 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZU3wk3Pbf7RWEuSPm+E11xdkEdcgAEwehw
In-Reply-To: <442CDB98.80803@yahoo.com.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote on Thursday, March 30, 2006 11:35 PM
> > >The memory ordering that above combination should produce is a
> > >Linux style smp_mb before the clear_bit. Not a release.
> > 
> > Whoever designed the smp_mb_before/after_* clearly understand the
> > difference between a bidirectional smp_mb() and a one-way memory
> > ordering.  If smp_mb_before/after are equivalent to smp_mb, what's
> > the point of introducing another interface?
> > 
> They are not. They provide equivalent barrier when performed
> before/after a clear_bit, there is a big difference.

The usage so far that I can see for

  smp_mb__before_clear_bit()
  clear_bit

is to close a critical section with clear_bit.  I will be hard impressed
to see a usage that allows stuff follows clear_bit to pass clear_bit, but
not to pass the smp_mb_before_xxx.

<end of critical section>
  smp_mb_before_clear_bit
  clear_bit
<begin other code>

But if you stand on the ground of smp_mb_before_xxx protects clear_bit
from occurring before the "end of critical section", then smp_mb_before
is such a brain dead interface and it is another good reason for having
an explicit ordering mode built into the clear_bit. 
