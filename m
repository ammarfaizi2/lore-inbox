Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266761AbTBQE52>; Sun, 16 Feb 2003 23:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266772AbTBQE52>; Sun, 16 Feb 2003 23:57:28 -0500
Received: from franka.aracnet.com ([216.99.193.44]:31210 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S266761AbTBQE51>; Sun, 16 Feb 2003 23:57:27 -0500
Date: Sun, 16 Feb 2003 21:07:06 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Manfred Spraul <manfred@colorfullife.com>,
       Anton Blanchard <anton@samba.org>, Andrew Morton <akpm@digeo.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@holomorphy.com>
Subject: Re: more signal locking bugs?
Message-ID: <75430000.1045458425@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.44.0302161951580.1424-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0302161951580.1424-100000@home.transmeta.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Ah, I see what happened, I think .... the locking used to be inside
>> collect_sigign_sigcatch, and you moved it out into task_sig ... but 
>> there were two callers of collect_sigign_sigcatch, the other one being
>> proc_pid_stat
> 
> Doh.
> 
> This should fix it. 

Don't you need this bit as well?

+	sigemptyset(&sigign);
+	sigemptyset(&sigcatch);

to replace this bit from your previous patch.

 static void collect_sigign_sigcatch(struct task_struct *p, sigset_t *ign,
                                    sigset_t *catch)
 {
        struct k_sigaction *k;
        int i;
 
-       sigemptyset(ign);
-       sigemptyset(catch);

That was in the patch I sent you ... but I missed task->sighand->siglock ;-)

M.

