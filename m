Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267321AbTBPSgS>; Sun, 16 Feb 2003 13:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267322AbTBPSgS>; Sun, 16 Feb 2003 13:36:18 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:10431 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S267321AbTBPSgS>;
	Sun, 16 Feb 2003 13:36:18 -0500
Message-ID: <3E4FDC61.8060301@colorfullife.com>
Date: Sun, 16 Feb 2003 19:45:53 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org,
       Anton Blanchard <anton@samba.org>,
       Zwane Mwaikambo <zwane@holomorphy.com>
Subject: Re: Fw: 2.5.61 oops running SDET
References: <Pine.LNX.4.44.0302161013560.2619-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0302161013560.2619-100000@home.transmeta.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Sun, 16 Feb 2003, Manfred Spraul wrote:
>  
>
>>AFAICS both exec and exit rely on write_lock_irq(tasklist_lock) for 
>>synchronization of changes to tsk->sig{,hand}.
>>    
>>
>
>Yeah, as I sent out in my last email this does seem to be true right now, 
>but it's really not correct. It's disgusting that we use such a 
>fundamental global lock to protect something so trivially local to the one 
>process, where the local per-process lock really should be more than 
>enough.
>
The difference between the tasklist_lock and task_lock is that task_lock 
is not an interrupt lock.
Think about signal delivery during exec.

Do you want to replace tasklist_lock with task_lock in exit_sighand() 
and during exec, or do you want to add task_lock to tasklist_lock?

Hmm.
Someone removed the read_lock(tasklist_lock) around 
send_specific_sig_info() - which lock synchronizes exec and signal delivery?

--
    Manfred

