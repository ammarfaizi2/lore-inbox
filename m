Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751061AbWHUKhz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbWHUKhz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 06:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751848AbWHUKhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 06:37:55 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:37735 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751061AbWHUKhz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 06:37:55 -0400
Message-ID: <44E98D9F.1090101@sw.ru>
Date: Mon, 21 Aug 2006 14:40:31 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Rik van Riel <riel@redhat.com>, ckrm-tech@lists.sourceforge.net,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, rohitseth@google.com,
       hugh@veritas.com, Ingo Molnar <mingo@elte.hu>, devel@openvz.org,
       Pavel Emelianov <xemul@openvz.org>
Subject: Re: [ckrm-tech] [RFC][PATCH 5/7] UBC: kernel memory accounting	(core)
References: <44E33893.6020700@sw.ru> <44E33C8A.6030705@sw.ru>	 <1155752693.22595.76.camel@galaxy.corp.google.com> <44E46ED3.7000201@sw.ru>	 <1155825493.9274.42.camel@localhost.localdomain> <44E588F0.40502@sw.ru> <1155913113.9274.91.camel@localhost.localdomain>
In-Reply-To: <1155913113.9274.91.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> On Fri, 2006-08-18 at 13:31 +0400, Kirill Korotaev wrote:
> 
>>they all are troublesome :/
>>user can create lots of vmas, w/o page tables.
>>lots of fdsets, ipcids.
>>These are not reclaimable. 
> 
> 
> I guess one of my big questions surrounding these patches is why the
> accounting is done with pages.
probably you missed patch details a bit.
accounting is done:
1. in pages for objects allocated by buddy allocator
2. in slabs for objects allocated from caches

> If there really is a need to limit these
> different kernel objects, then why not simply write patches to limit
> *these* *objects*?  I trust there is a very good technical reason for
> doing this, I just don't understand why, yet.
The one reason is that such an accounting allows to estimate the memory
used/required by containers, while limitations by objects:
- per object accounting/limitations do not provide any memory estimation
- having a big number of reasonably high limits still allows the user
  to consume big amount of memory. I.e. the sum of all the limits tend
  to be high and potentially DoS exploitable :/
- memory is easier to setup/control from user POV.
  having hundreds of controls is good, but not much user friendly.

Thanks,
Kirill
