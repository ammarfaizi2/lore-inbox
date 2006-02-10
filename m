Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbWBJIRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbWBJIRF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 03:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWBJIRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 03:17:05 -0500
Received: from smtpout.mac.com ([17.250.248.44]:7118 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751186AbWBJIRE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 03:17:04 -0500
In-Reply-To: <Pine.LNX.4.58.0602100244110.20605@gandalf.stny.rr.com>
References: <20060209192510.32377.qmail@web50307.mail.yahoo.com> <383FCBAC-AB8E-4DFA-8716-D7BBF6409FDA@mac.com> <Pine.LNX.4.58.0602100244110.20605@gandalf.stny.rr.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <11B7F4E5-B3AA-4ED8-9E4A-8A32C7630F63@mac.com>
Cc: omkar lagu <omkarlagu@yahoo.com>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: How to call a function in a module from the kernel code !!! (Linux kernel)
Date: Fri, 10 Feb 2006 03:16:52 -0500
To: Steven Rostedt <rostedt@goodmis.org>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 10, 2006, at 02:55, Steven Rostedt wrote:
> On Thu, 9 Feb 2006, Kyle Moffett wrote:
>
>> It would help a lot if you could post a link to your source code.
>
> Not really.  The question is pretty straight forward, so no source  
> is really necessary.  Are you just asking this because you want to  
> stress the next point?

No, not at all!  I suspect there is possibly/probably a better way to  
do what the OP wants.  Also, the particular example of putting a  
pointer to a module function into the kernel core is quite racy and  
hard to get the locking/memory-barriers correct for, so a review of  
that part would probably be useful to the poster.

>> Let me point out (in case you don't know this already) that if you  
>> do what you describe and distribute the result, you are  
>> automatically licensing your ll.c file under the GPLv2.  By  
>> distributing a derivative of both the Linux kernel and your  
>> proprietary module (You are taking Linux kernel sources and  
>> modifying them explicitly for your module), the result must be GPL.
>
> Well, just because something is under the GPL, doesn't mean you  
> need to post a link for all to have.

Oh of course not, but that's not what I was saying.  I just wanted to  
clarify that such deep linkage into the kernel implied that the full  
terms of the GPL applied to any distribution.

>> Also, I think what you are describing is basically impossible.  I  
>> believe what you want to do is this:

Oops, this isn't what I meant to say.  I meant that it's _possible_  
but hard to get correct.

>> /* in shm.c */
>> unsigned long long (*ptr1)(int);
>> EXPORT_SYMBOL(ptr1);
>>
>> However this makes it impossible to reliably remove your module,
>> because a process could race entering the function as the module
>> loader is trying to remove the module.
>
> Not really impossible.  As I have done in my (yes GPL) logdev  
> module http://www.kihontech.com/logdev/logdev-2.6.15-rt16.patch

> I have a "hooks" file that has all the functions I need for the  
> loadable module.  But to call any of the hooks, you must call  
> wrapper functions that grabs a spinlock before calling the  
> function.  This spinlock is also used to reset the function pointer  
> when removing the module.  Yes, I know that this is inefficient,  
> but when the module is compiled into the kernel, those wrapper  
> functions also turn into direct functions without the need of the  
> spinlock, or redirected function pointers.

This is precisely why I asked the original poster to send a link to  
code (doesn't have to be the whole thing, but even just the pertinent  
snippets of the module code). You or I (or anybody else whose reading  
this thread) could easily help them verify their locking and pointer  
usage.

Cheers,
Kyle Moffett

--
I lost interest in "blade servers" when I found they didn't throw  
knives at people who weren't supposed to be in your machine room.
   -- Anthony de Boer


