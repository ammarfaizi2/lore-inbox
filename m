Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750958AbWHBBby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbWHBBby (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 21:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750961AbWHBBby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 21:31:54 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:50146 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750951AbWHBBbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 21:31:53 -0400
Subject: Re: 2.6.17-rt8 crash amd64
From: Steven Rostedt <rostedt@goodmis.org>
To: Bill Huey <billh@gnuppy.monkey.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <20060802011809.GA26313@gnuppy.monkey.org>
References: <20060802011809.GA26313@gnuppy.monkey.org>
Content-Type: text/plain
Date: Tue, 01 Aug 2006 21:31:42 -0400
Message-Id: <1154482302.30391.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-01 at 18:18 -0700, Bill Huey wrote:
> Hello folks,
> 
> I'm getting this:
> 
> [   41.989355] BUG: scheduling while atomic: udevd/0x00000001/1101
> [   41.995501]
> [   41.995502] Call Trace:
> [   41.999458]        <ffffffff8025ef65>{__schedule+155}
> [   42.004805]        <ffffffff80261702>{_raw_spin_unlock_irqrestore+72}
> [   42.011583]        <ffffffff802996c5>{task_blocks_on_rt_mutex+497}
> [   42.018095]        <ffffffff802a86a4>{free_pages_bulk+42}
> [   42.023799]        <ffffffff80291be3>{find_task_by_pid_type+24}
> [   42.030039]        <ffffffff802a86a4>{free_pages_bulk+42}
> [   42.035742]        <ffffffff8025fd89>{schedule+236}
> [   42.040907]        <ffffffff8026078f>{rt_lock_slowlock+351}
> [   42.046798]        <ffffffff80261702>{_raw_spin_unlock_irqrestore+72}
> [   42.053577]        <ffffffff8026117d>{__lock_text_start+13}
> [   42.059459]        <ffffffff802a86a4>{free_pages_bulk+42}
> [   42.065161]        <ffffffff802616e6>{_raw_spin_unlock_irqrestore+44}
> [   42.071940]        <ffffffff802a8b5a>{__free_pages_ok+428}
> [   42.077733]        <ffffffff8022e29f>{__free_pages+48}
> [   42.083168]        <ffffffff802365bb>{free_pages+133}
> [   42.088514]        <ffffffff8025a92a>{free_task+24}
> [   42.093678]        <ffffffff802474b7>{__put_task_struct+189}
> [   42.099650]        <ffffffff8025fac4>{thread_return+208}
> [   42.105264]        <ffffffff802996c5>{task_blocks_on_rt_mutex+497}
> [   42.111774]        <ffffffff8029ae98>{atomic_dec_and_spin_lock+21}
> [   42.118284]        <ffffffff80291be3>{find_task_by_pid_type+24}
> [   42.124525]        <ffffffff8029ae98>{atomic_dec_and_spin_lock+21}
> [   42.131032]        <ffffffff8025fd89>{schedule+236}
> [   42.136195]        <ffffffff8026078f>{rt_lock_slowlock+351}
> [   42.142086]        <ffffffff8026117d>{__lock_text_start+13}
> [   42.147966]        <ffffffff8029ae98>{atomic_dec_and_spin_lock+21}
> [   42.154476]        <ffffffff8020c4e9>{dput+57}
> [   42.159194]        <ffffffff802093f3>{__link_path_walk+1710}
> [   42.165166]        <ffffffff802617ad>{_raw_spin_unlock+46}
> [   42.170961]        <ffffffff8020db81>{link_path_walk+103}
> [   42.176672]        <ffffffff8020be5a>{do_path_lookup+644}
> [   42.182379]        <ffffffff80223829>{__user_walk_fd+63}
> [   42.187994]        <ffffffff8023fce4>{vfs_lstat_fd+33}
> [   42.193434]        <ffffffff8022b3e4>{sys_newlstat+34}
> [   42.198871]        <ffffffff8025ce3d>{error_exit+0}
> [   42.204040]        <ffffffff8025bf22>{system_call+126}

This back trace is definitely ugly.  Do you get this all the time? And
if so, could you compile in frame pointers and try again.  (I'll dig
through this in the mean time.) 

-- Steve

> [   42.209715] ---------------------------
> [   42.213716] | preempt count: 00000001 ]
> [   42.217715] | 1-level deep critical section nesting:
> [   42.222879] ----------------------------------------
> [   42.228043] .. [<ffffffff8025ef7d>] .... __schedule+0xb3/0xb2a
> [   42.234150] .....[<ffffffff8025fd89>] ..   ( <= schedule+0xec/0x11e)
> [   42.240796]
> [   53.347726] NET: Registered protocol family 10
> [   53.353240] IPv6 over IPv4 tunneling driver
> 
> 

