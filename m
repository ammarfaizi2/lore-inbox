Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263632AbUESLOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263632AbUESLOR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 07:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263711AbUESLOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 07:14:16 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:39066 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263632AbUESLHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 07:07:49 -0400
Message-ID: <40AB3FE6.6040106@yahoo.com.au>
Date: Wed, 19 May 2004 21:07:18 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Muli Ben-Yehuda <mulix@mulix.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, rusty@rustcorp.com.au
Subject: Re: [PATCH] Remove bogus WARN_ON in futex_wait
References: <20040519122350.2792e050.ak@suse.de>	<20040519104339.GG31630@mulix.org> <20040519125001.3866f830.ak@suse.de>
In-Reply-To: <20040519125001.3866f830.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Wed, 19 May 2004 13:43:40 +0300
> Muli Ben-Yehuda <mulix@mulix.org> wrote:
> 
> 
>>On Wed, May 19, 2004 at 12:23:50PM +0200, Andi Kleen wrote:
>>
>>>futex_wait goes to an interruptible sleep, but does a WARN_ON later
>>>if it wakes up early. But waking up early is totally legal, since
>>>the sleep is interruptible and any signal can wake it up.
>>
>>That's not what the WARN_ON is saynig, unless I'm missing
>>something. It's checking if we were woken up early and there's no
>>signal pending for us. 
> 
> 
> True. Anyways, it seems to happen in practice.
> 

Somebody thought an early wakeup there was buggy (but harmless).
There was a patch for kernel/sched.c that was supposed to print
the source of the wakeup. I think the WARN_ON in the futex is
pretty uninteresting without the sched.c patch...
