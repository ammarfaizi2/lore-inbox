Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932338AbWHRDyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbWHRDyW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 23:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbWHRDyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 23:54:22 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:64984 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932338AbWHRDyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 23:54:22 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: pj@sgi.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       acahalan@gmail.com, jdelvare@suse.de
Subject: Re: [RFC] ps command race fix
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
	<20060817153258.8dfe5973.kamezawa.hiroyu@jp.fujitsu.com>
Date: Thu, 17 Aug 2006 21:53:50 -0600
In-Reply-To: <20060817153258.8dfe5973.kamezawa.hiroyu@jp.fujitsu.com>
	(KAMEZAWA Hiroyuki's message of "Thu, 17 Aug 2006 15:32:58 +0900")
Message-ID: <m1k656ya0h.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hmm...  I forgot to hit send.

KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> writes:

> At first, Thanks.
>
> question:
>
> 	task = get_pid_task(find_next_pid(tgid), PIDTYPE_PID);
>
> Does this return only "task/process" ? and never return "thread" ?

Good point.  I don't think I'm filter for thread group leaders here.
That should take a couple more lines of code.

> My another concern is that newly-created-process while ps running cannot be
> catched
> by this kind of "table walking" approach (as my previous work)
> But if people say O.K, I have no complaint.

Well it can but only if the newly created processes have a higher pid.

The guarantee that POSIX readdir makes is that you will see all directory
entries that are neither added nor deleted during the readdir.

> I(we)'ll post another list-based one in the next week, anyway.
> (I can't go-ahead this week...)

Where I see what I'm doing as being superior to that is that I'm
not writing to any global data structures.  Which means what I'm doing
should scale to large machines without problem.

Eric
