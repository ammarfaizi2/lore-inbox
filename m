Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbVFCTqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbVFCTqm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 15:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbVFCTql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 15:46:41 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:53715 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S261521AbVFCTqh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 15:46:37 -0400
From: Ulrich Weigand <uweigand@de.ibm.com>
Message-Id: <200506031946.j53Jk95q002557@53v30g15.boeblingen.de.ibm.com>
Subject: Re: [patch] broken fault_in_pages_readable call in
To: akpm@osdl.org
Date: Fri, 3 Jun 2005 21:46:09 +0200 (CEST)
Cc: schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Can you explain the bug a bit more completely?  AFACIT, `bytes' here was
>always in the range 0 ..  PAGE_CACHE_SIZE, so how can it have caused large
>amounts of the stack segment to have been faulted in?

'buf' is not page-aligned, so 'buf' + 'bytes' can touch the next page,
which may not be mapped.  In fact, if 'buf' points to the *last* valid
mapped page (before the stack), and the stack ulimit is unlimited, the
VM_GROWSDOWN logic considers this access a request to grow the stack
down to this very page ...

Bye,
Ulrich

-- 
  Dr. Ulrich Weigand
  Linux on zSeries Development
  Ulrich.Weigand@de.ibm.com
