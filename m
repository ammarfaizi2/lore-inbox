Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267559AbTBPVMH>; Sun, 16 Feb 2003 16:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267560AbTBPVMH>; Sun, 16 Feb 2003 16:12:07 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:29119 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S267559AbTBPVMH>;
	Sun, 16 Feb 2003 16:12:07 -0500
Message-ID: <3E5000E8.1030406@colorfullife.com>
Date: Sun, 16 Feb 2003 22:21:44 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Linus Torvalds <torvalds@transmeta.com>, Anton Blanchard <anton@samba.org>,
       Andrew Morton <akpm@digeo.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@holomorphy.com>
Subject: Re: Fw: 2.5.61 oops running SDET
References: <Pine.LNX.4.44.0302161115290.2874-100000@home.transmeta.com> <30110000.1045430104@[10.10.2.4]>
In-Reply-To: <30110000.1045430104@[10.10.2.4]>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:

>diff -urpN -X /home/fletch/.diff.exclude virgin/fs/proc/array.c sdet3/fs/proc/array.c
>--- virgin/fs/proc/array.c	Sat Feb 15 16:11:45 2003
>+++ sdet3/fs/proc/array.c	Sun Feb 16 11:44:24 2003
>@@ -252,8 +252,11 @@ int proc_pid_status(struct task_struct *
> 		buffer = task_mem(mm, buffer);
> 		mmput(mm);
> 	}
>-	buffer = task_sig(task, buffer);
>+	task_lock(task);
>+	if (task->sighand)
>+		buffer = task_sig(task, buffer);
> 	buffer = task_cap(task, buffer);
>+	task_unlock(task);
> #if defined(CONFIG_ARCH_S390)
> 	buffer = task_show_regs(task, buffer);
> #endif
>  
>
I think it's needed for 2.4, too.

--
    Manfred

