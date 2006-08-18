Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751322AbWHRJ3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbWHRJ3F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 05:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWHRJ3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 05:29:05 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:3250 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751322AbWHRJ3E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 05:29:04 -0400
Message-ID: <44E588F0.40502@sw.ru>
Date: Fri, 18 Aug 2006 13:31:28 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: rohitseth@google.com, Rik van Riel <riel@redhat.com>,
       ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Emelianov <xemul@openvz.org>
Subject: Re: [ckrm-tech] [RFC][PATCH 5/7] UBC: kernel memory accounting	(core)
References: <44E33893.6020700@sw.ru> <44E33C8A.6030705@sw.ru>	 <1155752693.22595.76.camel@galaxy.corp.google.com> <44E46ED3.7000201@sw.ru> <1155825493.9274.42.camel@localhost.localdomain>
In-Reply-To: <1155825493.9274.42.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> On Thu, 2006-08-17 at 17:27 +0400, Kirill Korotaev wrote:
> 
>>charged kernel objects can't be _reclaimed_. how do you propose
>>to reclaim tasks page tables or files or task struct or vma or etc.?
> 
> 
> Do you have any statistics on which of these objects are the most
> troublesome?  If it _is_ pagetables, for instance, it is quite
> conceivable that we could reclaim them.
they all are troublesome :/
user can create lots of vmas, w/o page tables.
lots of fdsets, ipcids.
These are not reclaimable.

Also consider the following scenario with reclaimable page tables.
e.g. user hit kmemsize limit due to fat page tables.
kernel reclaims some of the page tables and frees user kenerl memory.
after that user creates some uncreclaimable objects like fdsets or ipcs
and then accesses memory with reclaimed page tables.
Sooner or later we kill user with SIGSEGV from page fault due to
no memory. This is worse then returning ENOMEM from poll() or
mmap() where user allocates kernel objects.

> This one probably deserves a big, fat comment, though. ;)
tell me where to write it and what? :)

Thanks,
Kirill


