Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbWDJWNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWDJWNY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 18:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWDJWNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 18:13:24 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:63723 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751213AbWDJWNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 18:13:23 -0400
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rc1-mm] de_thread: fix deadlockable process addition
References: <20060406220403.GA205@oleg>
	<m1acay1fbh.fsf@ebiederm.dsl.xmission.com>
	<20060407234653.GB11460@oleg> <20060407155113.37d6a3b3.akpm@osdl.org>
	<20060407155619.18f3c5ec.akpm@osdl.org>
	<m1d5fslcwx.fsf@ebiederm.dsl.xmission.com> <20060408172745.GA89@oleg>
	<m1r748jbju.fsf@ebiederm.dsl.xmission.com>
	<20060408211308.GA1845@oleg> <20060408212343.GB1845@oleg>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 10 Apr 2006 16:11:56 -0600
In-Reply-To: <20060408212343.GB1845@oleg> (Oleg Nesterov's message of "Sun,
 9 Apr 2006 01:23:43 +0400")
Message-ID: <m17j5xf5cj.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> writes:

> On 04/09, Oleg Nesterov wrote:
>>
>> proc_task_readdir:
>> 
>> 	first_tid() returns old_leader
>> 
>> 	next_tid()  returns new_leader
>> 	
>> 						de_thread:
>> old_leader->group_leader = new_leader;
>> 
>> 	
>> 	next_rid()  returns old_leader again,
>> 	because it is not thread_group_leader()
>> 	anymore
>
> I think something like this for next_tid() is sufficient:
>
> 	-	if (thread_group_leader(pos))
> 	+	if (pos->pid == pos->tgid)
>
> We can also do the same change in first_tgid().

But the loop will terminate when things settle down,
and we can always use my original test of pos == start->group_leader.

I was worried about the stable kernel case and next_tid was
such a generic name I failed to associate it with /proc.

Short of confusion (and de_thread invariably introduces that)
I don't see anything that the code will actually do wrong.

Eric
