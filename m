Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267288AbTBPRcT>; Sun, 16 Feb 2003 12:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267312AbTBPRcR>; Sun, 16 Feb 2003 12:32:17 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:51902 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S267288AbTBPRcP>;
	Sun, 16 Feb 2003 12:32:15 -0500
Message-ID: <3E4FCD5A.9090608@colorfullife.com>
Date: Sun, 16 Feb 2003 18:41:46 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       Anton Blanchard <anton@samba.org>,
       Zwane Mwaikambo <zwane@holomorphy.com>
Subject: Re: Fw: 2.5.61 oops running SDET
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>OK, I did the following, which is what I think you wanted, plus Zwane's
>observation that task_state acquires the task_struct lock (we're the only 
>caller, so I just removed it), but I still get the same panic and this time
>the box hung.
>

AFAICS both exec and exit rely on write_lock_irq(tasklist_lock) for 
synchronization of changes to tsk->sig{,hand}.
I bet an __exit_sighand occurs in the middle of proc_pid_status() - 
after the NULL test, before the access in task_sig.

Martin, could you check what happens if you do not release the 
tasklist_lock until after the task_sig()?

--
    Manfred

