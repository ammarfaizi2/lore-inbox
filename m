Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751194AbWCaDJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbWCaDJn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 22:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWCaDJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 22:09:42 -0500
Received: from mga01.intel.com ([192.55.52.88]:18331 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751194AbWCaDJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 22:09:41 -0500
X-IronPort-AV: i="4.03,148,1141632000"; 
   d="scan'208"; a="18021274:sNHT16704569"
Message-Id: <200603310309.k2V39dg28480@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Christoph Lameter'" <clameter@sgi.com>
Cc: "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Zoltan Menyhart" <Zoltan.Menyhart@bull.net>,
       "Boehm, Hans" <hans.boehm@hp.com>,
       "Grundler, Grant G" <grant.grundler@hp.com>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
Subject: RE: Synchronizing Bit operations V2
Date: Thu, 30 Mar 2006 19:10:24 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZUb3zYhAoOQy5mQEa/0BOcVokrBAAAGypw
In-Reply-To: <Pine.LNX.4.64.0603301855500.3045@schroedinger.engr.sgi.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote on Thursday, March 30, 2006 7:02 PM
> We are talking about IA64 and IA64 only generates an single instruction 
> with either release or acquire semantics for the case in which either 
> smb_mb__before/after_clear_bit does nothing.
> 
> Neither acquire nor release is a memory barrier on IA64.


The use of
        smp_mb__before_clear_bit();
        clear_bit( ... );

is: all memory operations before this call will be visible before
the clear_bit().  To me, that's release semantics.

On ia64, we map the following:
#define Smp_mb__before_clear_bit      do { } while (0)
#define clear_bit                     clear_bit_mode(..., RELEASE)

Which looked perfect fine to me.  I don't understand why you say it does
not provide memory ordering.

- Ken
