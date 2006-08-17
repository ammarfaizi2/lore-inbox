Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbWHQGaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWHQGaV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 02:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbWHQGaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 02:30:21 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:9395 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751188AbWHQGaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 02:30:19 -0400
Date: Thu, 17 Aug 2006 15:32:58 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: pj@sgi.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       acahalan@gmail.com, jdelvare@suse.de
Subject: Re: [RFC] ps command race fix
Message-Id: <20060817153258.8dfe5973.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <m11wrg0xfd.fsf@ebiederm.dsl.xmission.com>
References: <20060714203939.ddbc4918.kamezawa.hiroyu@jp.fujitsu.com>
	<20060724182000.2ab0364a.akpm@osdl.org>
	<20060724184847.3ff6be7d.pj@sgi.com>
	<20060725110835.59c13576.kamezawa.hiroyu@jp.fujitsu.com>
	<20060724193318.d57983c1.akpm@osdl.org>
	<20060725115004.a6c668ca.kamezawa.hiroyu@jp.fujitsu.com>
	<20060725121640.246a3720.kamezawa.hiroyu@jp.fujitsu.com>
	<m1mza8wqdc.fsf@ebiederm.dsl.xmission.com>
	<20060813103434.17804d52.akpm@osdl.org>
	<m1zme8v4u9.fsf@ebiederm.dsl.xmission.com>
	<20060813121222.8210ccc2.pj@sgi.com>
	<20060816102344.b393aee6.kamezawa.hiroyu@jp.fujitsu.com>
	<m11wrg0xfd.fsf@ebiederm.dsl.xmission.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2006 22:59:50 -0600
ebiederm@xmission.com (Eric W. Biederman) wrote:

> 
> So I just threw something together that seems to work.
> 
> All of the pid are listed in order and the next used pid is found by
> scanning the pid bitmap. 
> 
> Scanning the pid bitmap might be a little heavy but actually is likely
> quite cache friendly as the accesses are extremely predictable, and
> everything should fit into 64 cache lines, which is fewer cache lines
> than walking a tree, and more predictable.  Of course I turn around
> and then do a hash table lookup which is at least one more cache line
> and probably an unpredictable one at that. 
> 
> The point despite the brute force nature I have no reason to suspect
> this will run any noticeably slower than the current implementation.
> 
> Look at this try it out and if this solves the problem we can push
> this upstream.
> 
At first, Thanks.

question:

	task = get_pid_task(find_next_pid(tgid), PIDTYPE_PID);

Does this return only "task/process" ? and never return "thread" ?

My another concern is that newly-created-process while ps running cannot be catched
by this kind of "table walking" approach (as my previous work)
But if people say O.K, I have no complaint.

I(we)'ll post another list-based one in the next week, anyway.
(I can't go-ahead this week...)

-Kame

