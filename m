Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751361AbWHRKwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbWHRKwI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 06:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbWHRKwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 06:52:08 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:39853 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751361AbWHRKwG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 06:52:06 -0400
Message-ID: <44E59C65.7000807@sw.ru>
Date: Fri, 18 Aug 2006 14:54:29 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       rohitseth@google.com, Rik van Riel <riel@redhat.com>,
       ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, hugh@veritas.com, Ingo Molnar <mingo@elte.hu>,
       Pavel Emelianov <xemul@openvz.org>
Subject: Re: [ckrm-tech] [RFC][PATCH 5/7] UBC: kernel memory accounting (core)
References: <44E33893.6020700@sw.ru> <1155824788.9274.32.camel@localhost.localdomain> <1155826917.15195.101.camel@localhost.localdomain> <200608171804.41433.ak@suse.de>
In-Reply-To: <200608171804.41433.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>>I don't see any good way around that. For the page struct it is a
>>material issue, for the others its not a big deal providing we avoid
>>accounting dumb stuff like dentries.
>>
>>At the VM summit Linus suggested one option for user page allocation
>>tracking would be to track not per page but by block of pages (say the
>>2MB chunks) and hand those out per container. That would really need the
>>defrag work though.
> 
> 
> One could always use a second set of arrays, mirroring mem_map
which one do you prefer:
- having a pointer on the struct page?
  kernels without resource accounting won't have this.

- having a mirroring mem_map?
  on i686 it is easy, but not sure about sparse mem
  or numa configurations.
  advantage: run-time configurable on boot time.
  disadvantage: much lower performance with accounting.

- address_space/anon_vma can be replaced with some kind of proxy object
  with 2 pointers - address_space and ub. however I don't see how it is
  better then a single ptr on page.

Thanks,
Kirill

