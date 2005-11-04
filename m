Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161048AbVKDEm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161048AbVKDEm3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 23:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161052AbVKDEm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 23:42:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:62145 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161039AbVKDEm2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 23:42:28 -0500
Date: Thu, 3 Nov 2005 23:42:17 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, notting@redhat.com
Subject: Re: [PATCH] core remove PageReserved
Message-ID: <20051104044217.GA25858@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Nick Piggin <nickpiggin@yahoo.com.au>, notting@redhat.com
References: <200510300502.j9U52LE0027873@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510300502.j9U52LE0027873@hera.kernel.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2005 at 10:02:22PM -0700, Linux Kernel wrote:
 > tree 835836cb527ec9bd525f93eb7e016f3dfb8c8ae2
 > parent f9c98d0287de42221c624482fd4f8d485c98ab22
 > author Nick Piggin <nickpiggin@yahoo.com.au> Sun, 30 Oct 2005 08:16:12 -0700
 > committer Linus Torvalds <torvalds@g5.osdl.org> Sun, 30 Oct 2005 11:40:39 -0700
 > 
 > [PATCH] core remove PageReserved
 > 
 > Remove PageReserved() calls from core code by tightening VM_RESERVED
 > handling in mm/ to cover PageReserved functionality.
 > 
 > PageReserved special casing is removed from get_page and put_page.
 > 
 > All setting and clearing of PageReserved is retained, and it is now flagged
 > in the page_alloc checks to help ensure we don't introduce any refcount
 > based freeing of Reserved pages.
 > 
 > MAP_PRIVATE, PROT_WRITE of VM_RESERVED regions is tentatively being
 > deprecated.  We never completely handled it correctly anyway, and is be
 > reintroduced in future if required (Hugh has a proof of concept).

We've got one user reporting that he's getting the following
message..

"program ddcprobe is using MAP_PRIVATE, PROT_WRITE mmap of VM_RESERVED memory"
since this cset.

So what should happen here, does that app need changing? Or do we just
need to get Hugh's changes merged?

It's likely that anything else that uses lrmi is going to be affected
in the same way, though off the top of my head, I don't know what (if any)
other apps there may be.

		Dave

