Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbVKKUTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbVKKUTt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 15:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbVKKUTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 15:19:49 -0500
Received: from mx1.redhat.com ([66.187.233.31]:53381 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751155AbVKKUTs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 15:19:48 -0500
Message-ID: <4374FCDD.4060805@redhat.com>
Date: Fri, 11 Nov 2005 15:19:41 -0500
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.4.1 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] poll(2) timeout values
References: <437375DE.1070603@redhat.com> <1131642956.20099.39.camel@localhost.localdomain> <20051110210255.GF11266@alpha.home.local>
In-Reply-To: <20051110210255.GF11266@alpha.home.local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:

>On Thu, Nov 10, 2005 at 05:15:56PM +0000, Alan Cox wrote:
>  
>
>>On Iau, 2005-11-10 at 11:31 -0500, Peter Staubach wrote:
>>    
>>
>>>Clearly, the timeout calculations problem can be fixed without changing
>>>the arguments to the sys_poll() routine.  However, it is cleaner to fix
>>>it this way by ensuring the sizes and types of arguments match.
>>>      
>>>
>>There really is no need for the kernel API to match the userspace one,
>>many of our others differ between the syscall interface which is most
>>definitely 'exported' in one sense and the POSIX interface which is
>>defined by libc, posix and the LSB etc
>>
>>No argument about the timeout fix.
>>    
>>
>
>I posted a different fix here about a month ago (but I sent it 3 times,
>as it was twice wrong). Andrew was about to merge it in his tree but I
>have not checked yet. It was different in the sense that it used
>msecs_to_jiffies() to do the arithmetic in the best possible way depending
>on the HZ value and the ints size. Most of the time (when 1000 % HZ == 0),
>it will simplify the operations to a single divide by a constant and
>correctly check for integer overflows. Eg, with HZ=250, a simple 2 bits
>right shift will replace a multiply followed by an divide.
>
>I'll check whether 2.6.14-mm1 has it, otherwise I can repost it.
>

Yes, I remember the conversation.  I hadn't seen the final patch included
anywhere, so I posted this one.

That said, I think that msecs_to_jiffies() can still suffer from overflows
if (HZ % MSECS_PER_SEC) != 0 && (MSECS_PER_SEC % HZ) != 0.  I'd like to
see the rest of your patch to see how this was worked around.

The patch that I posted does not suffer from overflow issues.

    Thanx...

       ps
