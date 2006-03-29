Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbWC2Gt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbWC2Gt7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 01:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWC2Gt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 01:49:59 -0500
Received: from mga02.intel.com ([134.134.136.20]:183 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751096AbWC2Gt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 01:49:57 -0500
X-IronPort-AV: i="4.03,141,1141632000"; 
   d="scan'208"; a="16453699:sNHT15174320"
Message-Id: <200603290649.k2T6ntg03758@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       "Christoph Lameter" <clameter@sgi.com>
Cc: <akpm@osdl.org>, <Zoltan.Menyhart@free.fr>, <linux-kernel@vger.kernel.org>,
       <linux-ia64@vger.kernel.org>
Subject: RE: Fix unlock_buffer() to work the same way as bit_unlock()
Date: Tue, 28 Mar 2006 22:50:41 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZSVByRHaXEXQrYQMq3l3W82HEwOwAqHNCA
In-Reply-To: <4428EF8B.7040202@yahoo.com.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote on Tuesday, March 28, 2006 12:11 AM
> OK, that's fair enough and I guess you do need a barrier there.
> However, should the mb__after barrier still remain? The comment
> in wake_up_bit suggests yes, and there is similar code in
> unlock_page.

Question on unlock_page:

void fastcall unlock_page(struct page *page)
{
        smp_mb__before_clear_bit();
        if (!TestClearPageLocked(page))
                BUG();
        smp_mb__after_clear_bit();
        wake_up_page(page, PG_locked);
}

Assuming test_and_clear_bit() on all arch does what the API is
called for with full memory fence around the atomic op, why do
you need smp_mb__before_clear_bit and smp_mb__after_clear_bit?
Aren't they redundant?

- Ken
