Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbWCaVX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbWCaVX7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 16:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWCaVX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 16:23:59 -0500
Received: from mga01.intel.com ([192.55.52.88]:17522 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750812AbWCaVX6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 16:23:58 -0500
X-IronPort-AV: i="4.03,152,1141632000"; 
   d="scan'208"; a="18361305:sNHT59092159"
Message-Id: <200603312123.k2VLNqg06655@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Christoph Lameter'" <clameter@sgi.com>
Cc: "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       "Zoltan Menyhart" <Zoltan.Menyhart@bull.net>,
       "Boehm, Hans" <hans.boehm@hp.com>,
       "Grundler, Grant G" <grant.grundler@hp.com>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
Subject: RE: Synchronizing Bit operations V2
Date: Fri, 31 Mar 2006 13:24:35 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZVCHYiuUih/NlTScmj5554qeT1VwAAJQLA
In-Reply-To: <Pine.LNX.4.64.0603311313530.8003@schroedinger.engr.sgi.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote on Friday, March 31, 2006 1:15 PM
> > > They are not. They provide equivalent barrier when performed
> > > before/after a clear_bit, there is a big difference.
> > 
> > Just to give another blunt brutal example, what is said here is equivalent
> > to say kernel requires:
> > 
> >    <end of critical section>
> >    smp_mb_before_spin_unlock
> >    spin_unlock
> > 
> > Because it is undesirable to have spin_unlock to leak into the critical
> > Section and allow critical section to leak after spin_unlock.  This is
> > just plain brain dead.
> 
> I think we could say that lock semantics are different from barriers. They 
> are more like acquire and release on IA64. The problem with smb_mb_*** is 
> that the coder *explicitly* requested a barrier operation and we do not 
> give it to him.

I was browsing sparc64 code and it defines:

include/asm-sparc64/bitops.h:
#define smp_mb__after_clear_bit()      membar_storeload_storestore()

With my very naïve knowledge of sparc64, it doesn't look like a full barrier.
Maybe sparc64 is broken too ...
