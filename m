Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751237AbWCaDW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbWCaDW1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 22:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWCaDW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 22:22:27 -0500
Received: from mga01.intel.com ([192.55.52.88]:16011 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751210AbWCaDW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 22:22:26 -0500
X-IronPort-AV: i="4.03,148,1141632000"; 
   d="scan'208"; a="18025058:sNHT16357845"
Message-Id: <200603310322.k2V3MPg28583@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Christoph Lameter'" <clameter@sgi.com>
Cc: "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Zoltan Menyhart" <Zoltan.Menyhart@bull.net>,
       "Boehm, Hans" <hans.boehm@hp.com>,
       "Grundler, Grant G" <grant.grundler@hp.com>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
Subject: RE: Synchronizing Bit operations V2
Date: Thu, 30 Mar 2006 19:23:10 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZUcOq3zmzy2yEaTL6XZJMfzv7kWwAAPvNA
In-Reply-To: <Pine.LNX.4.64.0603301909590.3145@schroedinger.engr.sgi.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote on Thursday, March 30, 2006 7:12 PM
> > > We are talking about IA64 and IA64 only generates an single instruction 
> > > with either release or acquire semantics for the case in which either 
> > > smb_mb__before/after_clear_bit does nothing.
> > > 
> > > Neither acquire nor release is a memory barrier on IA64.
> > 
> > 
> > The use of
> >         smp_mb__before_clear_bit();
> >         clear_bit( ... );
> > 
> > is: all memory operations before this call will be visible before
> > the clear_bit().  To me, that's release semantics.
> 
> What of it? Release semantics are not a full fence or memory barrier.
> 
> > On ia64, we map the following:
> > #define Smp_mb__before_clear_bit      do { } while (0)
> > #define clear_bit                     clear_bit_mode(..., RELEASE)
> > 
> > Which looked perfect fine to me.  I don't understand why you say it does
> > not provide memory ordering.
> 
> It does not provide a memory barrier / fence. Later memory references can 
> still be moved by the processor above the instruction with release semantics.


This is probably a classic example of a sucky name leads to confusion.
There are smp_mb_ in the name, however, the semantics is really defined
as a one-way memory barrier and probably is the main reason of contention
in this discussion :-(

Another good reason to get rid of this silly smp_mb_before/after_clear_bit.

- Ken



wrong confusing implementation
