Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262376AbVCVEUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262376AbVCVEUZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 23:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbVCVERl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 23:17:41 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:43648 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262351AbVCVEO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 23:14:59 -0500
Subject: Re: [PATCH 1/5] freepgt: free_pgtables use vma list
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: "David S. Miller" <davem@davemloft.net>
Cc: "Luck, Tony" <tony.luck@intel.com>, hugh@veritas.com,
       Andrew Morton <akpm@osdl.org>, benh@kernel.crashing.org,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050321150205.4af39064.davem@davemloft.net>
References: <B8E391BBE9FE384DAA4C5C003888BE6F03210DD4@scsmsx401.amr.corp.intel.com>
	 <20050321150205.4af39064.davem@davemloft.net>
Content-Type: text/plain
Date: Tue, 22 Mar 2005 15:14:54 +1100
Message-Id: <1111464894.5125.34.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-21 at 15:02 -0800, David S. Miller wrote:

> Anyways, there's the full analysis, what do you make
> of this Hugh? :-)

Impressive, and my name isn't even Hugh.

Question, Dave: flush_tlb_pgtables after Hugh's patch is also
possibly not being called with enough range to cover all page
tables that have been freed.

For example, you may have a single page (start,end) address range
to free, but if this is enclosed by a large enough (floor,ceiling)
then it may free an entire pgd entry.

I assume the intention of the API would be to provide the full
pgd width in that case?



