Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbTEYLLX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 07:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbTEYLLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 07:11:23 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:33171 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261847AbTEYLLQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 07:11:16 -0400
Message-ID: <3ED0A7CF.9040803@colorfullife.com>
Date: Sun, 25 May 2003 13:23:59 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
CC: Zwane Mwaikambo <zwane@linuxpower.ca>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [RFC][PATCH][2.5] Possible race in wait_task_zombie and finish_task_switch
References: <Pine.LNX.4.44.0305251226170.25774-100000@localhost.localdomain> <Pine.LNX.4.50.0305250625050.19617-100000@montezuma.mastecende.com> <3ED0A248.10308@kolumbus.fi>
In-Reply-To: <3ED0A248.10308@kolumbus.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do we have an idea which reference is miscounted? It seems that there 
are 4 different kinds of references to a task structure:

- the reference for the stack itself, acquired by setting usage to 2, 
dropped by schedule_tail.
- the reference for wait4, acquired by setting usage to 2, dropped by 
wait_task_zombie.
- references for the pid structures, maintained by pid.c
- temporary references for looking at tsk->{fs,mm,files,tty}, used by 
/proc, ptrace, tty.

>kernel BUG at kernel/sched.c:746!
>  
>
Hmm. What is schedule.c:746? There is no BUG in that area in the bk tree.

Zwane, is it easy to reproduce the crash? I could write a patch that 
adds 4 refcounters, then we could find out in which area we must look.

--
    Manfred

