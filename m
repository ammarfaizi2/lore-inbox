Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbWAaGNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbWAaGNI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 01:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbWAaGNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 01:13:08 -0500
Received: from 7ka-campus-gw.mipt.ru ([194.85.83.97]:55807 "EHLO
	7ka-campus-gw.mipt.ru") by vger.kernel.org with ESMTP
	id S932395AbWAaGNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 01:13:07 -0500
Message-ID: <43DEFFB7.6010404@sw.ru>
Date: Tue, 31 Jan 2006 09:12:07 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Oleg Nesterov <oleg@tv-sign.ru>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/3] pidhash: don't use zero pids
References: <43DDF323.4517C349@tv-sign.ru> <m1r76p5u7m.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1r76p5u7m.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Oleg,

I had quite the same comment, but had no time to check it.
I can't understand what problem do you solve, or just making code 
cleaner (from your point of view)?
For me it was quite natural that pid=0 is used by idle, and I'm very 
suspicuos about such changes.

Kirill

> Oleg Nesterov <oleg@tv-sign.ru> writes:
> 
>> daemonize() calls set_special_pids(1,1), while init and
>> kernel threads spawned from init/main.c:init() run with
>> 0,0 special pids. This patch changes INIT_SIGNALS() so
>> that that they run with ->pgrp == ->session == 1 also.
>>
>> This patch relies on fact that swapper's pid == 1.
>>
>> Now we never use pid == 0 in kernel/pid.c.
> 
> This changes what is visible to user space, for the case
> where we are not a member of a session of a process group.
> 
> By hashing the values these non-groups become available to
> user space.  Which I find disturbing.  Before I can comment
> further I need to see if there are any well defined semantics
> for processes that are not part of a session or a process
> group.  If there are well defined semantics we have just
> broken user space.
> 
> Eric
> 
