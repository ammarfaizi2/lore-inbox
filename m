Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbWC1Tke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbWC1Tke (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 14:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbWC1Tke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 14:40:34 -0500
Received: from mga01.intel.com ([192.55.52.88]:45066 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751295AbWC1Tkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 14:40:33 -0500
X-IronPort-AV: i="4.03,139,1141632000"; 
   d="scan'208"; a="16692216:sNHT1808589594"
Message-Id: <200603281853.k2SIrGg28290@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       "Christoph Lameter" <clameter@sgi.com>
Cc: <akpm@osdl.org>, <Zoltan.Menyhart@free.fr>, <linux-kernel@vger.kernel.org>,
       <linux-ia64@vger.kernel.org>
Subject: RE: Fix unlock_buffer() to work the same way as bit_unlock()
Date: Tue, 28 Mar 2006 10:53:52 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZSVByRHaXEXQrYQMq3l3W82HEwOwAQ++Hw
In-Reply-To: <4428EF8B.7040202@yahoo.com.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote on Tuesday, March 28, 2006 12:11 AM
> Also, I think there is still the issue of ia64 not having the
> correct memory consistency semantics. To start with, all the bitops
> and atomic ops which both modify their operand and return a value
> should be full memory barriers before and after the operation,
> according to Documentation/atomic_ops.txt.


I suppose the usage of atomic ops is abused, it is used in both lock
and unlock path.  And it naturally suck because it now requires full
memory barrier.  A better way is to define 3 variants: one for lock
path, one for unlock path, and one with full memory fence.

- Ken
