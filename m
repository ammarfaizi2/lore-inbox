Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263292AbUCNFre (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 00:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263293AbUCNFrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 00:47:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:63372 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263292AbUCNFqz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 00:46:55 -0500
Date: Sat, 13 Mar 2004 21:47:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alex Lyashkov <shadow@psoft.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: possible kernel bug in signal transit.
Message-Id: <20040313214700.387c4ff3.akpm@osdl.org>
In-Reply-To: <1079241668.8186.33.camel@berloga.shadowland>
References: <1079197336.13835.15.camel@berloga.shadowland>
	<20040313171856.37b32e52.akpm@osdl.org>
	<1079239159.8186.24.camel@berloga.shadowland>
	<20040313210051.6b4a2846.akpm@osdl.org>
	<1079241668.8186.33.camel@berloga.shadowland>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Lyashkov <shadow@psoft.net> wrote:
>
> > int __kill_pg_info(int sig, struct siginfo *info, pid_t pgrp)
>  > {
>  > 	struct task_struct *p;
>  > 	struct list_head *l;
>  > 	struct pid *pid;
>  > 	int retval;
>  > 	int found;
>  > 
>  > 	if (pgrp <= 0)
>  > 		return -EINVAL;
>  > 
>  > 	found = 0;
>  > 	retval = 0;
>  > 	for_each_task_pid(pgrp, PIDTYPE_PGID, p, l, pid) {
>  > 		int err;
>  > 
>  > 		found = 1;
>  > 		err = group_send_sig_info(sig, info, p);
>  > 		if (!retval)
>  > 			retval = err;
>  > 	}
>  > 	return found ? retval : -ESRCH;
>  > }
>  not. it error. At this code you save first non zero value err but other
>  been ignored.

Well we can only return one error code.  Or are you suggesting that we
should terminate the loop early on error?  If so, why?
