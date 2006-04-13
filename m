Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964937AbWDMN5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964937AbWDMN5Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 09:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964928AbWDMN5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 09:57:24 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:9944 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S964937AbWDMN5X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 09:57:23 -0400
Date: Thu, 13 Apr 2006 21:54:31 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pids: simplify do_each_task_pid/while_each_task_pid
Message-ID: <20060413175431.GA108@oleg>
References: <20060413163727.GA1365@oleg> <20060413133814.GA29914@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060413133814.GA29914@infradead.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/13, Christoph Hellwig wrote:
>
> On Thu, Apr 13, 2006 at 08:37:27PM +0400, Oleg Nesterov wrote:
> > +#define do_each_task_pid(who, type, task)					\
> > +	do {									\
> > +		struct hlist_node *pos___;					\
> > +		struct pid *pid___ = find_pid(who);				\
> > +		if (pid___ != NULL)						\
> > +			hlist_for_each_entry_rcu((task), pos___,		\
> > +				&pid___->tasks[type], pids[type].node) {
> > +
> > +#define while_each_task_pid(who, type, task)					\
> > +			}							\
> > +	} while (0)
> 
> This is prtty ugly.  Can't we just have a
> 
> #define for_each_task_pid(task, pid, type, pos) \
> 	hlist_for_each_entry_rcu((task), (pos),  \
> 		(&(pid))->tasks[type], pids[type].node) {
> 
> and move the find_pid to the caller?  That would make the code a whole lot
> more readable.

Then the caller should check find_pid() doesn't return NULL. But yes,
we can hide this check inside for_each_task_pid().

But what about current users of do_each_task_pid ? We can't just remove
these macros.

Oleg.

