Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262344AbSJDUIX>; Fri, 4 Oct 2002 16:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262345AbSJDUIR>; Fri, 4 Oct 2002 16:08:17 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:2774 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262344AbSJDUIG>;
	Fri, 4 Oct 2002 16:08:06 -0400
Message-ID: <3D9DF64A.4050405@us.ibm.com>
Date: Fri, 04 Oct 2002 13:12:58 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Andrew Morton <akpm@digeo.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Benjamin LaHaise <bcrl@redhat.com>
Subject: Re: [PATCH]  4KB stack + irq stack for x86
References: <3D9DF34D.2030405@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> I fixed the problems that I was having.  thread_info->preempt_count is 
> now used to store softirq state, unlike in 2.5.20.  Preempt count was 
> not preserved once the switch to the interrupt stack occurred.  This 
> caused two nested softirqs and a deadlock.  It is fixed now.

That'll teach me to get excited and send a patch.  Sorry about the 
"Only in"'s.  I also think that there is still a small race window in 
the code that I sent.  I think that the old preempt_count need to be 
placed into the new thread_info's preempt_count _before_ the stack 
switch occurs.

-- 
Dave Hansen
haveblue@us.ibm.com

