Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262913AbTKPPfw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 10:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262925AbTKPPfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 10:35:52 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:39386 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262913AbTKPPfu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 10:35:50 -0500
Message-ID: <3FB79943.70902@colorfullife.com>
Date: Sun, 16 Nov 2003 16:35:31 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
CC: linux-kernel@vger.kernel.org, Urlich Drepper <drepper@redhat.com>,
       Michal Wronski <wrona@mat.uni.torun.pl>
Subject: Re: [PATCH] POSIX message queues - syscalls & SIGEV_THREAD
References: <Pine.GSO.4.58.0311161546260.25475@Juliusz>
In-Reply-To: <Pine.GSO.4.58.0311161546260.25475@Juliusz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Benedyczak wrote:

>+
>+/proc/fs/mqueue/max_queues  is  a  read/write  file  for  setting/getting  the
>+maximum number of message queues allowed on the system.
>+
>
Why did you add your own proc file, instead of a sysctl entry?

>+#define MQ_MAXMSG 	40	/* max number of messages in each queue */
>  
>
In the long run, this should be run time configurable. For now it 
doesn't matter, but think about that when chosing algorithms.

>+#define MQ_MAXSYSSIZE	1048576	/* max size that all m.q. can have together */
>
Dito: we must try to avoid global counters - they limit the scalability.

>+static int wq_sleep(struct mqueue_inode_info *info, int sr,
>+		    signed long timeout, struct ext_wait_queue *wq_ptr)
>+{
>
[snip]

>+		if ((current->pid == (list_entry(info->e_wait_q[sr].list.prev, struct ext_wait_queue, list))->task->pid)
>
Why current->pid? "current == ...->task" is sufficient.

>diff -urN 2.6.0-test9-orig/ipc/msg.c 2.6.0-test9-patched/ipc/msg.c
>--- 2.6.0-test9-orig/ipc/msg.c	2003-11-07 17:07:13.000000000 +0100
>+++ 2.6.0-test9-patched/ipc/msg.c	2003-11-07 18:30:17.000000000 +0100
>
>[snip: move load_msg, free_msg to util.c]
>
Could you split that into a separate patch?

--
    Manfred

