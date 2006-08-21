Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbWHUJle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbWHUJle (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 05:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751801AbWHUJle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 05:41:34 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:26010 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751751AbWHUJle (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 05:41:34 -0400
Message-ID: <44E98069.3030908@sw.ru>
Date: Mon, 21 Aug 2006 13:44:09 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Dave Hansen <haveblue@us.ibm.com>, rohitseth@google.com,
       Rik van Riel <riel@redhat.com>, ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, hugh@veritas.com, Ingo Molnar <mingo@elte.hu>,
       Pavel Emelianov <xemul@openvz.org>, Andi Kleen <ak@suse.de>,
       Andy Whitcroft <apw@shadowen.org>
Subject: Re: [ckrm-tech] [RFC][PATCH 5/7] UBC: kernel memory accounting	(core)
References: <44E33893.6020700@sw.ru>  <44E33C8A.6030705@sw.ru>	 <1155754029.9274.21.camel@localhost.localdomain>	 <1155755729.22595.101.camel@galaxy.corp.google.com>	 <1155758369.9274.26.camel@localhost.localdomain>	 <1155774274.15195.3.camel@localhost.localdomain>	 <1155824788.9274.32.camel@localhost.localdomain>	 <1155835003.14617.45.camel@galaxy.corp.google.com> <44E57FB4.8090905@sw.ru>	 <1155913165.28764.6.camel@localhost.localdomain>	 <1155929523.12204.32.camel@localhost.localdomain> <1155934370.31543.4.camel@localhost.localdomain>
In-Reply-To: <1155934370.31543.4.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Gwe, 2006-08-18 am 12:32 -0700, ysgrifennodd Dave Hansen:
> 
>>>It ought to be cheap. Given each set of page structs is an array its a
>>>simple subtract and divide (or with care and people try to pack them
>>>nicely for cache lines - shift) to get to the parallel accounting array.
>>
>>I wish page structs were just a simple array. ;)
> 
> 
> Note I very carefully said "each set of"
> 
> 
>>It will just be a bit more code, but we'll need this for the two other
>>memory models: sparsemem and discontigmem.  For discontig, we'll just
>>need pointers in the pg_data_ts and, for sparsemem, we'll likely need
>>another pointer in the 'struct mem_section'.
> 
> 
> Actually I don't believe this is true in either case. Change the code
> which allocates the page arrays to allocate (+ sizeof(void *) *
> pages_in_array on the end of each array when using UBC. The rest then
> seems to come out naturally.
I only doubt what gain we will have in this situation.
boot-time selectable vs. CONFIG-selectable?

Kirill

