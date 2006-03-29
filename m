Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbWC2Bj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWC2Bj2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 20:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbWC2Bj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 20:39:27 -0500
Received: from mga01.intel.com ([192.55.52.88]:59409 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750757AbWC2BjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 20:39:25 -0500
X-IronPort-AV: i="4.03,140,1141632000"; 
   d="scan'208"; a="16854501:sNHT180611480"
Message-Id: <200603290139.k2T1d1g00702@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Christoph Lameter'" <clameter@sgi.com>
Cc: "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       "Zoltan Menyhart" <Zoltan.Menyhart@free.fr>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
Subject: RE: Fix unlock_buffer() to work the same way as bit_unlock()
Date: Tue, 28 Mar 2006 17:39:37 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZSzSrc3nQY/YFiTA+dUV/6DHVX4QAAtjOw
In-Reply-To: <Pine.LNX.4.64.0603281644270.16702@schroedinger.engr.sgi.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote on Tuesday, March 28, 2006 4:47 PM
> > Why not make unlock_buffer use test_and_clear_bit()?  Utilizing it's implied
> > full memory fence and throw away the return value?  OK, OK, this is obscured.
> > Then introduce clear_bit_memory_fence API or some sort.
> 
> Only for IA64's sake? Better clean up the bitops as you suggested earlier. 
> The open ended acquires there leaves a weird feeling.
> 
> Something like this? (builds fine not tested yet)

It's warm and fuzzy feeling with changes in set_bit(), clear_bit(), and
change_bit().  The API never meant to have implied memory fence in them.
Though the usage might be assuming one way or the other because of x86
semantics.

How many of these things are used as (1) simple atomic op, (2) lock,
(3) unlock, and (4) full fence?

clear_bit  - 1,070 hits
Set_bit    - 1,450 hits
Change_bit -     8 hits

The effect of changing them to full memory fence could be wide spread. Though
I don't have any numbers yet to say how much it will matter for performance.

- Ken
