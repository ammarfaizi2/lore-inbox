Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264733AbUEEQwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264733AbUEEQwj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 12:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264735AbUEEQwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 12:52:39 -0400
Received: from [63.81.117.28] ([63.81.117.28]:14714 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264733AbUEEQwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 12:52:36 -0400
Message-ID: <40991A8D.5000008@xfs.org>
Date: Wed, 05 May 2004 11:47:09 -0500
From: Steve Lord <lord@xfs.org>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Dominik Karall <dominik.karall@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK)
References: <20040505013135.7689e38d.akpm@osdl.org>	<200405051312.30626.dominik.karall@gmx.net> <20040505043002.2f787285.akpm@osdl.org>
In-Reply-To: <20040505043002.2f787285.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Dominik Karall <dominik.karall@gmx.net> wrote:
> 
>>On Wednesday 05 May 2004 10:31, you wrote:
>>
>>>+make-4k-stacks-permanent.patch
>>>
>>> Fill my inbox.
>>
>>Hi Andrew!
>>
>>Is there any reason why this patch was applied? Because NVidia users can't 
>>work with the original drivers now without removing this patch every time.
>>
> 
> 
> We need to push this issue along quickly.  The single-page stack generally
> gives us a better kernel and having the stack size configurable creates
> pain.

Is it less pain than making something like a memory allocation which comes
out of a deep stack? Say, nfs server -> filesystem -> lvm/raid -> fiber channel,
which itself does something like a writepage into an nfs filesystem and ends
up in the networking stack? OK, getting back into the filesystem on a
memory allocation from the block layer should not happen, but you could
certainly be down in the bowels of the first filesystem when this happens.

There are other combinations which worry me. I do wonder how close to the
edge some of these are living now and cutting them off at the knees, stack
wise, is going to bite later. How many folks run the mm kernel in production
server environments?

Maybe there should be a competition to see how convoluted a stack you can
generate out of the kernel ;-)

Steve



