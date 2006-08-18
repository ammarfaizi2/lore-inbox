Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751369AbWHRLDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbWHRLDM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 07:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWHRLDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 07:03:12 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:32160 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751369AbWHRLDK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 07:03:10 -0400
Message-ID: <44E59EFE.3080906@sw.ru>
Date: Fri, 18 Aug 2006 15:05:34 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: rohitseth@google.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
Subject: Re: [RFC][PATCH 4/7] UBC: syscalls (user interface)
References: <44E33893.6020700@sw.ru>	<44E33C3F.3010509@sw.ru>	<1155752277.22595.70.camel@galaxy.corp.google.com>	<1155755069.24077.392.camel@localhost.localdomain>	<1155756170.22595.109.camel@galaxy.corp.google.com>	<44E45D6A.8000003@sw.ru> <20060817084033.f199d4c7.akpm@osdl.org>
In-Reply-To: <20060817084033.f199d4c7.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Thu, 17 Aug 2006 16:13:30 +0400
> Kirill Korotaev <dev@sw.ru> wrote:
> 
> 
>>>I was more thinking about (for example) user land physical memory limit
>>>for that bean counter.  If the limits are going down, then the system
>>>call should try to flush out page cache pages or swap out anonymous
>>>memory.  But you are right that it won't be possible in all cases, like
>>>for in kernel memory limits.
>>
>>Such kind of memory management is less efficient than the one 
>>making decisions based on global shortages and global LRU alogrithm.
> 
> 
> I also was quite surprised that openvz appears to have no way of
> constraining a container's memory usage.  "I want to run this bunch of
> processes in a 4.5GB container".
If you mean user memory, then it is possible to set
container limits to 4,5GB. This is what most people care about
and it is not a problem.

Or you mean that you are suprised there are lots of parameters
and there is no a single one limiting the _whole_ memory set of container
memory (sum of kernel memory, user space memory and other resources memory)?

>>The problem here is that doing swap out takes more expensive disk I/O
>>influencing other users.
> 
> 
> A well-set-up container would presumably be working against its own
> spindle(s).  If the operator has gone to all the trouble of isolating a job
> from the system's other jobs, he'd be pretty dumb to go and let all the
> "isolated" jobs share a stinky-slow resource like a disk.
why do you assume that it is always an operator who controls the applications
inside the container?
users can run any application inside and it is systems job to
introduce resource isolation between users, not the operators full-time
job doing monitoring of users.

> But yes, swap is a problem.  To do this properly we'd need a way of saying
> "this container here uses that swap device over there".
yep, this is possible with page beancounters as it tracks user pages.
more over, we have an intention of building a system with a single container
memory parameter, but we think this is more user interface question and
still requires all the UBC resources accounting.

Thanks,
Kirill
