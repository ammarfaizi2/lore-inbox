Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbUEECQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbUEECQv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 22:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbUEECQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 22:16:51 -0400
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139]:41608 "HELO
	smtp101.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261468AbUEECQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 22:16:48 -0400
Message-ID: <40984E89.6070501@yahoo.com.au>
Date: Wed, 05 May 2004 12:16:41 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Shantanu Goel <sgoel01@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: [VM PATCH 2.6.6-rc3-bk5] Dirty balancing in the presence of mapped
 pages
References: <20040505002029.11785.qmail@web12821.mail.yahoo.com> <20040504180345.099926ec.akpm@osdl.org>
In-Reply-To: <20040504180345.099926ec.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Shantanu Goel <sgoel01@yahoo.com> wrote:
> 
>>Presently the kernel does not collection information
>>about the percentage of memory that processes have
>>dirtied via mmap until reclamation.  Nothing analogous
>>to balance_dirty_pages() is being done for mmap'ed
>>pages.  The attached patch adds collection of dirty
>>page information during kswapd() scans and initiation
>>of background writeback by waking up bdflush.
> 
> 
> And what were the effects of this patch?
> 

I havea modified patch from Nikita that does the
if (ptep_test_and_clear_dirty) set_page_dirty from
page_referenced, under the page_table_lock.

So it also picks up pages coming off the active list.

It doesn't do the wakeup_bdflush thing, but that sounds
like a good idea. What does wakeup_bdflush(-1) mean?

