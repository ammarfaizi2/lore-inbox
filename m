Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750995AbWHPIB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbWHPIB7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 04:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750993AbWHPIB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 04:01:59 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:48569 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750760AbWHPIB6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 04:01:58 -0400
Message-ID: <44E2D175.1010506@sw.ru>
Date: Wed, 16 Aug 2006 12:04:05 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, containers@lists.osdl.org,
       linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [Containers] [PATCH 6/7] vt: Update spawnpid to be a struct	pid_t
References: <m1k65997xk.fsf@ebiederm.dsl.xmission.com>	<1155666193191-git-send-email-ebiederm@xmission.com>	<1155667982.24077.307.camel@localhost.localdomain> <m13bbx96tm.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m13bbx96tm.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> 
> 
>>Ar Maw, 2006-08-15 am 12:23 -0600, ysgrifennodd Eric W. Biederman:
>>
>>>This keeps the wrong process from being notified if the
>>>daemon to spawn a new console dies.
>>
>>Not sure why we count pids not task structs but within the proposed
>>implementation this appears correct so
> 
> 
> Basically struct pid is relatively cheap, 64bytes or so.
> struct task is expensive 10K or so, when all of the stacks
> and everything are included.
> 
> Counting pids allows the task to exit in user space and free up
> all of it's memory.
> 
> When /proc used to count the task struct it was fairly easy to
> deliberately oom a 32bit machine just by open up directories in
> /proc and then having the process exit.  rlimits didn't help because
> we don't count processes that have exited.
hey, hey. your patch doesn't help in this situation (much)!
inodes and dentries can still consume much memory.
it just makes the situation a bit better.

I wonder whether it is easy to have the following done with your implementation:
container tasks visible from host. theoretically having 2 pids (vpid, pid)
it should be implementable. Do you see any obstacles?

in other regards patches look pretty good. Good job!

Kirill

