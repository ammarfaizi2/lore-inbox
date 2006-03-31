Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbWCaDRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWCaDRI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 22:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWCaDRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 22:17:08 -0500
Received: from mga03.intel.com ([143.182.124.21]:27823 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751212AbWCaDRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 22:17:06 -0500
X-IronPort-AV: i="4.03,148,1141632000"; 
   d="scan'208"; a="17193226:sNHT16114098"
Message-Id: <200603310317.k2V3H5g28544@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Christoph Lameter'" <clameter@sgi.com>
Cc: "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Zoltan Menyhart" <Zoltan.Menyhart@bull.net>,
       "Boehm, Hans" <hans.boehm@hp.com>,
       "Grundler, Grant G" <grant.grundler@hp.com>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
Subject: RE: Synchronizing Bit operations V2
Date: Thu, 30 Mar 2006 19:17:49 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZUcOq3zmzy2yEaTL6XZJMfzv7kWwAAHd/w
In-Reply-To: <Pine.LNX.4.64.0603301909590.3145@schroedinger.engr.sgi.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote on Thursday, March 30, 2006 7:12 PM
> > On ia64, we map the following:
> > #define Smp_mb__before_clear_bit      do { } while (0)
> > #define clear_bit                     clear_bit_mode(..., RELEASE)
> > 
> > Which looked perfect fine to me.  I don't understand why you say it does
> > not provide memory ordering.
> 
> It does not provide a memory barrier / fence. Later memory references can 
> still be moved by the processor above the instruction with release semantics.

That is perfect legitimate, and was precisely the reason for the invention of 
smp_mb__after_clear_bit - prevent later load to leak before clear_bit.
