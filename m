Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbTEYKlP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 06:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbTEYKlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 06:41:15 -0400
Received: from notes.hallinto.turkuamk.fi ([195.148.215.149]:28423 "EHLO
	notes.hallinto.turkuamk.fi") by vger.kernel.org with ESMTP
	id S261754AbTEYKlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 06:41:14 -0400
Message-ID: <3ED0A248.10308@kolumbus.fi>
Date: Sun, 25 May 2003 14:00:24 +0300
From: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linuxpower.ca>
CC: Ingo Molnar <mingo@elte.hu>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Manfred Spraul <manfred@colorfullife.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [RFC][PATCH][2.5] Possible race in wait_task_zombie and finish_task_switch
References: <Pine.LNX.4.44.0305251226170.25774-100000@localhost.localdomain> <Pine.LNX.4.50.0305250625050.19617-100000@montezuma.mastecende.com>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 25.05.2003 13:55:31,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 25.05.2003 13:55:03,
	Serialize complete at 25.05.2003 13:55:03
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Zwane Mwaikambo wrote:

>On Sun, 25 May 2003, Ingo Molnar wrote:
>
>  
>
>>On Sun, 25 May 2003, Zwane Mwaikambo wrote:
>>
>>    
>>
>>>	if (prev->state & (TASK_DEAD | TASK_ZOMBIE))
>>>		put_task_struct(prev);
>>>      
>>>
>>we initialize tsk->usage with 2 in fork() - are you sure the removal of
>>the above code will not result in a memory leak?
>>    
>>
>
>Isn't current the forked task? Also we initialise the forked task's state 
>to TASK_UNINTERRUPTIBLE.
>
>	Zwane
>  
>

The put_task_struct() above is for dropping our own reference after we 
exit. The other reference gets dropped by who is waiting for us.

--Mika


