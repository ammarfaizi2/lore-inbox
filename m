Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261984AbVCARTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbVCARTQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 12:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbVCARTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 12:19:16 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:45950 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261984AbVCARTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 12:19:13 -0500
Date: Tue, 1 Mar 2005 17:17:36 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Prakash Bhurke <prakash_bhurke@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: memory mapping of vmalloc
In-Reply-To: <20050301130803.34688.qmail@web54610.mail.yahoo.com>
Message-ID: <Pine.LNX.4.61.0503011713470.31799@goblin.wat.veritas.com>
References: <20050301130803.34688.qmail@web54610.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Mar 2005, Prakash Bhurke wrote:
>   I am trying to map a vmalloc kernel buffer to user
> space using remap_page_range(). In my module, this
> function returns success if we call mmap() from user
> space, but i can not access content of vmalloc buffer
> from user space. Pointer returned by mmap() syscall
> seems pointing to other memory page which contains
> zeros. I am using linux 2.6.10 kernel on Pentium 4
> system.

Look for "rvmalloc" in various drivers in the kernel source tree:
you must SetPageReserved before remap_pfn_range (or remap_page_range)
agrees to map the page, and ClearPageReserved before freeing after.

Hugh
