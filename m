Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263831AbTCVUek>; Sat, 22 Mar 2003 15:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263833AbTCVUek>; Sat, 22 Mar 2003 15:34:40 -0500
Received: from packet.digeo.com ([12.110.80.53]:42730 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263831AbTCVUei>;
	Sat, 22 Mar 2003 15:34:38 -0500
Date: Sat, 22 Mar 2003 12:44:47 -0800
From: Andrew Morton <akpm@digeo.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: zwane@holomorphy.com, linux-kernel@vger.kernel.org, jochen@jochen.org
Subject: Re: BUG: Use after free in detach_pid
Message-Id: <20030322124447.59c6b4c3.akpm@digeo.com>
In-Reply-To: <3E7CC4F2.8000500@colorfullife.com>
References: <Pine.LNX.4.50.0303221152460.18911-100000@montezuma.mastecende.com>
	<3E7CC4F2.8000500@colorfullife.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Mar 2003 20:44:48.0824 (UTC) FILETIME=[E1395B80:01C2F0B3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul <manfred@colorfullife.com> wrote:
>
> You mentioned that the last detach_pid() within __unhash_process oopsed. That means the reference count of the task structure was off by one, and the
> 	put_task_struct(pid->task)
> within 
> 	detach_pid(p,PIDTYPE_PGID);
> freed the task structure.
> 

Might be related to http://bugme.osdl.org/show_bug.cgi?id=482
in which someone did put_task_struct() on an already-freed task_struct.

And that was a uniprocessor without pgcl gunk.

It is not known whether preemption was enabled?

