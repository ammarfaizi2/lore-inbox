Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751564AbWJJAxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbWJJAxK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 20:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751933AbWJJAxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 20:53:10 -0400
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:43422 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751564AbWJJAxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 20:53:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=YwIPic00j7mjaYw7QYzEKN8UzpZz4resWOqtZJWa0OJn6qL6WZkVltFyGrxHIASkdZqphu5XX4N1bvkx8Po618pO8JVtzPov90BQQ40ty7U/SF9qaMXEmDBlHsqKtzYFRpRCETpuAiAMHA0Ctor02y6MAvHSXGyWY6MdVCwNXkA=  ;
Message-ID: <452AEF02.20203@yahoo.com.au>
Date: Tue, 10 Oct 2006 10:53:22 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Nick Piggin <npiggin@suse.de>, Hugh Dickins <hugh@veritas.com>,
       Linux Memory Management <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>, Jes Sorensen <jes@sgi.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [rfc] 2.6.19-rc1-git5: consolidation of file backed fault	handlers
References: <20061009140354.13840.71273.sendpatchset@linux.site>	 <1160427472.7752.15.camel@localhost.localdomain> <1160427638.7752.17.camel@localhost.localdomain>
In-Reply-To: <1160427638.7752.17.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> On Tue, 2006-10-10 at 06:57 +1000, Benjamin Herrenschmidt wrote:
> 
>>On Mon, 2006-10-09 at 18:12 +0200, Nick Piggin wrote:
>>
>>>OK, I've cleaned up and further improved this patchset, removed duplication
>>>while retaining legacy nopage handling, restored page_mkwrite to the ->fault
>>>path (due to lack of users upstream to attempt a conversion), converted the
>>>rest of the filesystems to use ->fault, restored MAP_POPULATE and population
>>>of remap_file_pages pages, replaced nopfn completely, and removed
>>>NOPAGE_REFAULT because that can be done easily with ->fault.
>>
>>What is the replacement ?
> 
> 
> I see ... so we now use PTR_ERR to return errors and NULL for refault...
> good for me but Andrew may want more...

The fault handler puts its desired return type into fault_data.type, and
returns NULL if there is no page to install, otherwise the pointer to
the struct page.

So you'd just set VM_FAULT_MINOR and return NULL, after doing the
vm_insert_pfn thing.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
