Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265983AbUG0ADZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265983AbUG0ADZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 20:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266187AbUG0ADZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 20:03:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:18856 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265983AbUG0ADX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 20:03:23 -0400
Date: Mon, 26 Jul 2004 17:01:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nathan Lynch <nathanl@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: [PATCH] fixes for rcu_offline_cpu, rcu_move_batch (2.6.8-rc2)
Message-Id: <20040726170157.7f4b414c.akpm@osdl.org>
In-Reply-To: <1090870667.22306.40.camel@pants.austin.ibm.com>
References: <1090870667.22306.40.camel@pants.austin.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Lynch <nathanl@austin.ibm.com> wrote:
>
> Hi,
> 
> rcu_offline_cpu and rcu_move_batch have been broken since the
> list_head's in struct rcu_head and struct rcu_data were replaced with
> singly-linked lists:
> 
>   CC      kernel/rcupdate.o
> kernel/rcupdate.c: In function `rcu_move_batch':
> kernel/rcupdate.c:222: warning: passing arg 2 of `list_add_tail' from
> incompatible pointer type
> kernel/rcupdate.c: In function `rcu_offline_cpu':
> kernel/rcupdate.c:239: warning: passing arg 1 of `rcu_move_batch' from
> incompatible pointer type
> kernel/rcupdate.c:240: warning: passing arg 1 of `rcu_move_batch' from
> incompatible pointer type
> kernel/rcupdate.c:236: warning: label `unlock' defined but not used

oop.  We really should find some way to get more people to enable CPU
hotplug.  We have a coverage problem.

> Kernel crashes when you try to offline a cpu, not surprisingly.
> 
> It also looks like rcu_move_batch isn't preempt-safe so I touched that
> up, and got rid of an unused label in rcu_offline_cpu.
> 
> This fixes the crash for me; does it look ok?
> 

Looks good to me, thanks.

