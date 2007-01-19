Return-Path: <linux-kernel-owner+w=401wt.eu-S964865AbXASVXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbXASVXw (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 16:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbXASVXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 16:23:52 -0500
Received: from mail.tmr.com ([64.65.253.246]:48767 "EHLO gaimboi.tmr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964865AbXASVXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 16:23:52 -0500
Message-ID: <45B1378E.9070701@tmr.com>
Date: Fri, 19 Jan 2007 16:26:38 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061105 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Brian McGrew <brian@visionpro.com>
CC: linux-kernel@vger.kernel.org, fedora-users@rdhat.com
Subject: Re: Threading...
References: <1169232941.3055.555.camel@laptopd505.fenrus.org> <C1D65587.16E59%brian@visionpro.com>
In-Reply-To: <C1D65587.16E59%brian@visionpro.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian McGrew wrote:
> On 1/19/07 10:55 AM, "Arjan van de Ven" <arjan@infradead.org> wrote:
>> On Fri, 2007-01-19 at 10:43 -0800, Brian McGrew wrote:
>>> I have a very interesting question about something that we're seeing
>>> happening with threading between Fedora Core 3 and Fedora Core 5.  Running
>>> on Dell PowerEdge 1800 Hardware with a Xeon processor with hyper-threading
>>> turned on.  Both systems are using a 2.6.16.16 kernel (MVP al la special).
>>>
>>> We have a multithreaded application that starts two worker threads.  On
>>> Fedora Core 3 both of these we use getpid() to get the PID of the thread and
>>> then use set_afinity to assign each thread to it's own CPU.  Both threads
>>> run almost symmetrically even on their given CPU watching the system
>>> monitor.
>> this is odd; even in FC3 getpid() is supposed to return the process ID
>> not the thread ID
>>
>>> What am I missing?  What do I need to do in FC5 or the kernel or the
>>> threading library to get my threads to run in symmetric parallel again???
>> you should fix the app to use something like pthread_self() instead...
>> (or the highly unportable gettid() but that would just be horrible)
> -----
> 
> And on FC5 I am using pthread_self but my problem isn't simply with
> pthread_self, it's with the scheduling.  On FC3 both threads run
> simultaneously in almost symmetric parallel.  On FC5 one thread don't pick
> up and start until the previous one is done.  On FC3, using getpid for the
> thread I could use set_afinity to force each thread to its own processor and
> with FC5 I can't; so I've got one idle processor all the time.
> 
This sounds so unlikely I hesitate to mention it, but you are not, by 
any chance, running pthreads on one and nptl on the other, are you?

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
