Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbWDMRxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbWDMRxR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 13:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbWDMRxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 13:53:16 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:10916 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932275AbWDMRxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 13:53:15 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] pids: simplify do_each_task_pid/while_each_task_pid
References: <20060413163727.GA1365@oleg>
	<20060413133814.GA29914@infradead.org> <20060413175431.GA108@oleg>
	<20060413150722.GA5217@infradead.org> <20060413202104.GA125@oleg>
	<20060413163205.GA7492@infradead.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 13 Apr 2006 11:50:40 -0600
In-Reply-To: <20060413163205.GA7492@infradead.org> (Christoph Hellwig's
 message of "Thu, 13 Apr 2006 17:32:05 +0100")
Message-ID: <m11ww15pqn.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> On Fri, Apr 14, 2006 at 12:21:04AM +0400, Oleg Nesterov wrote:
>> #define
> NEW_IMPROVED_HLIST_FOR_EACH_ENTRY_RCU_WHICH_DOESNT_NEED_EXTRA_PARM(pos, head,
> member) \
>> for (pos = hlist_entry((head)->first, typeof(*(pos)), member); \
>> rcu_dereference(pos) != hlist_entry(NULL, typeof(*(pos)), member) \
>> && ({ prefetch((pos)->member.next); 1; }); \
>> (pos) = hlist_entry((pos)->member.next, typeof(*(pos)), member))
>> 
>> What do you think? What should be the name for it?
>
> Justy kill the superflous argument from all hlist_for_each_entry variants
> without a name change.

Sounds like a plan.

I didn't attack this in the orignal patch that made it possible
because it would have all been noise there.

But as two independent cleanups it sounds reasonable.

Eric

