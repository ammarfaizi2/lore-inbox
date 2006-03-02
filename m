Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbWCBVaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbWCBVaj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 16:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbWCBVai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 16:30:38 -0500
Received: from fmr23.intel.com ([143.183.121.15]:60581 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S932304AbWCBVah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 16:30:37 -0500
Message-Id: <200603022129.k22LTog14318@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Hugh Dickins'" <hugh@veritas.com>
Cc: "'David Gibson'" <david@gibson.dropbear.id.au>,
       "Andrew Morton" <akpm@osdl.org>, "William Irwin" <wli@holomorphy.com>,
       <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: hugepage: Fix hugepage logic in free_pgtables()
Date: Thu, 2 Mar 2006 13:29:50 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcY+N+3utHUkdqfTTF+P1eLzZilw/gABg47w
In-Reply-To: <Pine.LNX.4.61.0603022002500.23669@goblin.wat.veritas.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote on Thursday, March 02, 2006 12:27 PM
> But the first part, || instead of && in is_hugepage_only_range, looks
> insufficient: the start and end of the range might each fall in a
> non-huge region, but the range still cross a huge region.
> 
> Ah, does RGN_HPAGE nestle up against the TASK_SIZE roof, so any range
> already tested against TASK_SIZE (as get_unmapped_area has) cannot
> cross RGN_HPAGE?  If so, perhaps it deserves a comment there.  And
> if that is so, and can be relied upon, is_hugepage_only_range need
> only be testing REGION_NUMBER(addr+len-1) - but it does seem fragile.

There are many address range check before we hit get_unmapped area.
ia64 can never have a vma range that crosses region boundary.  David
pointed out earlier that shmat and mremap can still slip through the
crack and he has a patch that fixed it. But yes, this patch is making
that assumption (or relying on checks being done properly beforehand).

- Ken

