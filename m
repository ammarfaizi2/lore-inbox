Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751237AbWHQMLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbWHQMLL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 08:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbWHQMLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 08:11:11 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:49210 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751168AbWHQMLK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 08:11:10 -0400
Message-ID: <44E45D6A.8000003@sw.ru>
Date: Thu, 17 Aug 2006 16:13:30 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: rohitseth@google.com
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
Subject: Re: [RFC][PATCH 4/7] UBC: syscalls (user interface)
References: <44E33893.6020700@sw.ru>  <44E33C3F.3010509@sw.ru>	 <1155752277.22595.70.camel@galaxy.corp.google.com>	 <1155755069.24077.392.camel@localhost.localdomain> <1155756170.22595.109.camel@galaxy.corp.google.com>
In-Reply-To: <1155756170.22595.109.camel@galaxy.corp.google.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rohit Seth wrote:
> On Wed, 2006-08-16 at 20:04 +0100, Alan Cox wrote:
> 
>>Ar Mer, 2006-08-16 am 11:17 -0700, ysgrifennodd Rohit Seth:
>>
>>>I think there should be a check here for seeing if the new limits are
>>>lower than the current usage of a resource.  If so then take appropriate
>>>action.
>>
>>Generally speaking there isn't a sane appropriate action because the
>>resources can't just be yanked.
>>
> 
> 
> I was more thinking about (for example) user land physical memory limit
> for that bean counter.  If the limits are going down, then the system
> call should try to flush out page cache pages or swap out anonymous
> memory.  But you are right that it won't be possible in all cases, like
> for in kernel memory limits.
Such kind of memory management is less efficient than the one 
making decisions based on global shortages and global LRU alogrithm.

The problem here is that doing swap out takes more expensive disk I/O
influencing other users.

So throttling algorithms if wanted should be optional, not mandatory.
Lets postpone it and concentrate on the core.

Thanks,
Kirill
