Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbTEVQIZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 12:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262710AbTEVQIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 12:08:25 -0400
Received: from mail.gmx.de ([213.165.64.20]:59406 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262709AbTEVQIX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 12:08:23 -0400
Message-Id: <5.2.0.9.2.20030522181509.00cc4338@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Thu, 22 May 2003 18:25:54 +0200
To: davidm@hpl.hp.com
From: Mike Galbraith <efault@gmx.de>
Subject: Re: web page on O(1) scheduler
Cc: linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org
In-Reply-To: <5.2.0.9.2.20030522114349.00cfd8f8@pop.gmx.net>
References: <16075.48579.189593.405154@napali.hpl.hp.com>
 <5.2.0.9.2.20030521111037.01ed0d58@pop.gmx.net>
 <16075.8557.309002.866895@napali.hpl.hp.com>
 <5.2.0.9.2.20030521111037.01ed0d58@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:52 AM 5/22/2003 +0200, Mike Galbraith wrote:
>At 10:56 AM 5/21/2003 -0700, David Mosberger wrote:
>> >>>>> On Wed, 21 May 2003 11:26:31 +0200, Mike Galbraith <efault@gmx.de> 
>> said:
>>
>>   Mike> The page mentions persistent starvation.  My own explorations
>>   Mike> of this issue indicate that the primary source is always
>>   Mike> selecting the highest priority queue.
>>
>>My working assumption is that the problem is a bug with the dynamic
>>prioritization.  The task receiving the signals calls sleep() after
>>handling a signal and hence it's dynamic priority should end up higher
>>than the priority of the task sending signals (since the sender never
>>relinquishes the CPU voluntarily).
>>
>>However, I haven't actually had time to look at the relevant code, so
>>I may be missing something.  If you understand the issue better,
>>please explain to me why this isn't a dynamic priority issue.
>
>You're right, it looks like a corner case.

Out of curiosity, is someone hitting that with a real program?

         -Mike

aside:
if so, I suppose nano-ticks may be needed.  rounding up gave us too many 
"nano-ticks", and was the first problem with irman, which brought round 
down into activate_task().  now, test-starve.c appears, and it turns out to 
be too many nano-ticks _missing_.  (rounding up doesn't "fix" that one btw 
[too fast], but what I did to demonstrate the problem does re-break irman 
rather nicely:) 

