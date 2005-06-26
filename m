Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbVFZIlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVFZIlm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 04:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbVFZIlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 04:41:42 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:49816 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261163AbVFZIlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 04:41:37 -0400
Message-ID: <42BE6A3E.8030703@yahoo.com.au>
Date: Sun, 26 Jun 2005 18:41:34 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, hugh@veritas.com, pbadari@us.ibm.com,
       linux-scsi@vger.kernel.org
Subject: Re: [patch][rfc] 5/5: core remove PageReserved
References: <42BA5F37.6070405@yahoo.com.au>	<42BA5F5C.3080101@yahoo.com.au>	<42BA5F7B.30904@yahoo.com.au>	<42BA5FA8.7080905@yahoo.com.au>	<42BA5FC8.9020501@yahoo.com.au>	<42BA5FE8.2060207@yahoo.com.au>	<20050623095153.GB3334@holomorphy.com> <20050623215011.0b1e6ef2.akpm@osdl.org>
In-Reply-To: <20050623215011.0b1e6ef2.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> William Lee Irwin III <wli@holomorphy.com> wrote:

>> Mutatis mutandis for my SCSI tape drive.
> 
> 

OK, for the VM_RESERVED case, it looks like it won't be much of a problem
because get_user_pages faults on VM_IO regions (which is already set in
remap_pfn_range which is used by mem.c and most drivers). So this code will
simply not encounter VM_RESERVED regions - well obviously, get_user_pages
should be made to explicitly check for VM_RESERVED too, but the point being
that introducing such a check will not overly restrict drivers.

[snip SetPageDirty is wrong]

Not that this helps the existing bug...

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
