Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319459AbSIGJBg>; Sat, 7 Sep 2002 05:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319460AbSIGJBg>; Sat, 7 Sep 2002 05:01:36 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:23715 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S319459AbSIGJBf>;
	Sat, 7 Sep 2002 05:01:35 -0400
Message-ID: <3D79C195.90004@colorfullife.com>
Date: Sat, 07 Sep 2002 11:06:29 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "Hanumanthu. H" <hanumanthu.hanok@wipro.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pid_max hang again...
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As Manfred pointed out, pid allocation and inserting it into task
> list should be atomic. But going by the range of pids available
> in 2.5.33 (Linux made it 30-bits), it is unlikely that same pid
> will be given to two processes, since last_pid is protected by
> single lock. 
Right now there is quite a lot of code between get_pid and the insertion 
into the task list: copy mm, files, etc.

And just before the endless loop in get_pid(), there is only one pid 
left --> probability of getting the same pid again is high. If you fix 
the hang, you should fix the atomicity, too.

> If last_pid is within PID_MAX and max_pid_cross is set, this
> pid might have been given to another process. So, goto the
> corresponding hashlist and check for its existence. If no task
> with given pid found, then get_pid is free to return pid as the
> available pid.

Doesn't work: find_task_by_pid() only checks task->pid. But the result 
of get_pid mustn't be in use as a session or tgid value either

--
	Manfred

