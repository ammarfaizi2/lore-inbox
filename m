Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316842AbSIGPFq>; Sat, 7 Sep 2002 11:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317772AbSIGPFq>; Sat, 7 Sep 2002 11:05:46 -0400
Received: from smtpout.mac.com ([204.179.120.88]:53225 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S316842AbSIGPFC>;
	Sat, 7 Sep 2002 11:05:02 -0400
Date: Sat, 7 Sep 2002 16:39:34 +0200
Subject: Re: [PATCH] POSIX message queues
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
Cc: linux-kernel@vger.kernel.org, Michal Wronski <wrona@mat.uni.torun.pl>
To: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
From: pwaechtler@mac.com
In-Reply-To: <Pine.GSO.4.40.0208311440520.7165-100000@ultra60>
Message-Id: <A07E0BF5-C26F-11D6-87AD-00039387C942@mac.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag den, 31. August 2002, um 14:53, schrieb Krzysztof Benedyczak:

> On Thu, 29 Aug 2002 pwaechtler@mac.com wrote:
>>
>> When implemented in kernel space, you have to create a thread with the
>> brand new
>> sys_clone_startup (or whatever name it gets) as notification
>> (SIGEV_THREAD) - which
>> is SCOPE_SYSTEM, no control about this and not always what is desired.
> I don't fully understand it. Can you explain it in more details?
>
Yes, sounds weird.

The app requests a SIGEV_THREAD for when a new message arrives.
It stores the threads function pointer into the structure that is past 
into the kernel.

If you do not provide some sort of demultiplexer in userspace, the kernel
has to create the thread. But unlike fork() the thread is started 
asyncronously
- no code in userspace is there to recognize that. With that the thread 
scheduler
in userspace does not know about this thread.

If you want to create a "userspace thread", scheduled by NGPTs scheduler,
NGPT has to provide support for this. For this you would need a 
registry, so when
the event is triggered (and a signal with siginfo_t sent to the thread 
group)- a new
thread could be spawned by the NGPT scheduler itself.

