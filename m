Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317493AbSFRQ6b>; Tue, 18 Jun 2002 12:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317494AbSFRQ6a>; Tue, 18 Jun 2002 12:58:30 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:65498 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S317493AbSFRQ63>; Tue, 18 Jun 2002 12:58:29 -0400
Message-ID: <3D0F669C.89596EC0@nortelnetworks.com>
Date: Tue, 18 Jun 2002 12:58:04 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Schwartz <davids@webmaster.com>
Cc: rml@tech9.net, mgix@mgix.com, linux-kernel@vger.kernel.org
Subject: Re: Question about sched_yield()
References: <20020618093644.AAA9337@shell.webmaster.com@whenever>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Schwartz wrote:
> 
> >And you seem to have a misconception about sched_yield, too.  If a
> >machine has n tasks, half of which are doing CPU-intense work and the
> >other half of which are just yielding... why on Earth would the yielding
> >tasks get any noticeable amount of CPU use?
> 
>         Because they are not blocking. They are in an endless CPU burning loop. They
> should get CPU use for the same reason they should get CPU use if they're the
> only threads running. They are always ready-to-run.
> 
> >Quite frankly, even if the supposed standard says nothing of this... I
> >do not care: calling sched_yield in a loop should not show up as a CPU
> >hog.
> 
>         It has to. What if the only task running is:
> 
>         while(1) sched_yield();
> 
>         What would you expect?

If there is only the one task, then sure it's going to be 100% cpu on that task.

However, if there is anything else other than the idle task that wants to run,
then it should run until it exhausts its timeslice.

One process looping on sched_yield() and another one doing calculations should
result in almost the entire system being devoted to calculations.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
