Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265344AbTL0Irp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 03:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265345AbTL0Irp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 03:47:45 -0500
Received: from notes.hallinto.turkuamk.fi ([195.148.215.149]:15634 "EHLO
	notes.hallinto.turkuamk.fi") by vger.kernel.org with ESMTP
	id S265344AbTL0Irn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 03:47:43 -0500
Message-ID: <3FED4838.6050908@kolumbus.fi>
Date: Sat, 27 Dec 2003 10:52:08 +0200
From: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [PATCH] 2.6.0 batch scheduling, HT aware
References: <200312231138.21734.kernel@kolivas.org> <20031226225652.GE197@elf.ucw.cz>
In-Reply-To: <20031226225652.GE197@elf.ucw.cz>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 27.12.2003 10:49:45,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 27.12.2003 10:48:56,
	Serialize complete at 27.12.2003 10:48:56
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Pavel Machek wrote:

>Hi!
>
>  
>
>>I've done a resync and update of my batch scheduling that is also hyper-thread 
>>aware.
>>
>>What is batch scheduling? Specifying a task as batch allows it to only use cpu 
>>time if there is idle time available, rather than having a proportion of the 
>>cpu time based on niceness.
>>
>>Why do I need hyper-thread aware batch scheduling?
>>
>>If you have a hyperthread (P4HT) processor and run it as two logical cpus you 
>>can have a very low priority task running that can consume 50% of your 
>>physical cpu's capacity no matter how high priority tasks you are running. 
>>For example if you use the distributed computing client setiathome you will 
>>be effectively be running at half your cpu's speed even if you run setiathome 
>>at nice 20. Batch scheduling for normal cpus allows only idle time to be used 
>>for batch tasks, and for HT cpus only allows idle time when both logical cpus 
>>are idle.
>>    
>>
>
>BTW this is going to be an issue even on normal (non-HT)
>systems. Imagine memory-bound scientific task on CPU0 and nice -20
>memory-bound seti&home at CPU1. Even without hyperthreading, your
>scientific task is going to run at 50% of speed and seti&home is going
>to get second half. Oops.
>
>Something similar can happen with disk, but we are moving out of
>cpu-scheduler arena with that.
>
>[I do not have SMP nearby to demonstrate it, anybody wanting to
>benchmark a bit?] 
>									Pavel
>
heh...and the situation gets even worse when you add cpus, with 16way 
you get only 1/16 of the speed ;)

--Mika


