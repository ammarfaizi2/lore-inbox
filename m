Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965030AbWDHR0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965030AbWDHR0h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 13:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965034AbWDHR0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 13:26:37 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:22155 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S965030AbWDHR0g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 13:26:36 -0400
Date: Sun, 9 Apr 2006 01:23:43 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rc1-mm] de_thread: fix deadlockable process addition
Message-ID: <20060408212343.GB1845@oleg>
References: <20060406220403.GA205@oleg> <m1acay1fbh.fsf@ebiederm.dsl.xmission.com> <20060407234653.GB11460@oleg> <20060407155113.37d6a3b3.akpm@osdl.org> <20060407155619.18f3c5ec.akpm@osdl.org> <m1d5fslcwx.fsf@ebiederm.dsl.xmission.com> <20060408172745.GA89@oleg> <m1r748jbju.fsf@ebiederm.dsl.xmission.com> <20060408211308.GA1845@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060408211308.GA1845@oleg>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09, Oleg Nesterov wrote:
>
> proc_task_readdir:
> 
> 	first_tid() returns old_leader
> 
> 	next_tid()  returns new_leader
> 	
> 						de_thread:
> 							old_leader->group_leader = new_leader;
> 
> 	
> 	next_rid()  returns old_leader again,
> 	because it is not thread_group_leader()
> 	anymore

I think something like this for next_tid() is sufficient:

	-	if (thread_group_leader(pos))
	+	if (pos->pid == pos->tgid)

We can also do the same change in first_tgid().

Oleg.

